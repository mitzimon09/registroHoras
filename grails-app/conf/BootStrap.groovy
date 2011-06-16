import general.*
import org.springframework.security.core.GrantedAuthority
import org.springframework.security.core.authority.GrantedAuthorityImpl
import org.codehaus.groovy.grails.plugins.springsecurity.GrailsUser
import org.springframework.security.core.context.SecurityContextHolder as SCH
import org.springframework.security.authentication.TestingAuthenticationToken

class BootStrap {

    def springSecurityService
    def organizacionService
    def sessionFactory

    def init = { servletContext ->
        log.debug "Creando rol Admin"
        def admin = Rol.findByAuthority('ROLE_ADMIN') ?: new Rol(authority: 'ROLE_ADMIN').save(failOnError: true)

        log.debug "Creando rol Profesor"
        def prof = Rol.findByAuthority('ROLE_PROF') ?: new Rol(authority: 'ROLE_PROF').save(failOnError: true)

        log.debug "Creando rol User"
        def user = Rol.findByAuthority('ROLE_USER') ?: new Rol(authority: 'ROLE_USER').save(failOnError: true)

        log.debug "Creando empleado Admin"
        def empleadoa = Empleado.findByUsername('admin')
        if (!empleadoa){
            empleadoa = new Empleado(
                username : 'admin'
                , password : springSecurityService.encodePassword('admin')
                , enabled : true
                , nombre:'Evijair'
                , apellidoPaterno:'Nuñez'
                , apellidoMaterno:''
                , facultad: 'FIT'
                , horario: 'Mañana'
                , telefono:8261193004
                , correo:'nujev2008@gmail.com'
            ).save(failOnError: true)
        }

        log.debug "Creando empleado Profe"
        def empleadop = Empleado.findByUsername('profe')
        if (!empleadop){
            empleadop = new Empleado(
                username : 'profe'
                , password : springSecurityService.encodePassword('profe')
                , enabled : true
                , nombre:'profe'
                , apellidoPaterno:'profe'
                , apellidoMaterno:''
                , facultad: 'FIT'
                , horario: 'Mañana'
                , telefono:8261193004
                , correo:'profe@profe.com'
            ).save(failOnError: true)
        }

		log.debug "Creando empleado Test"
        def empleadot = Empleado.findByUsername('test')
        if (!empleadot){
            empleadot = new Empleado(
                username : 'test'
                , password : springSecurityService.encodePassword('test')
                , enabled : true
                , nombre:'test'
                , apellidoPaterno:'test'
                , apellidoMaterno:'test'
                , facultad: 'FIT'
                , horario: 'Mañana'
                , telefono:8261193004
                , correo:'test@test.com'
            ).save(failOnError: true)
        }

        log.debug "Creando Relacion rol empleado"
        if (!empleadoa.authorities.contains(admin)){
            EmpleadoRol.create(empleadoa, admin)
        }
        if (!empleadop.authorities.contains(user)){
            EmpleadoRol.create(empleadop, prof)
        }
        if (!empleadot.authorities.contains(user)){
            EmpleadoRol.create(empleadot, user)
        }
        
        log.debug "Aplicación Iniciada Correctamente"
    }

    def destroy = {
    }

    def authenticateAdmin() {
        def credentials = '159753'
        def user = new Empleado(
                username:'admin'
                ,password:credentials
            )
        def authorities = [new GrantedAuthorityImpl('ROLE_ADMIN'),new GrantedAuthorityImpl('ROLE_USER')]
        def principal = new GrailsUser(user.username,credentials,true,true,true,true,authorities,user.id)
        authenticate(principal,credentials,authorities)
    }

    def authenticate(principal, credentials, authorities) {
        def authentication = new TestingAuthenticationToken(principal, credentials, authorities as GrantedAuthority[])
        authentication.authenticated = true
        SCH.context.authentication = authentication
        return authentication
    }

    def logout() {
        SCH.context.authentication = null
    }
} 
