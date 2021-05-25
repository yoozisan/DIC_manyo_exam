class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :expired_at, presence: true
  validates :status_name, presence: true
  scope :search_title, -> (search_title) { where("title LIKE ?", "%#{search_title}%") }
  scope :search_status, -> (search_status) { where(status_name: search_status)}
end
