class Plazo < ActiveRecord::Base
  belongs_to :rentas, class_name: "::Rentas"
  belongs_to :user

  validates :costo, presence: true
  validates :final, presence: true


end
