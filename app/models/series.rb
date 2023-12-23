class Series < ApplicationRecord

  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 30 }

  has_one_attached :series_image

  def get_series_image(width, height)
    unless series_image.attached?
      # プロフィール画像がない場合はimages/no_profile_image.jpgを参照
      file_path = Rails.root.join("app/assets/images/no_work_image.jpg")
      series_image.attach(io: File.open(file_path), filename: "default-image.jpg", content_type: "image/jpeg")
    end
    series_image.variant(resize_to_limit: [width, height]).processed
  end

  belongs_to :user
  has_many :works

end
