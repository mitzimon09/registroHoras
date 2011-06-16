package general

import auditoria.general.XEmpleado

class EmpleadoService {

    static transactional = true
    def springSecurityService
    def sessionFactory

    List<Empleado> lista(def params) {
        log.debug "Lista de empleados"
        def empleados = []
        if (params?.filtro) {
            empleados = Empleado.listaConFiltro(params.filtro).list(params)
        } else {
            empleados = Empleado.list(params)
        }
        return empleados
    }

    def listaConCantidad(def params) {
        def empleados = []
        def cantidad = 0
        if (params?.filtro) {
            empleados = Empleado.listaConFiltro(params.filtro).list(params)
            cantidad = Empleado.listaConFiltro(params).count()
        } else {
            empleados = Empleado.list(params)
            cantidad = Empleado.count()
        }
        return [lista:empleados, cantidad:cantidad]
    }

    Empleado obtiene(String id) {
        return Empleado.get(id)
    }
	
    Empleado crea(Empleado empleado, Set roles) {
        def creador = Empleado.get(springSecurityService.principal.id)
        empleado.save()
        for(rol in roles) {
            general.EmpleadoRol.create(empleado, rol, false)
        }
        audita(empleado,"CREAR")
        return empleado
    }

    Empleado actualiza(Empleado empleado, Set roles) {
        empleado.save()
        if (roles) {
            general.EmpleadoRol.removeAll(empleado)
            sessionFactory.currentSession.flush()

            for(rol in roles) {
                general.EmpleadoRol.create(empleado, rol, false)
            }
        }
        log.debug "Actualizando al empleado $empleado.nombre, $roles"
        audita(empleado,"ACTUALIZAR")
        return empleado
    }

    String elimina(String id) {
        def empleado = Empleado.get(id)
        String nombre = empleado.username
        EmpleadoRol.removeAll(empleado)
        empleado.delete()
        audita(empleado,"ELIMINAR")
        return nombre
    }

    void audita(empleado, actividad) {
        log.debug "[AUDITA] $actividad empleado $empleado.nombre"
        def creador = springSecurityService.authentication.name
        //def xempleado = new XEmpleado(empleado.properties)
        def xempleado = new XEmpleado(empleado.properties)
        StringBuilder roles = new StringBuilder()
        for(rol in empleado.authorities) {
            roles.append(rol.authority)
            roles.append("|")
        }
        xempleado.roles = roles.toString()
        xempleado.empleadoId = empleado.id
        xempleado.creador = creador
        xempleado.actividad = actividad
        xempleado.save()
	}
}
