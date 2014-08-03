require 'rails_helper'

RSpec.describe Specimen, :type => :model do
  describe 'factory' do
    it 'has a clinical_history' do
      expect(FactoryGirl.create(:specimen).clinical_history).to be_present
    end
    it 'has a patient' do
      expect(FactoryGirl.create(:specimen).patient).to be_present
    end
  end
end
