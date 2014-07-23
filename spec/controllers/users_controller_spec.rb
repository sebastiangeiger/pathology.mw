require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  describe 'GET /users' do
    subject { get :index }
    before(:each) { sign_in user }
    describe 'as an administrator' do
      let(:user) do
        User.create(email: "admin@example.com",
                    password: "supersecret",
                    role_name: :administrator)
      end
      it 'is granted access' do
        expect(response).to be_success
      end
    end
    describe 'as a pathologist' do
      let(:user) do
        User.create(email: "pathologise@example.com",
                    password: "supersecret",
                    role_name: :pathologist)
      end
      it 'is granted access' do
        expect(response).to redirect_to root_path
      end
      it 'is sets a flash message' do
        expect { subject }.to change { flash[:error] }
      end
    end
  end
end
