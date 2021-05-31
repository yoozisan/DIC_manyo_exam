class Task < ApplicationRecord
  belongs_to :user
  has_many :labellings, dependent: :destroy
  has_many :labels, through: :labellings
  validates :title, presence: true
  validates :content, presence: true
  validates :expired_at, presence: true
  validates :status_name, presence: true

  scope :search_title, -> (search_title) { where("title LIKE ?", "%#{search_title}%") }
  scope :search_status, -> (search_status) { where(status_name: search_status)}

  enum priority: { 低: 1, 中: 2, 高: 3}
end
