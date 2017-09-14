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

    def pagos_hechos
      rentas_activas.joins(:pagos).select("pagos.id as pid, inquilino_id, propiedad_id, dia, costo, monto, mes, rentas.created_at, rentas.id ").where(["strftime('%m', pagos.mes) >= ? AND pagado == ?", Time.now.strftime("%m"), true])
    end

    def pagos_atrasados
      rentas_activas.joins(:pagos).select("pagos.id as pid, inquilino_id, propiedad_id, dia, costo, mes, rentas.created_at, rentas.id").where(["strftime('%m', pagos.mes) == ? AND pagado == ?", Time.now.strftime("%m"), false])
    # sql = "SELECT pagos.id, inquilino_id, propiedad_id, dia
    #                               FROM          rentas
    #                               JOIN users    ON rentas.user_id == user.id
    #                               LEFT JOIN     pagos    ON rentas.id == rentas_id
    #                               WHERE         rentas.dia < strftime('%d')
    #                               group by (rentas.id);"
    #                           records_array = ActiveRecord::Base.connection.execute(sql)
    #                           puts records_array
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
      return getTotalPagado(renta) - meses * renta["costo"]
    end

    def getTotalPagado(renta)
     Rentas.joins(:pagos).where("rentas.id ==?",   renta.id ).sum(:monto)
    end

    def getIngreso(mes)
      fecha = Date.new(Time.now.year, mes, 28)
      current_user.rentas.where( "final > ? AND created_at < ?", fecha, fecha).sum(:costo)
    end

    def getIngresoReal(mes)
      current_user.rentas.joins(:pagos).where("strftime('%m', pagos.mes) == ?", mes).sum(:monto)
    end

end
