class Propiedad < ActiveRecord::Base
  has_many :rentas, class_name: "::Rentas", foreign_key: "propiedad_id", dependent: :destroy
  has_many :inquilinos, through: :rentas, class_name: "::Rentas", foreign_key: "propiedad_id"
  has_many :gastos, dependent: :destroy
  belongs_to :user
  validates :user_id, presence: true

  def idnt; "#{nombre} : #{calle} ##{numero}";end

  def to_label
   "#{nombre} : #{calle} ##{numero}"
 end

  def self.search(param)
    return Propiedad.none if param.blank?
    (nombre_matches(param) + calle_matches(param)).uniq
  end

  def self.nombre_matches(param)
    matches('nombre', param)
  end

  def self.calle_matches(param)
    matches('calle', param)
  end

  def self.matches(field_name, param)
    where("#{field_name} like ?", "%#{param}%")
  end
end
