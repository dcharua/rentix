class Inquilino < ActiveRecord::Base
  has_many :rentas
  has_many :propiedads, through: :rentas
  belongs_to :user
  validates :user_id, presence: true
end