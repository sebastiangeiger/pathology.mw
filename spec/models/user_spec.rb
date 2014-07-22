require 'rails_helper'

RSpec.describe User, :type => :model do
  describe 'role_name validation' do
    subject do
      User.new(email: "some@email.com",
               password: "supersecret",
               role_name: role_name)
    end
    context 'with guest' do
      let(:role_name) { :guest }
      it { is_expected.to be_valid }
    end
    context 'with invalid name' do
      let(:role_name) { :invalid }
      it { is_expected.to be_invalid }
    end
  end
end
