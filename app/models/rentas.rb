class Rentas < ActiveRecord::Base
  belongs_to :inquilino
  belongs_to :propiedad
  belongs_to :user
  validates :user_id, presence: true
  validates :inquilino_id, presence: true
  validates :propiedad_id, presence: true

end
