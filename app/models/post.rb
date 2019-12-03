class Post < ApplicationRecord
  has_one_attached :image
  attribute :new_image

  before_save do
    self.image = new_image if new_image
  end
end
