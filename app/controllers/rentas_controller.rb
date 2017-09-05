class RentasController < ApplicationController
  before_action :set_renta, only: [:edit, :update, :show, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @rentas = current_user.rentas.all
    @actualizado = current_user.rentas.maximum('updated_at')

  end

  def new
      @renta = Rentas.new
      @inquilino = Inquilino.new
  end

  def create
    @inquilino = Inquilino.find(params[:rentas][:inquilino])
    @propiedad = Propiedad.find(params[:rentas][:propiedad])
    @renta = Rentas.new(renta_params)
    @renta.inquilino = @inquilino
    @renta.propiedad = @propiedad
    @renta.user = current_user
    if @renta.save
      flash[:success] = "Se agregó la renta"
      redirect_to rentas_path
    else
      render 'new'
    end
  end

  def update
    if @renta.update(renta_params)
      flash[:success] = "Los datos fueron actualizados"
      redirect_to rentas_path(params[:id])
    else
      render 'edit'
    end
  end



  def show

  end

  def edit

  end

  def destroy
    @renta.destroy
    flash[:danger] = "La renta fue eliminada"
    redirect_to rentas_path
  end

  def existing
      @renta = Rentas.new
    respond_to do |format|
      format.js   #looks for views/books/index.js.erb
    end
  end

  def nuevo
    @renta = Rentas.new
    respond_to do |format|
      format.js   #looks for views/books/index.js.erb
    end
  end

  private
  def set_renta
    @renta= Rentas.find(params[:id])
  end

  def require_same_user
    if current_user != @renta.user
      flash[:danger] = "Solo puedes modificar tus rentas"
      redirect_to root_path
    end
  end

  def renta_params
    params.require(:rentas).permit(:costo, :inicio, :final)
    end
  end
