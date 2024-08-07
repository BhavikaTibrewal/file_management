class DocumentsController <ApplicationController
  before_action :require_user, except: [:show]
  def index
    @documents = current_user.documents.order(created_at: :asc)
  end

  def create
    current_user.documents.create(create_document_params)
    redirect_to '/'
  end

  def show

  end

  private
  def create_document_params
    params.require(:document).permit(:user_document).merge(key: "#{SecureRandom.hex(6)}#{Time.now.to_i}")
  end

end