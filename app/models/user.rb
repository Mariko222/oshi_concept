# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  crypted_password :string
#  email            :string
#  mypage_name      :string
#  name             :string           not null
#  salt             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  twitter_id       :string
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
  include JwtToken
  authenticates_with_sorcery!

  has_many :mygenres, dependent: :destroy
  has_many :mygenre_lists, through: :mygenres, source: :genre
  has_many :posts, through: :mygenres
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  has_one_attached :icon

  validates :password, length: { minimum: 5 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true
  validates :name, presence: true, length: { maximum: 10 }
  validates :mypage_name, length: { maximum: 10 }

  def icon_url
    icon.attached? ? Rails.application.routes.url_helpers.rails_blob_path(icon, only_path: true) : nil
  end

end
