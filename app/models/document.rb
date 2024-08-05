class Document < ApplicationRecord
  belongs_to :user
  has_one_attached :vb
  validates :key, presence: true, uniqueness: true
end