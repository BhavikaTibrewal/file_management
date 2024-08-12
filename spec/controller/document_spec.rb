require 'spec_helper'
require 'rails_helper'

RSpec.describe DocumentsController, :type => :controller do
  describe 'File upload, download, sharing, and delete' do

    before do
      @user  = User.create!({full_name:"user2", user_name:"user2",email: "nk@nk12.com", password: 'Testtest1'})
      session[:user_id] = @user.id
    end

    before(:each) do
      @spec_asset_path = 'spec/assets/file_to_upload.txt'
      @upload_asset_path = "app/assets/uploads/#{session[:user_id]}/file_to_upload.txt"
    end

    it 'Uploads a file' do
      expect(Document.all.size).to be(0)
      file = Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, @spec_asset_path)))
      post :create, params: { document:{ user_document:file } }

      expect(response).to redirect_to('/')
      expect(Document.all.size).to be(1)
    end

    it 'downloads the uploaded file' do
      file = Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, @spec_asset_path)))
      post :create, params: { document:{ user_document:file } }

      documents = Document.all
      expect(documents.size).to be(1)

      get :download, params: { id: documents[0].uuid }
      allow(controller).to receive(:send_file)
    end

    it 'makes the upload shareable' do
      file = Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, @spec_asset_path)))
      post :create, params: { document:{ user_document:file } }

      documents = Document.all
      expect(documents.size).to be(1)

      document = documents[0]
      expect(document[:sharing]).to be(false)

      put :update, params: { id: document.uuid, sharing: true }

      documents = Document.all
      document = documents[0]
      expect(document[:sharing]).to be(true)
    end

    it 'deletes the uploaded file' do
      file = Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, @spec_asset_path)))
      post :create, params: { document:{ user_document:file } }

      documents = Document.all
      expect(documents.size).to be(1)
      expect(File.exist?(documents[0].path)).to be(true)

      delete :destroy, params: { id: documents[0].uuid }

      expect(Document.all.size).to be(0)
      expect(response).to redirect_to root_path
    end

  end
end