class Work < ApplicationRecord

  validates :title, presence: true, length: {maximum: 50}
  validates :caption, presence: true, length: {maximum: 3000}

  has_one_attached :work_image

  def get_work_image(width, height)
    unless work_image.attached?
      # 商品画像がない場合はimages/no-image.jpgを参照
      file_path = Rails.root.join('app/assets/images/no_work_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    work_image.variant(resize_to_limit: [width, height]).processed
  end

  belongs_to :user

  has_many :work_favorites
  has_many :work_tags
  has_many :comments

end
