class Rentas < ActiveRecord::Base
  belongs_to :inquilino
  belongs_to :propiedad
end
