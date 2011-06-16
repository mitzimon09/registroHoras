package general

import grails.plugins.springsecurity.Secured
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils

@Secured(['ROLE_PROF'])
class EmpleadoController {

    def empleadoService
    def springSecurityService

    def index = {
        redirect(action: lista, params: params)
    }

    def lista = {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def resultado = empleadoService.listaConCantidad(params)
        [empleados: resultado.lista, totalDeEmpleados: resultado.cantidad]
    }

    def nuevo = {
        Empleado empleado = new Empleado(params)
        empleado.enabled = true

        def roles = obtieneListaDeRoles(null)
        
        return [empleado:empleado, roles:roles]
    }

    def crea = {
        def empleado
        try {
            Empleado.withTransaction {
                empleado = new Empleado(params)
                empleado.password = springSecurityService.encodePassword(params.password)
                def roles = [] as Set
                if (params.ROLE_ADMIN) {
                    roles << Rol.findByAuthority('ROLE_ADMIN')
                }else if (params.ROLE_EMP) {
                    roles << Rol.findByAuthority('ROLE_PROF')
                } else {
                    roles << Rol.findByAuthority('ROLE_USER')
                }
                empleado = empleadoService.crea(empleado, roles)

                flash.message = message(code:"empleado.crea",args:[empleado.username])
                redirect(action:"lista", id:empleado.id)
            }
        } catch(Exception e) {
            log.error("No se pudo crear el empleado",e)
            if (empleado) {
                empleado.discard()
            }
            flash.message = message(code:"empleado.noCrea")
            render(view:"nuevo", model: [empleado: empleado])
        }
    }

    def ver = {
        def empleado = empleadoService.obtiene(params.id)
        def roles = obtieneListaDeRoles(empleado)
        return [empleado:empleado, roles:roles]
    }

    def edita = {
        def empleado = empleadoService.obtiene(params.id)
        def roles = obtieneListaDeRoles(empleado)
        return [empleado:empleado, roles:roles]
    }

    def actualiza = {
        def empleado = empleadoService.obtiene(params.id)
        try {
            Empleado.withTransaction {
                def cambioPasswd = false
                if (!empleado.password.equals(params.password)) {
                    cambioPasswd = true
                }
                empleado.properties = params
                if (cambioPasswd) {
                    empleado.password = springSecurityService.encodePassword(params.password)
                }
                def roles = [] as Set
                if (params.ROLE_ADMIN) {
                    roles << Rol.findByAuthority('ROLE_ADMIN')
                } else if (params.ROLE_ADMIN) {
                    roles << Rol.findByAuthority('ROLE_PROF')
                } else {
                    roles << Rol.findByAuthority('ROLE_USER')
                }

                empleado = empleadoService.actualiza(empleado,roles)

                if (springSecurityService.loggedIn &&
                    springSecurityService.principal.username == empleado.username) { 
                    springSecurityService.reauthenticate empleado.username
                }
                flash.message = message(code:"empleado.actualiza",args:[empleado.username])
                redirect(action:"lista",id:empleado.id)
            }
        } catch(Exception e) {
            log.error("No se pudo actualizar el empleado",e)
            if (empleado) {
                empleado.discard()
            }
            flash.message = message(code:"empleado.noActualiza")
            render(view:"edita",model:[empleado:empleado])
        }
    }

    def elimina = {
        try {
            Empleado.withTransaction {
                def nombre = empleadoService.elimina(params.id)
                flash.message = message(code:"empleado.baja", args:[nombre])
                redirect(action:'lista')
            }
        } catch(Exception e) {
            log.error("No se pudo dar de baja el empleado",e)
            flash.message = message(code:"empleado.noBaja")
            render(view:'ver',model:[empleado:empleadoService.obtiene(params.id)])
        }
    }

    Map obtieneListaDeRoles(empleado) {
        def roles = Rol.list()

        def rolesFiltrados = [] as Set
        if (SpringSecurityUtils.ifAnyGranted('ROLE_ADMIN')) {
            rolesFiltrados = roles
     
        } else if(SpringSecurityUtils.ifAnyGranted('ROLE_PROF')) {
            for(rol in roles) {
                if (rol.authority.equals('ROL_USER')) {
                    rolesFiltrados << rol
                }
            }
        } else (rol.authority.equals('ROL_USER')) {
            rolesFiltrados << rol
        }

        roles.sort { r1, r2 ->
            r1.authority <=> r2.authority
        }
        Set userRoleNames = []
        for (role in empleado?.authorities) {
            userRoleNames << role.authority
        }
        LinkedHashMap<Rol, Boolean> roleMap = [:]
        for (role in roles) {
            roleMap[(role)] = userRoleNames.contains(role.authority)
        }
        return roleMap
    }

    @Secured(['ROLE_USER'])
    def perfil = {
        def empleado = Empleado.get(springSecurityService.getPrincipal().id)
        return [empleado:empleado]
    }

    @Secured(['ROLE_USER'])
    def actualizaPerfil = {
        def empleado = empleadoService.obtiene(params.id)
        try {
            Empleado.withTransaction {
                def cambioPasswd = false
                if (!empleado.password.equals(params.password)) {
                    cambioPasswd = true
                }
                empleado.properties = params
                if (cambioPasswd) {
                    empleado.password = springSecurityService.encodePassword(params.password)
                }

                empleado = empleadoService.actualiza(empleado,null)

                flash.message = message(code:"empleado.mensaje.actualizaPerfil",args:[params.nombre])
                redirect(uri:'/')
            }
        } catch(Exception e) {
            log.error("No se pudo actualizar el empleado",e)
            if (empleado) {
                empleado.discard()
            }
            flash.message = message(code:"empleado.mensaje.noActualizaPerfil")
            render(view:"edita",model:[empleado:empleado])
        }
    }
}

