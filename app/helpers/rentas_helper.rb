module RentasHelper
  def get_inquilinos(id)
    current_user.inquilinos.find(id)
    end

    def get_propiedads(id)
      current_user.propiedads.find(id)
    end
end
