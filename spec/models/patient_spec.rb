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

  describe '#clincal_history' do
    let(:patient) do
      FactoryGirl.build(:patient)
    end
    subject { patient.clinical_histories }
    it { is_expected.to be_empty }
    context 'with a clincal history created' do
      let(:clinical_history) do
        FactoryGirl.create(:clinical_history, patient: patient)
      end
      it { is_expected.to include clinical_history }
    end
  end
end
