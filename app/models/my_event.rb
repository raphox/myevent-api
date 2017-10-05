require 'resolv'

class MyEvent
  include Mongoid::Document
  include Mongoid::Timestamps
  include Elasticsearch::Model

  field :event_type, type: String
  field :referer, type: Hash
  field :remote_ip, type: String

  # Define Elasticsearch settings
  settings index: {
    :number_of_shards => 1,
    analysis: {
      analyzer: {
          default: {
            type: "custom",
            tokenizer: "whitespace",
            filter: ["lowercase", "asciifolding"] # discard lowercase and special chars
          }
      }
    }
  } do
    mapping dynamic: 'false' do
      indexes :event_type, analyzer: 'default', type: 'string'
      indexes :url, analyzer: 'default', type: 'string'
      indexes :referer, type: 'object'
      indexes :remote_ip, analyzer: 'default', type: 'string'
    end
  end

  # Collect data to store on Elasticsearch
  def as_indexed_json(options={})
    as_json(except: [:id, :_id]).merge(url: self.url)
  end

  # Call background process to create index on Elasticsearch
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
    self.referer && [self.referer['scheme'], '://', self.referer['host'],
      self.referer['path'], self.referer['query'], self.referer['fragment']].compact.join('')
  end

  # Intance a new object from an Elasticsearch result
  def self.new_from_index(result)
    self.new(result._source.to_hash.except('url').merge({ id: result._id }))
  end
end
