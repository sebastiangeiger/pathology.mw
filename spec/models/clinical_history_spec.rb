require 'rails_helper'

RSpec.describe ClinicalHistory, :type => :model do
  describe 'factory' do
    it 'has a patient' do
      expect(FactoryGirl.create(:clinical_history).patient).to be_a Patient
    end
  end
end
