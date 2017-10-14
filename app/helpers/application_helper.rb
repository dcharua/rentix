module ApplicationHelper
    def is_active_controller(controller_name, class_name = nil)
        if params[:controller] == controller_name
         class_name == nil ? "active" : class_name
        else
           nil
        end
    end

    def is_active_action(action_name)
        params[:action] == action_name ? "active" : nil
    end

    def get_inquilinos(id)
      current_user.inquilinos.find(id)
    end

    def get_propiedads(id)
      current_user.propiedads.find(id)
    end

    def rentas_activas
     current_user.rentas.where( "rentas.inicio <= ? AND rentas.final > ? ", Date.today, Time.now)
    end

    def rentas_terminadas
     current_user.rentas.where( "rentas.final <= ? ", Time.now)
    end

    def getRentas
      rentas_activas.order(:dia)
    end

    def pagos_mantenimiento
      rentas_activas.joins(:pagos).select("pagos.id as pid, inquilino_id, propiedad_id, pagos.fecha, monto, comentarios,  rentas.id ").where([" extract(month from pagos.mes) >= ? AND pagos.categoria_id = ?", Time.now.strftime("%m"), 3])
    end

    def pagos_garantia
      rentas_activas.joins(:pagos).select("pagos.id as pid, inquilino_id, propiedad_id, pagos.fecha, monto, comentarios,  rentas.id ").where(["extract(month from pagos.mes) >= ? AND pagos.categoria_id = ?", Time.now.strftime("%m"), 2])
    end

    def pagos_otro
      rentas_activas.joins(:pagos).select("pagos.id as pid, inquilino_id, propiedad_id, pagos.fecha, monto, comentarios,  rentas.id ").where(["extract(month from pagos.mes) >= ? AND pagos.categoria_id = ?", Time.now.strftime("%m"), 4])
    end

    def rentas_por_vencer
      time = Time.now + 2.month
      current_user.rentas.where( "final < ? AND final > ? ", time, Time.now)
    end

    def getBalance(renta)
      balance = 0
      inicio = renta["inicio"].to_date
      plazos = current_user.plazos.select(:costo).where("rentas_id = ? AND final > ?", renta["id"], Time.now)
      final = Time.now
      if inicio.day > renta["dia"]
        inicio = inicio + 1.month
      end
      inicio = inicio.change(day: renta["dia"])
        time = inicio
        loop do
          balance += current_user.plazos.select(:costo).where("rentas_id = ? AND final > ? AND inicio <= ?", renta["id"], time, time).sum(:costo)
          time = time + 1.month
        break if Time.now < time
    end
    # meses = (final.year * 12 + final.month) - (inicio.year * 12 + inicio.month)
    # if inicio.day < final.day
    #   meses = meses +1
    # end
    # return  meses * plazo.costo - getTotalPagado(renta)
    return  getTotalPagado(renta) - balance
    end

    def getBalanceMes(renta, mes)
      fecha = Date.new(Time.now.year, mes, renta.dia)
      if fecha > Time.now
        return 0
      end
      inicio = renta.inicio.to_date
      plazo = current_user.plazos.where("rentas_id = ? AND inicio < ? AND final > ?", renta.id, fecha, fecha).first
      if plazo
        return plazo.costo - getPagadoMes(renta, mes)
      else
        return 0
      end
    end

    def getTotalPagado(renta)
     current_user.rentas.joins(:pagos).where("rentas.id = ? AND pagos.categoria_id = ?", renta.id, 1 ).sum(:monto)
    end

    def getPagadoMes(renta, mes)
     current_user.rentas.joins(:pagos).where("rentas.id = ? AND pagos.categoria_id = ? AND pagos.mes = ?", renta.id, 1, Date.new(Time.now.year, mes, 01) ).sum(:monto)
    end

    def getRetraso(renta, mes)
      fecha = Date.new(Time.now.year, mes.to_i, renta.dia)
      if fecha > Time.now
        return 0
      end
      plazo = current_user.plazos.where("rentas_id = ? AND inicio < ? AND final > ?", renta.id, fecha, fecha).first
      dia = Time.now
      dia = dia.change(day: renta.dia)
      dia = dia.change(month: mes.to_i)
      rent = renta.pagos.select("pagos.fecha as fecha").where("extract(month from pagos.mes) = ? AND pagos.categoria_id = ?", mes, 1).first

      if plazo && rent.nil?
        return (Time.now.to_date - fecha).to_i
      elsif plazo
        return (rent.fecha.to_date - dia.to_date).to_i
      else
        return 0
      end
    end

    def getGastosCat(cat)
      current_user.gastos.where(categoria_id: cat).sum(:monto)
    end

    def getGastosTotal(pro)
      current_user.gastos.where(propiedad: pro).sum(:monto)
    end

    def getPagosCat(cat)
      current_user.pagos.where(categoria_id: cat).sum(:monto)
    end

    def getPagosProTotal(pro)
      current_user.rentas.joins(:pagos).where(propiedad: pro).sum(:monto)
    end

    def getPagosPro(pro)
      current_user.pagos.joins(:rentas).where("rentas.propiedad_id = ?", pro.id)
    end

    def getPagosInqTotal(inq)
      current_user.rentas.joins(:pagos).where(inquilino: inq).sum(:monto)
    end

    def getPagosInq(inq)
      current_user.pagos.joins(:rentas).where("rentas.inquilino_id = ? ", inq.id)
    end

    def getPorcent(plazo)
      inicio = (Time.now.to_date - plazo.inicio.to_date).to_f
      final =  ( plazo.final.to_date - plazo.inicio.to_date ).to_f
      total = (inicio / final) *100
      if total < 0
        return 0
      elsif total > 100
        return 100
      else
        return total
      end
    end

    def distance_of_time_in_words(from_time, to_time = 0, include_seconds = false)
     from_time = from_time.to_time if from_time.respond_to?(:to_time)
     to_time = to_time.to_time if to_time.respond_to?(:to_time)
     distance_in_minutes = (((to_time - from_time).abs)/60).round
     distance_in_seconds = ((to_time - from_time).abs).round

     case distance_in_minutes
       when 0..1
         return (distance_in_minutes == 0) ? 'menos de um minuto' : '1 minuto' unless include_seconds
         case distance_in_seconds
           when 0..4   then 'menos de 5 segundos'
           when 5..9   then 'menos de 10 segundos'
           when 10..19 then 'menos de 20 segundos'
           when 20..59 then 'menos de um minuto'
         else             '1 minuto'
         end

        when 2..44           then "#{distance_in_minutes} minutos"
        when 45..89          then 'aproximadamente 1 hora'
        when 90..1439        then "aproximadamente #{(distance_in_minutes.to_f / 60.0).round} horas"
        when 1440..2879      then '1 dia'
        when 2880..43199     then "#{(distance_in_minutes / 1440).round} dias"
        when 43200..86399    then 'aproximadamente 1 mes'
        when 86400..525959   then "#{(distance_in_minutes / 43200).round} meses"
        when 525960..1051919 then 'aproximadamente 1 año'
     else                      "mas de #{(distance_in_minutes / 525960).round} años"

   end
end
end
