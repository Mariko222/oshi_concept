# == Schema Information
#
# Table name: users
#
#  id                                  :bigint           not null, primary key
#  access_count_to_reset_password_page :integer          default(0)
#  crypted_password                    :string
#  email                               :string
#  mypage_name                         :string
#  name                                :string           not null
#  reset_password_email_sent_at        :datetime
#  reset_password_token                :string
#  reset_password_token_expires_at     :datetime
#  role                                :integer          default(0), not null
#  salt                                :string
#  uuid                                :string
#  created_at                          :datetime         not null
#  updated_at                          :datetime         not null
#  twitter_id                          :string
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token)
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

  enum role: { general: 0, admin: 1 }

  validates :password, length: { minimum: 5 }, if: -> { new_record? || changes[:crypted_password] }, allow_nil: true
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: lambda {
                                                          new_record? || changes[:crypted_password]
                                                        }, allow_nil: true

  validates :email, uniqueness: true, allow_nil: true
  validates :name, presence: true, length: { maximum: 10 }
  validates :mypage_name, length: { maximum: 10 }

  validates :reset_password_token, presence: true, uniqueness: true, allow_nil: true

  before_create -> { self.uuid = SecureRandom.uuid }

  def icon_url
    icon.attached? ? Rails.application.routes.url_helpers.rails_blob_path(icon, only_path: true) : nil
  end

end
