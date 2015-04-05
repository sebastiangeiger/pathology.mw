require 'rails_helper'

RSpec.describe Physician, :type => :model do
  describe 'factory' do
    subject { FactoryGirl.build(:physician) }
    it { is_expected.to be_valid }
  end

  describe '#specimens' do
    let(:physician) { FactoryGirl.build(:physician) }
    let(:specimen) { FactoryGirl.create(:specimen, physician: physician) }

    subject { physician.specimens }

    it { is_expected.to match_array [specimen] }
  end

  describe '#full_name' do
    let(:physician) { FactoryGirl.build(:physician, build_params) }
    subject { physician.full_name }

    context 'with a first and last name' do
      let(:build_params) do
        { title: nil,
          first_name: "John",
          last_name: "Doe" }
      end
      it { is_expected.to eql "John Doe" }
    end

    context 'with a first and last name and a title' do
      let(:build_params) do
        {  title: "Dr.",
           first_name: "John",
           last_name: "Doe" }
      end
      it { is_expected.to eql "Dr. John Doe" }
    end

  end
end
