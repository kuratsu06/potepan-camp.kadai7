class Room < ApplicationRecord
  belongs_to :user
  has_many :reservations, dependent: :destroy
  
  validates :name, presence: true
  validates :introduction, presence: true, length: {maximum: 200}
  validates :price, numericality: true
  validates :address, presence: true, length: {maximum: 20 }
  validates :image, presence: true
  validates :user_id, presence: true

  mount_uploader :image, ImageUploader
  
  def self.seek(address)
    if address
      Room.where(["address LIKE?", "%#{address}%"])
    else
      Room.all
    end
  end
  
  def self.search(keyword)
    if keyword
      Room.where(["address LIKE? OR name LIKE? OR introduction LIKE?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"])
    else
      Room.all
    end
  end
end