class Category < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  has_and_belongs_to_many :operations

  validates :name, presence: true
  validates :icon, presence: true

  def total_amount_category
    total = 0
    operations.each do |operation|
      total += operation.amount
    end
    total.round(2)
  end
end
