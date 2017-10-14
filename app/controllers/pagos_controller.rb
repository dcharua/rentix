class PagosController < ApplicationController

  before_action :set_pago, only: [:edit, :update, :show, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  protect_from_forgery except: :search

  def index
    @pagosR = current_user.pagos.where("categoria_id = ?",  1)
    @pagosM = current_user.pagos.where("categoria_id = ?", 3)
    @pagosG = current_user.pagos.where("categoria_id = ?", 2)
    @pagosO = current_user.pagos.where("categoria_id = ?", 4)
    @actualizado = current_user.pagos.maximum('updated_at')

  end

  def new
      @pago = Pago.new
  end


  def nuevo
      @pago = Pago.new
      @renta = current_user.rentas.find(params[:id])
  end

  def create
    @pago = Pago.new(pago_params)
    @pago.user = current_user
    if @pago.save
      flash[:success] = "Se agregó el pago"
      redirect_to pagos_path
    else
      render 'new'
    end
  end

<<<<<<< HEAD
=======
  def nuevo

  end

  def crear
    #@pago = Pago.where(["rentas_id = ? AND cast(strftime('%Y', mes) as int) = ? AND cast(strftime('%m', mes) as int) = ?", params[:rentas], params[:mes]["fecha(1i)"].to_i, params[:mes]["fecha(2i)"].to_i]).first
    @pago = Pago.where(["rentas_id = ? AND extract(year from mes)::integer = ? AND extract(month from mes)::integer = ?", params[:rentas], params[:mes]["fecha(1i)"].to_i, params[:mes]["fecha(2i)"].to_i]).first

    if @pago
      render partial: "form"
    else
      render status: :not_found, nothing: true
   end

  end

>>>>>>> 70f58b6cee663fd805fc7b765c9c26881260a93b
  def update
    if @pago.update(pago_params)
      flash[:success] = "Los datos fueron actualizados"
      redirect_to pagos_path
    else
      render 'edit'
    end
  end

  def show

  end

  def edit

  end

  def search
    @pag = Pago.search(params[:search_param])
    if @inq
      render partial: "lookup"
    else
       render status: :not_found, nothing: true
    end
  end

  def destroy
    if @pago.destroy
      flash[:danger] = "El pago fue eliminado"
    else
      flash[:danger] = "Error borrando el pago"
    end
    redirect_to pagos_path
  end

  private
  def set_pago
    @pago = Pago.find(params[:id])
  end

  def require_same_user
    if current_user != @pago.user
      flash[:danger] = "Solo puedes modificar tus pagos"
      redirect_to root_path
    end
  end

  def pago_params
    params.require(:pago).permit(:monto, :fecha, :mes, :rentas_id, :categoria_id, :comentarios)
  end

end
