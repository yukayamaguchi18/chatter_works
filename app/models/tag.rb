class Tag < ApplicationRecord
  has_many :work_tags, dependent: :destroy, foreign_key: "tag_id"
  # タグは複数の投稿を持つ　それは、work_tagsを通じて参照できる
  has_many :works, through: :work_tags
  has_many :follow_tags, dependent: :destroy, foreign_key: "tag_id"
  has_many :users, through: :follow_tags
  validates :name, presence: true, uniqueness: true, length: { maximum: 30 }
end
