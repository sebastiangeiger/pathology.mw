require 'rails_helper'

RSpec.describe Patient, :type => :model do
  describe 'validations' do
    describe 'for names' do
      it 'works fine for normal names' do
        expect(FactoryGirl.build(:patient)).to be_valid
      end
      it 'shuts down empty first names' do
        expect(FactoryGirl.build(:patient, first_name: '')).to be_invalid
      end
    end
    describe 'for gender' do
      it 'denies nil gender' do
        expect(FactoryGirl.build(:patient, gender: nil)).to be_invalid
      end
      it 'accepts lowercase gender' do
        expect(FactoryGirl.build(:patient, gender: "male")).to be_valid
      end
    end
    describe 'for birthday' do
      it 'denies nil date' do
        expect(FactoryGirl.build(:patient, birthday: nil)).to be_invalid
      end
      it 'denies random text' do
        expect(FactoryGirl.build(:patient, birthday: "Something")).to be_invalid
      end
    end
  end
end
