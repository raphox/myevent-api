class MyEventAutocompleteSerializer < ActiveModel::Serializer
  type :my_events
  attributes :key, :label

  def key
    object.id.to_s
  end

  def label
    "#{object.event_type.upcase}: #{object.url || '<unknow>'}"
  end
end
