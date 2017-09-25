class Inquilino < ActiveRecord::Base
  has_many :rentas,  class_name: "::Rentas", foreign_key: "inquilino_id"
  has_many :propiedads, through: :rentas, class_name: "::Rentas", foreign_key: "inquilino_id"
  belongs_to :user
  validates :user_id, presence: true

  def self.search(param)
    return Inquilino.none if param.blank?
    where("#{"nombre"} like ?", "%#{param}%")
  end

  def to_label
   "#{nombre}"
 end

end
