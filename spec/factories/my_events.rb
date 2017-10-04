require 'faker'

FactoryGirl.define do
  factory :my_event do
    event_type MyEvent::TYPES::ALL.sample
    referer do
      uri = URI(Faker::Internet.url)
      {
        scheme: uri.scheme,
        host: uri.host,
        path: uri.path,
        query: uri.query,
        fragment: uri.fragment
      }
    end
    remote_ip Faker::Internet.ip_v4_address
  end
end
