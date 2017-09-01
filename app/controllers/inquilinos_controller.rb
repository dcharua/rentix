class InquilinosController < ApplicationController
  def index
    @inquilinos = Inquilino.all
    @actualizado = Inquilino.maximum('updated_at')
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
    @inquilino = Inquilino.find(params[:id])
    if @inquilino.update(inquilino_params)
      flash[:success] = "Los datos fueron actualizados"
      redirect_to inquilinos_path
    else
      render 'edit'
    end
  end

  def show

  end

  def inquilino_params
    params.require(:inquilino).permit(:nombre, :nacimiento, :nacionalidad, :curp, :rfc)
  end

  def edit
      @inquilino = Inquilino.find(params[:id])
  end

  def destroy
    @inquilino = Inquilino.find(params[:id])
    @inquilino.destroy
    flash[:danger] = "El inquilino fue eliminado"
    redirect_to inquilinos_path
  end


end
