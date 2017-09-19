class Pago < ActiveRecord::Base
  belongs_to :rentas
  belongs_to :user


  def self.search(param)
    return Pago.none if param.blank?
    renta_matches(param)
  end


 def self.search(param)
   return Pago.none if param.blank?
   (renta_matches(param)).uniq
 end

 def self.renta_matches(param)
   renta = Rentas.search(param)
   pago = Pago.joins(:rentas).where(rentas: renta)
   pago.where(pagado: true)
 end

end
