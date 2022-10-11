class Operation < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'author_id'
  has_and_belongs_to_many :categories

  validates :name, presence: true
  validates :amount, presence: true
  validates :amount, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
