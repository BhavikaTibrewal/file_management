class Document < ApplicationRecord
  belongs_to :user
  has_one_attached :user_document
  validates :key, presence: true, uniqueness: true

  def self.save_file(file,size, user_id)
    file_details = file.original_filename.split('.')
    content_type = file.content_type
    extension = file_details[1]
    data = file.read
    file_hash = Digest::MD5.hexdigest(data.to_s).to_s
    hashed_name = "#{file_hash}.#{extension}"
    path = File.join("storage", hashed_name)
    new_file = File.open(path, "wb")
    new_file.write(data)

    Upload.create(user_id: user_id,file_name: file.original_filename, file_size: size, path: path, sharing:false, uuid: file_hash).save
  ensure
    file.close unless file.nil?
  end
end