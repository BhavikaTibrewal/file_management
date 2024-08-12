require 'spec_helper'
require 'rails_helper'


RSpec.describe SessionsController, :type => :controller do

  describe "login user" do
  before do
    @user  = User.create!({full_name:"user1", user_name:"user1",email: "nk@nk12.com", password: 'Testtest1'})
  end
  

  it "All right crendentials" do
    post :create, params: { :session => {email: "nk@nk12.com", password: 'Testtest1'}}
    expect(response.status).to be(200)
  end
  end
end