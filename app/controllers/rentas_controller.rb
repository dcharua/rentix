<<<<<<< HEAD
class RentasController < ApplicationController
  before_action :set_renta, only: [:edit, :update, :show, :destroy, :terminar]
=======
  class RentasController < ApplicationController
  before_action :set_renta, only: [:edit, :update, :show, :destroy]
>>>>>>> 70f58b6cee663fd805fc7b765c9c26881260a93b
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
      time = @renta.inicio
      if time.day > @renta.dia
        time = time + 1.month
      end
      time = time.change(day: @renta.dia)
      plazo = Plazo.new(plazo_params)
      plazo.user = current_user
      plazo.rentas = @renta
      plazo.inicio = time
      if plazo.save
        flash[:success] = "Se agregó la renta"
        redirect_to rentas_path
      else
        render 'new'
      end
    end
  end



  def update
<<<<<<< HEAD
    time = Time.now
    if @renta.update(renta_params)
      if (plazo = current_user.plazos.where("rentas_id = ? AND plazos.final > ?", @renta.id, Time.now).first)
        plazo.final = Time.now
        plazo.save
      end
    plazo = Plazo.new(plazo_params)
    plazo.user = current_user
    plazo.rentas = @renta
    time = Time.now
    if time.day > @renta.dia
      time = time + 1.month
    end
    time = time.change(day: @renta.dia)
    plazo.inicio = time
      if plazo.save
        flash[:success] = "Se edito la renta"
        redirect_to rentas_path(params[:id])
      else
        render 'edit'
      end
=======
    tmp = @renta.final
    time = Time.now

    if @renta.update(renta_params)
      loop do
        if !@renta.pagos.where("extract(month from mes) = ?", time.month).exists?
        pago = Pago.new({ :mes => time, :rentas_id => @renta.id, :pagado => false})
        pago.user = current_user
        pago.save
        time = time + 1.month
      break if @renta.final < time
      flash[:success] = "Los datos fueron actualizados"
      redirect_to rentas_path(params[:id])
    else
      render 'edit'
>>>>>>> 70f58b6cee663fd805fc7b765c9c26881260a93b
    end
  end


  def show

  end

  def edit

  end

  def terminar
    @renta.final = Time.now
    plazo = current_user.plazos.where("rentas_id = ? AND plazos.final > ?", @renta.id, Time.now).first
    plazo.final = Time.now
    if (@renta.save && plazo.save)
      flash[:success] = "Se termino la renta"
    else
      flash[:danger] = "Un error no permitio terminar la renta"
    end
      redirect_to rentas_path
  end

  def destroy
    # borrar pagos
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

  def search
    @rent = current_user.rentas.search(params[:search_param])
    if @rent
      render partial: "lookup"
    else
       render status: :not_found, nothing: true
    end
  end


  private
  def set_renta
    @renta = Rentas.find(params[:id])
  end

  def require_same_user
    if current_user != @renta.user
      flash[:danger] = "Solo puedes modificar tus rentas"
      redirect_to root_path
    end
  end

    def renta_params
      params.require(:rentas).permit(:costo, :final, :inicio, :dia, :inquilino_id, :propiedad_id)
    end

    def inquilino_params
      params[:rentas].require(:inquilino_attributes).permit(:nombre, :nacimiento, :nacionalidad, :curp, :rfc)
    end

    def propiedad_params
      params[:rentas].require(:propiedad_attributes).permit(:nombre, :calle, :colonia, :municipio, :numero, :numeroe, :cp, :estado)
    end

    def plazo_params
      params.require(:rentas).permit(:costo, :final, :inico)
    end
end
