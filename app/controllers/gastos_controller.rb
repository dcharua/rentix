class GastosController < ApplicationController

  before_action :set_gasto, only: [:edit, :update, :show, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  protect_from_forgery except: :search

  def index
    @gastos = current_user.gastos.all
    @actualizado = current_user.gastos.maximum('updated_at')
  end

  def new
      @gasto = Gasto.new
  end

  def create
    @gasto = Gasto.new(gasto_params)
    @gasto.user = current_user
    if @gasto.save
      flash[:success] = "Se agregó el gasto"
      redirect_to gastos_path
    else
      render 'new'
    end
  end

  def update
    if @gasto.update(gasto_params)
      flash[:success] = "Los datos fueron actualizados"
      redirect_to gastos_path
    else
      render 'edit'
    end
  end

  def show

  end

  def edit

  end

  def search
    @pag = Gasto.search(params[:search_param])
    if @inq
      render partial: "lookup"
    else
       render status: :not_found, nothing: true
    end
  end

  def destroy
    @gasto.destroy
    flash[:danger] = "El gasto fue eliminado"
    redirect_to root_path
  end

  private
  def set_gasto
    @gasto = Gasto.find(params[:id])
  end

  def require_same_user
    if current_user != @gasto.user
      flash[:danger] = "Solo puedes modificar tus gastos"
      redirect_to root_path
    end
  end


  def gasto_params
    params.require(:gasto).permit(:monto, :fecha, :rentas_id, :categoria_id, :comentarios)
  end

end
