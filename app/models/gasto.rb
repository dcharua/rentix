class Gasto < ActiveRecord::Base
  belongs_to :propiedads
  belongs_to :user
  belongs_to :categoria
  validates :categoria_id, presence: true
  validates :monto, presence: true
  validates :fecha, presence: true

  def to_label
    "#{categoria}"
  end

  def self.search(param)
    return Gasto.none if param.blank?
    renta_matches(param)
  end


 def self.search(param)
   return Gasto.none if param.blank?
   (renta_matches(param)).uniq
 end

 def self.renta_matches(param)
   renta = Rentas.search(param)
   gasto = Gasto.joins(:rentas).where(rentas: renta)
   gasto.where(pagado: true)
 end

end
