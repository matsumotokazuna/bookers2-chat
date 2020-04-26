class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,:validatable

  attachment :profile_image

  has_many :books, dependent: :destroy
  has_many :user_rooms
  has_many :rooms, through: :user_rooms

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, length: {maximum: 20, minimum: 2}
  validates :introduction, length: { maximum: 50 } 

  def rooming?(user)
    rooms.where(user_id: user.id).exists?
  end
end
