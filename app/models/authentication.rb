# == Schema Information
#
# Table name: authentications
#
#  id                  :bigint           not null, primary key
#  access_token        :string
#  access_token_secret :string
#  provider            :string           not null
#  uid                 :string           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  user_id             :integer          not null
#
# Indexes
#
#  index_authentications_on_provider_and_uid  (provider,uid)
#  index_authentications_on_user_id           (user_id)
#
class Authentication < ApplicationRecord
  before_save :encrypt_access_token
  belongs_to :user

  def encrypt_access_token
    key_len = ActiveSupport::MessageEncryptor.key_len
    secret = Rails.application.key_generator.generate_key('salt', key_len)
    crypt = ActiveSupport::MessageEncryptor.new(secret)
    self.access_token = crypt.encrypt_and_sign(access_token)
    self.access_token_secret = crypt.encrypt_and_sign(access_token_secret)
  end

  def decrypt_access_token_and_login?(user_hash)
    key_len = ActiveSupport::MessageEncryptor.key_len
    secret = Rails.application.key_generator.generate_key('salt', key_len)
    crypt = ActiveSupport::MessageEncryptor.new(secret)
    (crypt.decrypt_and_verify(self.access_token) == user_hash["oauth_token"] &&
            crypt.decrypt_and_verify(self.access_token_secret) == user_hash["oauth_token_secret"])
  end
end
