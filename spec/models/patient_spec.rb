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
      it 'denies birthday and year being nil' do
        expect(FactoryGirl.build(:patient, birthday: nil,
                                           birthyear: nil)).to be_invalid
      end
      it 'allows birthday and year being nil when birthday_unknown is set' do
        expect(FactoryGirl.build(:patient, birthday: nil,
                                           birthyear: nil,
                                           birthday_unknown: true)).to be_valid
      end
      it 'allows birthday and year being nil when birthday_unknown is set to 1' do
        expect(FactoryGirl.build(:patient, birthday: nil,
                                           birthyear: nil,
                                           birthday_unknown: "1")).to be_valid
      end
      it 'denies birthday and year being nil when birthday_unknown is set to 0' do
        expect(FactoryGirl.build(:patient, birthday: nil,
                                           birthyear: nil,
                                           birthday_unknown: "0")).to be_invalid
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
                                           birthyear: "1984")).to be_valid
      end
    end
  end

  describe '#detailed_age' do
    subject { patient.detailed_age }
    let(:patient) do
      FactoryGirl.build(:patient, birthday: birthday, birthyear: birthyear, birthday_unknown: birthday_unknown)
    end
    let(:birthday) { nil }
    let(:birthyear) { nil }
    let(:birthday_unknown) { false }
    context 'with birthday on June 16 1984' do
      let(:birthday) { "June 16 1984" }
      it { is_expected.to eql "30 (born June 16 1984)" }
    end
    context 'with birthyear 1984' do
      let(:birthyear) { "1984" }
      it { is_expected.to eql "30 (born in 1984)" }
    end
    context 'with birthday unknown' do
      let(:birthday_unknown) { true }
      it { is_expected.to eql "" }
    end
  end

  describe '.maximum_age' do
    subject { Patient.maximum_age(maximum_age).all }
    let(:patient) do
      FactoryGirl.create(:patient, birthday: birthday)
    end
    context 'when patient has his 30th birthday' do
      let(:maximum_age) { 30 }
      context 'tomorrow' do
        let(:birthday) { 30.years.ago.tomorrow.to_date }
        it { is_expected.to include patient }
      end
      context 'today' do
        let(:birthday) { 30.years.ago.to_date }
        it { is_expected.to include patient }
      end
      context 'yesterday' do
        let(:birthday) { 30.years.ago.yesterday.to_date }
        it { is_expected.to_not include patient }
      end
    end
  end
end
