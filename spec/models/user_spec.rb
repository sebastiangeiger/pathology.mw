require 'rails_helper'

RSpec.describe User, :type => :model do
  describe 'basic instance' do
    context 'with an email and a longish password' do
      subject do
        User.new(email: "some@email.com",
                 password: "supersecret")
      end
      it { is_expected.to be_valid }
    end
  end
  describe 'role_name' do
    subject do
      User.new(email: "some@email.com",
               password: "supersecret",
               role_name: role_name)
    end
    context 'with guest' do
      let(:role_name) { :guest }
      it { is_expected.to be_valid }
      it { is_expected.to be_guest }
    end
    context 'with invalid name' do
      let(:role_name) { :invalid }
      it { is_expected.to be_invalid }
    end
  end
end
