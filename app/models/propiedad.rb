class Propiedad < ActiveRecord::Base
  has_many :rentas
  has_many :inquilinos, through: :rentas
  belongs_to :user
  validates :user_id, presence: true
end
