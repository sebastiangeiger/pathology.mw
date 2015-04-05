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
end
