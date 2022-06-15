# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  crypted_password :string
#  email            :string           not null
#  mypage_name      :integer
#  name             :string           not null
#  salt             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
  include JwtToken
  authenticates_with_sorcery!

  has_many :mygenres, dependent: :destroy

  has_one_attached :icon
  has_one_attached :background_image

  validates :password, length: { minimum: 5 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :mypage_name, length: { maximum: 50 }

  def icon_url
    icon.attached? ? Rails.application.routes.url_helpers.rails_blob_path(icon, only_path: true) : nil
  end

  def background_image_url
    background_image.attached? ? Rails.application.routes.url_helpers.rails_blob_path(background_image, only_path: true) : nil
  end
end
