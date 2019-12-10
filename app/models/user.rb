class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :avatar
  attribute :new_avatar

  validates :name, presence: true, length: { maximum: 50 }
  validates :username, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :description, presence: true, length: { maximum: 1000 }
  validate :new_avatar_check

  def new_avatar_check
    if new_avatar.present?
      unless new_avatar.content_type.in?(%w(image/jpeg image/png))
        errors.add(:new_avatar, 'にはjpegまたはpngファイルを添付してください')
      end
    else
      unless avatar.attached?
        errors.add(:new_avatar, 'ファイルを添付してください')
      end
    end
  end

  before_save do
    self.avatar = new_avatar if new_avatar
  end
end
