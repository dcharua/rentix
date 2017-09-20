class Categoria < ActiveRecord::Base
  has_many :pagos

  def to_label
   "#{categoria}"
 end

end
