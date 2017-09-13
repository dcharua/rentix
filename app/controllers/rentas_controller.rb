class RentasController < ApplicationController
  before_action :set_renta, only: [:edit, :update, :show, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @rentas = current_user.rentas.all
    @actualizado = current_user.rentas.maximum('updated_at')

  end

  def new
      @renta = Rentas.new
  end

  def create
    @renta = Rentas.new(renta_params)
    if !params[:rentas][:inquilino_id].present?
      inquilino = Inquilino.new(inquilino_params)
      inquilino.user = current_user
      inquilino.save
      @renta.inquilino = inquilino
    end
    if !params[:rentas][:propiedad_id].present?
      propiedad = Propiedad.new(propiedad_params)
      propiedad.user = current_user
      propiedad.save
      @renta.propiedad = propiedad
    end
    @renta.user = current_user

    if @renta.save
      time = Time.now
      loop do
        pago = Pago.new({ :mes => time, :rentas_id => @renta.id, :pagado => false})
        pago.user = current_user
        pago.save
        time = time + 1.month
      break if @renta.final < time
    end
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
    # borrar pagos
    @renta.destroy
    p
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

  def search
    @rent = Rentas.search(params[:search_param])
    if @rent
      render partial: "lookup"
    else
       render status: :not_found, nothing: true
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
      params.require(:rentas).permit(:costo, :final, :dia, :inquilino_id, :propiedad_id)
    end

    def inquilino_params
      params[:rentas].require(:inquilino_attributes).permit(:nombre, :nacimiento, :nacionalidad, :curp, :rfc)
    end

    def propiedad_params
      params[:rentas].require(:propiedad_attributes).permit(:nombre, :calle, :colonia, :municipio, :numero, :numeroe, :cp, :estado)
    end
end
