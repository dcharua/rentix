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
      rentas_activas.joins(:pagos).select("inquilino_id, propiedad_id, dia").where(["pagos.mes == ?", Time.now.strftime("%m")])
    end

    def pagos_atrasados
    rentas_activas.joins("LEFT JOIN pagos ON rentas.id == rentas_id").select("pagos.id, inquilino_id, propiedad_id, dia").where("rentas.dia <	strftime('%d')")
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
end
