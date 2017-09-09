class HomeController < ApplicationController
  def index
    @inquilinos = current_user.inquilinos
    @propiedads = current_user.propiedads
    @rentas =  current_user.rentas
  end
end
