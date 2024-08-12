class DocumentsController <ApplicationController
  before_action :require_user, except: [:show]
  def index
    @documents = current_user.documents.order(created_at: :asc)
  end

  def create
    file = params[:document][:user_document]
    data = file.read
    file_hash = Digest::MD5.hexdigest(data.to_s).to_s
    picture_name = file_hash + file.original_filename.to_s
    path = File.join("storage", picture_name)
    new_file = File.open(path, "wb")
    new_file.write(data)

    current_user.documents.create(user_id: current_user.id, file_name:file.original_filename.to_s, file_size: file.size,  path: path, sharing: false, uuid: file_hash)

    flash[:notice] = "File uploaded."
    redirect_to '/'
  end

  def shared
    uuid = params[:id]
    @file = Document.find_by(uuid: uuid)
  end

  def download
    uuid = params[:id]
    @file = Document.find_by(uuid: uuid)
    if @file.user_id == current_user.id or @file.shared
      send_file @file.path, filename: @file.file_name, disposition: 'attachment' unless @file.nil?
    else
      redirect_to root_path
    end
  end

  def update

    @document = current_user.documents.with_hash(params[:id]).first

    if @document.sharing
      @document.sharing = false
    else
      @document.sharing = true;
    end
    @document.save
    redirect_to root_path
  end

  def destroy
    ActiveRecord::Base.transaction do
      set_document
      file = @document.path
      File.delete(file) if File.exist?(file)
      @document.destroy
      redirect_to root_path
    end
  end
  def set_document
    @document = current_user.documents.with_hash(params[:id]).first
  end

end