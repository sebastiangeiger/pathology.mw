require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  describe 'GET /users' do
    subject { get :index }
    before(:each) do
      user.confirm!
      sign_in user
    end
    describe 'as an administrator' do
      let(:user) do
        User.create(email: "admin@example.com",
                    password: "supersecret",
                    role_name: :administrator)
      end
      it 'is granted access' do
        subject
        expect(response).to be_success
      end
    end
    describe 'as a pathologist' do
      let(:user) do
        User.create(email: "pathologise@example.com",
                    password: "supersecret",
                    role_name: :pathologist)
      end
      it 'is turned down' do
        subject
        expect(response).to redirect_to root_path
      end
      it 'sees a flash message' do
        expect { subject }.to change { flash[:alert] }
      end
    end
  end
end
