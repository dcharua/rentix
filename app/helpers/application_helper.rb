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
     current_user.rentas.where( "final > ? ", Time.now)
    end

    def rentas_terminadas
     current_user.rentas.where( "final < ? ", Time.now)
    end

    def pagos_hechos
      rentas_activas.joins(:pagos).select("pagos.id as pid, inquilino_id, propiedad_id, dia, costo, monto, mes, rentas.created_at, rentas.id ").where(["strftime('%m', pagos.mes) >= ? AND pagado == ? AND pagos.categoria_id == ?", Time.now.strftime("%m"), true, 1])
    end


    def pagos_mantenimiento
      rentas_activas.joins(:pagos).select("pagos.id as pid, inquilino_id, propiedad_id, pagos.fecha, monto, comentarios,  rentas.id ").where(["strftime('%m', pagos.mes) >= ? AND pagado == ? AND pagos.categoria_id == ?", Time.now.strftime("%m"), true, 3])
    end

    def pagos_garantia
      rentas_activas.joins(:pagos).select("pagos.id as pid, inquilino_id, propiedad_id, pagos.fecha, monto, comentarios,  rentas.id ").where(["strftime('%m', pagos.mes) >= ? AND pagado == ? AND pagos.categoria_id == ?", Time.now.strftime("%m"), true, 2])
    end

    def pagos_otro
      rentas_activas.joins(:pagos).select("pagos.id as pid, inquilino_id, propiedad_id, pagos.fecha, monto, comentarios,  rentas.id ").where(["strftime('%m', pagos.mes) >= ? AND pagado == ? AND pagos.categoria_id == ?", Time.now.strftime("%m"), true, 4])
    end

    def pagos_atrasados
      rentas_activas.joins(:pagos).select("pagos.id as pid, inquilino_id, propiedad_id, dia, costo, mes, rentas.created_at, rentas.id").where(["strftime('%m', pagos.mes) == ? AND pagado == ?", Time.now.strftime("%m"), false])
    end

    def pagos_proximos
      rentas_activas.joins("LEFT JOIN pagos ON rentas.id == rentas_id").select("pagos.id, inquilino_id, propiedad_id, dia").where("rentas.dia >=	strftime('%d')")

      #rentas_activas.joins(:pagos).select("pagos.id AS pago, inquilino_id, propiedad_id, dia").where("rentas.dia >=	strftime('%d') ")
      # sql = "SELECT pagos.id, inquilino_id, propiedad_id, dia
      #                               FROM          rentas
      #                               JOIN users    ON rentas.user_id == users.id
      #                               LEFT JOIN     pagos    ON rentas.id == rentas_id
      #                               WHERE         rentas.dia > strftime('%d')
      #                               group by (rentas.id);"
      #                           records_array = ActiveRecord::Base.connection.execute(sql)
    end

    def rentas_por_vencer
      time = Time.now + 2.month
      current_user.rentas.where( "final < ? AND final > ? ", time, Time.now)
    end

    def getBalance(renta)
      inicio = renta["created_at"].to_date
      final = Time.now
      inicio = inicio.change(day: renta["dia"])
      meses = (final.year * 12 + final.month) - (inicio.year * 12 + inicio.month)
      if inicio.day < final.day
        meses = meses +1
      end
      return  meses * renta["costo"] - getTotalPagado(renta)
    end




    def getBalanceMes(renta, mes)
      inicio = renta["created_at"].to_date
      final = Time.now
      final = final.change(month: mes)
      inicio = inicio.change(day: renta["dia"])
      if final > inicio && final < Time.now
        meses = (final.year * 12 + final.month) - (inicio.year * 12 + inicio.month)
        if inicio.day < final.day
          meses = meses +1
        end
        return (meses * renta["costo"]) - getTotalPagado(renta)
      else
        return 0
      end
    end

    def getTotalPagado(renta)
     current_user.rentas.joins(:pagos).where("rentas.id ==? AND pagos.categoria_id == ?", renta.id, 1 ).sum(:monto)
    end

    def getRetraso(renta, mes)
      dia = Time.now
      dia = dia.change(day: renta.dia)
      dia = dia.change(month: mes.to_i)
      rent = renta.pagos.select("pagos.fecha").where("strftime('%m', pagos.mes) == ? AND pagado == ? AND pagos.categoria_id == ?", mes, true, 1)
      if rent.blank?
        return 0
      else
        return (rent[0].fecha.to_date - dia.to_date).to_i
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
      current_user.pagos.joins(:rentas).where("rentas.propiedad_id = ? AND pagado = ?", pro.id, true)
    end

    def getPagosAtraPro(pro)
      current_user.pagos.joins(:rentas).where(["rentas.propiedad_id =? AND strftime('%m', pagos.mes) == ? AND pagado == ?", pro.id, Time.now.strftime("%m"), false])
    end

    def getPagosInqTotal(inq)
      current_user.rentas.joins(:pagos).where(inquilino: inq).sum(:monto)
    end

    def getPagosInq(inq)
      current_user.pagos.joins(:rentas).where("rentas.inquilino_id = ? AND pagado = ?", inq.id, true)
    end

    def getPagosAtraInq(inq)
      current_user.pagos.joins(:rentas).where(["rentas.inquilino_id =? AND strftime('%m', pagos.mes) == ? AND pagado == ?", inq.id, Time.now.strftime("%m"), false])
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
