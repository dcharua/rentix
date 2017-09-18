class HomeController < ApplicationController
  def index
    @inquilinos = current_user.inquilinos
    @propiedads = current_user.propiedads
    @rentas =  current_user.rentas
  end


def search
  @ren =  current_user.rentas.search(params[:search_param])
  @pro = current_user.propiedads.search(params[:search_param])
  @inq =  current_user.inquilinos.search(params[:search_param])

  end
end
