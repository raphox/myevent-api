require 'rails_helper'

RSpec.describe MyEvent, type: :model do
  let(:resource) { build(:my_event) }

  describe '#validation' do
    it "is valid with valid attributes" do
      expect(resource).to be_valid
    end

    it "is not valid without a event_type" do
      resource.event_type = "foo"
      expect(resource).to_not be_valid
    end

    it "is not valid without a remote_ip" do
      resource.remote_ip = "bar"
      expect(resource).to_not be_valid
    end
  end

  describe '#request' do
    it "valid" do
      request = OpenStruct.new
      request.referer = 'http://www.test.com/foo?bar=null#anchor'
      request.remote_ip = '192.168.0.1'
      request.request_method = 'POST'

      resource.request = request

      expect(resource.referer).to eq({
        scheme: 'http',
        host: 'www.test.com',
        path: '/foo',
        query: 'bar=null',
        fragment: 'anchor'
      })
    end

    it "should raise" do
      expect{resource.request = 'http://www.test.com/foo?bar=null#anchor'}.to raise_error(NoMethodError)
    end
  end
end
