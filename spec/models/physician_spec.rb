require 'rails_helper'

RSpec.describe Physician, :type => :model do
  describe 'factory' do
    subject { FactoryGirl.build(:physician) }
    it { is_expected.to be_valid }
  end
end
