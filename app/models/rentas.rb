class Rentas < ActiveRecord::Base
  belongs_to :inquilino
  belongs_to :propiedad
  belongs_to :user
  has_many :pagos

  validates :inicio, presence: true
  validates :final, presence: true
  validates :user_id, presence: true
  validates :inquilino_id, presence: true
  validates :propiedad_id, presence: true

  accepts_nested_attributes_for :inquilino
  accepts_nested_attributes_for :propiedad

  def to_label
    inquilino = Inquilino.find(inquilino_id).nombre
    propiedad = Propiedad.find(propiedad_id).nombre
   "#{inquilino}, renta la propiedad:  #{propiedad} "
 end

 def self.search(param)
   return Rentas.none if param.blank?
   (inquilino_matches(param) + propiedad_matches(param)).uniq
 end

 def self.inquilino_matches(param)
   inq = Inquilino.search(param)
   renta = Rentas.joins(:inquilino).where(inquilino: inq)
 end

 def self.propiedad_matches(param)
   pro = Propiedad.search(param)
   renta = Rentas.joins(:propiedad).where(propiedad: pro)

 end

end
