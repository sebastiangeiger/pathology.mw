require 'rails_helper'

RSpec.describe Patient, :type => :model do
  describe 'validations' do
    it 'works fine for normal names' do
      expect(Patient.new(first_name: 'Anne', last_name: 'Moore')).to be_valid
    end
    it 'shuts down empty first names' do
      expect(Patient.new(first_name: '', last_name: 'Moore')).to be_invalid
    end
  end
end
