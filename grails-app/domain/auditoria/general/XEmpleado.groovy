package auditoria.general

class XEmpleado implements java.io.Serializable {
    String username
    String password
    boolean enabled
    boolean accountExpired
    boolean accountLocked
    boolean passwordExpired
    String nombre
    String apellidoPaterno
    String apellidoMaterno
    String correo
    String nombreCompleto
    String roles
    Long empleadoId
    Date lastUpdated
    String actividad
    String creador
    
    static transients = ['nombreCompleto']

    static constraints = {
        username blank: false, size:1..64
        password blank: false, size:1..128
        nombre blank: false, size:1..64
        apellidoPaterno blank: false, size:1..64
        apellidoMaterno nullable:true, blank: true, size:1..64
        correo nullable: true, size:1..128, email:true
        actividad size:1..32
        creador size:1..64
    }

    static mapping = {
        table 'xempleados'
        password column: '`password`'
    }

    String getNombreCompleto() {
        return "$apellidoPaterno $apellidoMaterno, $nombre"
    }

    String toString() {
        return "$nombreCompleto"
    }
}
