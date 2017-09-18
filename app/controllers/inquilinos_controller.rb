class InquilinosController < ApplicationController

  before_action :set_inquilino, only: [:edit, :update, :show, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  protect_from_forgery except: :search

  def index
    @inquilinos = current_user.inquilinos.all
    @actualizado = current_user.inquilinos.maximum('updated_at')
  end

  def new
      @inquilino = Inquilino.new
  end

  def create
    @inquilino = Inquilino.new(inquilino_params)
    @inquilino.user = current_user
    if @inquilino.save
      flash[:success] = "Se agregó el inquilino"
      redirect_to inquilinos_path
    else
      render 'new'
    end
  end

  def update
    if @inquilino.update(inquilino_params)
      flash[:success] = "Los datos fueron actualizados"
      redirect_to inquilinos_path
    else
      render 'edit'
    end
  end

  def show

  end

  def edit

  end

  def search
    @inq = current_user.inquilinos.search(params[:search_param])
    if @inq
      render partial: "lookup"
    else
       render status: :not_found, nothing: true
    end
  end

  def destroy
    @inquilino.destroy
    flash[:danger] = "El inquilino fue eliminado"
    redirect_to inquilinos_path
  end

  private
  def set_inquilino
    @inquilino= Inquilino.find(params[:id])
  end

  def require_same_user
    if current_user != @inquilino.user
      flash[:danger] = "Solo puedes modificar tus inquilinos"
      redirect_to root_path
    end
  end

  def inquilino_params
    params.require(:inquilino).permit(:nombre, :nacimiento, :nacionalidad, :curp, :rfc)
  end

end
