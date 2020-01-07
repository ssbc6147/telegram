class Post < ApplicationRecord
  paginates_per 5
  has_one_attached :image
  belongs_to :user
  has_many :comments, dependent: :destroy
  attribute :new_image
  validates :caption, presence: true
  validate :new_image_check

  def new_image_check
    if new_image.present?
      unless new_image.content_type.in?(%w(image/jpeg image/png))
        errors.add(:new_image, 'にはjpegまたはpngファイルを添付してください')
      end
    else
      unless image.attached?
        errors.add(:new_image, 'ファイルを添付してください')
      end
    end
  end

  before_save do
    self.image = new_image if new_image
  end
  scope :find_newest_post, -> (page) { with_attached_image.order(created_at: :desc).page(page) }
  scope :with_user_and_comment, -> { includes(user: [avatar_attachment: :blob], comments: [user: [avatar_attachment: :blob]]) }
end
