class Gasto < ActiveRecord::Base
  belongs_to :propiedad
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
   propiedad_matches(param)
 end

 def self.propiedad_matches(param)
   propiedad = Propiedad.search(param)
   if propiedad[0]
     gasto = Gasto.where("propiedad_id = ?", propiedad[0].id)
   else gasto = Gasto.none
  end
 end

end
