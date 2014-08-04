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
    describe 'for age indicator' do
      it 'denies nil date' do
        expect(FactoryGirl.build(:patient, birthday: nil,
                                           birthyear: nil)).to be_invalid
      end
      it 'denies random text as birthday' do
        expect(FactoryGirl.build(:patient, birthday: "Something",
                                           birthyear: nil)).to be_invalid
      end
      it 'accepts a date string as birthday' do
        expect(FactoryGirl.build(:patient, birthday: "June 16 1984",
                                           birthyear: nil)).to be_valid
      end
      it 'accepts a number as birthyear' do
        expect(FactoryGirl.build(:patient, birthday: nil,
                                           birthyear: 1984)).to be_valid
      end
      it 'accepts a string as birthyear' do
        expect(FactoryGirl.build(:patient, birthday: nil,
                                           birthyear: "1984-01-01")).to be_valid
      end
    end
  end

  describe '#detailed_age' do
    subject { patient.detailed_age }
    let(:patient) do
      FactoryGirl.build(:patient, birthday: birthday, birthyear: birthyear)
    end
    let(:birthday) { nil }
    let(:birthyear) { nil }
    context 'with birthday on June 16 1984' do
      let(:birthday) { "June 16 1984" }
      it { is_expected.to eql "30 (born June 16 1984)" }
    end
    context 'with birthyear 1984' do
      let(:birthyear) { "January 01 1984" }
      it { is_expected.to eql "30 (born in 1984)" }
    end
  end
end
