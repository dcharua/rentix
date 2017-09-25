class HomeController < ApplicationController
def index
  @inquilinos = current_user.inquilinos
  @propiedads = current_user.propiedads
  @rentas =  current_user.rentas
  @ingreso1 = getIngreso(1)
  @ingreso2 = getIngreso(2)
  @ingreso3 = getIngreso(3)
  @ingreso4 = getIngreso(4)
  @ingreso5 = getIngreso(5)
  @ingreso6 = getIngreso(6)
  @ingreso7 = getIngreso(7)
  @ingreso8 = getIngreso(8)
  @ingreso9 = getIngreso(9)
  @ingreso10 = getIngreso(10)
  @ingreso11 = getIngreso(11)
  @ingreso12 = getIngreso(12)
  @ingresoT = @ingreso1 + @ingreso2 + @ingreso3 + @ingreso4 + @ingreso5 + @ingreso6 + @ingreso7 + @ingreso8 + @ingreso9 + @ingreso10 + @ingreso11 + @ingreso12


  @ingresoR1 = getIngresoReal("01")
  @ingresoR2 = getIngresoReal("02")
  @ingresoR3 = getIngresoReal("03")
  @ingresoR4 = getIngresoReal("04")
  @ingresoR5 = getIngresoReal("05")
  @ingresoR6 = getIngresoReal("06")
  @ingresoR7 = getIngresoReal("07")
  @ingresoR8 = getIngresoReal("08")
  @ingresoR9 = getIngresoReal("09")
  @ingresoR10 = getIngresoReal("10")
  @ingresoR11 = getIngresoReal("11")
  @ingresoR12 = getIngresoReal("12")
  @ingresoR = @ingresoR1 + @ingresoR2 + @ingresoR3 + @ingresoR4 + @ingresoR5 + @ingresoR6 + @ingresoR7 + @ingresoR8 + @ingresoR9 + @ingresoR10 + @ingresoR11 + @ingresoR12
end

def getIngreso(mes)
  fecha = Date.new(Time.now.year, mes, 28)
  current_user.rentas.where( "final > ? AND created_at < ?", fecha, fecha).sum(:costo)
end

def getIngresoReal(mes)
  current_user.rentas.joins(:pagos).where("strftime('%m', pagos.mes) == ?", mes).sum(:monto)
  #current_user.rentas.joins(:pagos).where("extract(month from pagos.mes) = ?", mes).sum(:monto)

end

def search
  @ren =  current_user.rentas.search(params[:search_param])
  @pro = current_user.propiedads.search(params[:search_param])
  @inq =  current_user.inquilinos.search(params[:search_param])
  @pag = current_user.pagos.search(params[:search_param])
  @gas = current_user.gastos.search(params[:search_param])
  end
end
