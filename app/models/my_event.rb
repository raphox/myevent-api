require 'resolv'

class MyEvent
  include Mongoid::Document
  include Mongoid::Timestamps
  include Elasticsearch::Model

  field :event_type, type: String
  field :referer, type: Hash
  field :remote_ip, type: String

  after_save    { IndexerWorker.perform_async(:index,  self.id) }
  after_destroy { IndexerWorker.perform_async(:delete, self.id) }

  module TYPES
    ALL = %w(get post put patch delete options head)
    GET, POST, PUT, PATCH, DELETE, OPTIONS, HEAD = ALL
  end

  validates :event_type, inclusion: { in: TYPES::ALL }
  validates :remote_ip, format: { :with => Resolv::IPv4::Regex }, allow_blank: true

  # Receive HTTP request object and set attributes
  def request=(request)
    return unless request

    self.remote_ip = request.remote_ip
    self.event_type = request.request_method.to_s.downcase.to_sym

    # URI constructor class convert referer URL into an object
    # https://ruby-doc.org/stdlib-2.4.2/libdoc/uri/rdoc/URI.html#module-URI-label-Basic+example
    if request.referer
      uri = URI(request.referer)

      write_attribute(:referer, {
        scheme: uri.scheme,
        host: uri.host,
        path: uri.path,
        query: uri.query,
        fragment: uri.fragment
      })
    end
  end

  def url
    self.referer && [self.referer[:scheme], '://', self.referer[:host],
      self.referer[:path], self.referer[:query], self.referer[:fragment]].compact.join('')
  end

  def as_indexed_json(options={})
    as_json(except: [:id, :_id])
  end
end
