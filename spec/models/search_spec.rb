require 'rails_helper'

RSpec.describe Search, :type => :model do
  describe 'minimum_age' do
    it 'stores a number' do
      expect(Search.new({minimum_age: "32"}).minimum_age).to eql 32
    end
    it 'ignores empty strings' do
      expect(Search.new({minimum_age: ""}).minimum_age).to eql nil
    end
  end
end
