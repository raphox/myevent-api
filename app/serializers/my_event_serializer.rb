class MyEventSerializer < ActiveModel::Serializer
  attributes :id, :event_type, :referer, :remote_ip
end
