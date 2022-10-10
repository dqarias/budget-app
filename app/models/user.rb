class User < ApplicationRecord
    has_many :categories, foreign_key: "user_id", dependent: :destroy
    has_many :operations, foreign_key: "author_id", dependent: :destroy

    validates :name, presence: true
    validates :name, length: { maximum: 100 }
end
