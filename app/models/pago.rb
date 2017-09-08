class Pago < ActiveRecord::Base
  belongs_to :rentas
  belongs_to :user

  validates :monto, presence: true

  def self.search(param)
    return Pago.none if param.blank?
    renta_matches(param)
  end

  def self.renta_matches(param)
    pago = new.build_rentas
  pago =  Rentas.search(param)
 return Pago.joins(:rentas).where(rentas: pago)


  end

end
