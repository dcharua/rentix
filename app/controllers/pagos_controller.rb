class PagosController < ApplicationController

  before_action :set_pago, only: [:edit, :update, :show, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  protect_from_forgery except: :search

  def index
    @pagos = current_user.pagos.where("pagos.pagado = ?", true)
    @actualizado = current_user.pagos.maximum('updated_at')
  end

  def new
      @pago = Pago.new
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

  def nuevo

  end

  def crear
    @pago = Pago.where(["rentas_id == ? AND cast(strftime('%Y', mes) as int) = ? AND cast(strftime('%m', mes) as int) = ?", params[:rentas], params[:mes]["fecha(1i)"].to_i, params[:mes]["fecha(2i)"].to_i]).first
    if @pago
      render partial: "form"
    else
      render status: :not_found, nothing: true
   end

  end

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
    @pago.update({:fecha => nil, :monto => nil, :pagado => false} )
    flash[:danger] = "El pago fue eliminado"
    redirect_to root_path
  end

  private
  def set_pago
    @pago= Pago.find(params[:id])
  end

  def require_same_user
    if current_user != @pago.user
      flash[:danger] = "Solo puedes modificar tus pagos"
      redirect_to root_path
    end
  end

  def pago_params
    params.require(:pago).permit(:monto, :fecha, :mes, :rentas_id, :pagado)
  end

end