class Pago < ActiveRecord::Base
  belongs_to :rentas
  belongs_to :user

  validates :monto, presence: true

  def self.search(param)
    return Pago.none if param.blank?
    (inquilino_matches(param) + propiedad_matches(param)).uniq
  end

  def self.inquilino_matches(param)
    matches('nombre', param)
  end

  def self.propiedads_matches(param)
    matches('calle', param)
  end

  def self.matches(field_name, param)
    where("#{field_name} like ?", "%#{param}%")
  end

end
