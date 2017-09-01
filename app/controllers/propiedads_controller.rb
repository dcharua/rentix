class PropiedadsController < ApplicationController
  before_action :set_propiedad, only: [:edit, :update, :show, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  def index
    @propiedads = current_user.propiedads.all
    @actualizado = current_user.propiedads.maximum('updated_at')
  end

  def new
      @propiedad = Propiedad.new
  end

  def create
    @propiedad = Propiedad.new(propiedad_params)
    @propiedad.user = current_user
    if @propiedad.save
      flash[:success] = "Se agregó la propiedad"
      redirect_to propiedads_path
    else
      render 'new'
    end
  end

  def update
    if @propiedad.update(propiedad_params)
      flash[:success] = "Los datos fueron actualizados"
      redirect_to propiedads_path
    else
      render 'edit'
    end
  end

  def show

  end

  def edit

  end

  def destroy
    @propiedad.destroy
    flash[:danger] = "La propiedad fue eliminada"
    redirect_to propiedads_path
  end

  private
  def set_propiedad
    @propiedad= Propiedad.find(params[:id])
  end

  def require_same_user
    if current_user != @propiedad.user
      flash[:danger] = "Solo puedes modificar tus propiedades"
      redirect_to root_path
    end
  end

  def propiedad_params
    params.require(:propiedad).permit(:nombre, :calle, :colonia, :municipio, :numero, :numeroe, :cp, :estado)
  end
end
