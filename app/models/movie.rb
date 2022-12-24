class Movie < ApplicationRecord
  belongs_to :category
  has_many :active_rates, class_name: "Rate", dependent: :destroy
  has_many :users, through: :active_rates
  validates :title, presence: true, length: {maximum: 100}
  validates :description, presence: true, length: {maximum: 10000}
  validates :category_id, presence: true
  default_scope -> { order(created_at: :desc)}
end
