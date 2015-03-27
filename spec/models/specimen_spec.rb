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

  describe 'pathology_number' do
    it "accepts 2014-QT-32" do
      expect(FactoryGirl.build(:specimen, pathology_number: "2014-QT-32")).to be_valid
    end
    it "rejects 12345" do
      expect(FactoryGirl.build(:specimen, pathology_number: "12345")).to be_invalid
    end
    it "rejects 12345-" do
      expect(FactoryGirl.build(:specimen, pathology_number: "12345-")).to be_invalid
    end
    it "accepts 2014-32" do
      expect(FactoryGirl.build(:specimen, pathology_number: "2014-32")).to be_valid
    end
    it 'converts 2014-32 to 2014-QT-32' do
      specimen = FactoryGirl.build(:specimen, pathology_number: "2014-32")
      expect(specimen.pathology_number).to eql "2014-QT-32"
    end
    it 'defaults to the "CurrentYear-QT-"' do
      Timecop.freeze(Time.local(2014, 9, 1))
      specimen = Specimen.new
      expect(specimen.pathology_number).to eql "2014-QT-"
      Timecop.return
    end
  end
end
