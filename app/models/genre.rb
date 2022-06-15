# == Schema Information
#
# Table name: genres
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_genres_on_name  (name) UNIQUE
#
class Genre < ApplicationRecord
  has_many :characters, dependent: :destroy
  has_many :mygenres
  has_many :mygenre_users, through: :mygenres, source: :user

  validates :name, presence: true, uniqueness: true
end
