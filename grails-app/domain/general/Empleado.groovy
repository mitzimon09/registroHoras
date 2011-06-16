package general

class Empleado {

    String username
    String password
    boolean enabled = false
    boolean accountExpired = false
    boolean accountLocked = false
    boolean passwordExpired = false
    String nombre
    String apellidoPaterno
    String apellidoMaterno
    String facultad
    String horario
    String telefono
    String correo
    String nombreCompleto
    
    static transients = ['nombreCompleto']

    static constraints = {
        username blank: false, unique: true, size:1..64
        password blank: false, size:1..64
        nombre blank: false, size:1..64
        apellidoPaterno blank: false, size:1..64
        apellidoMaterno blank: true, size:1..64
        facultad blank: false, size:1..64
        horario blank: false, size:1..64
        telefono blank: false, size:1..10
        correo nullable: true, size:1..128, email:true
    }

    static mapping = {
        table 'empleados'
        password column: '`password`'
    }

    static namedQueries = {
        listaConFiltro { filtro ->
            filtro = "%$filtro%"
            or {
                ilike('username',filtro)
                ilike('nombre',filtro)
                ilike('apellidoPaterno',filtro)
                ilike('apellidoMaterno',filtro)
                ilike('facultad',filtro)
                ilike('horario',filtro)
                ilike('telefono',filtro)
                ilike('correo',filtro)
            }
        }
    }

    Set<Rol> getAuthorities() {
        EmpleadoRol.findAllByEmpleado(this).collect { it.rol } as Set
    }

    String getNombreCompleto() {
        if(apellidoMaterno == ""){
            return "$apellidoPaterno, $nombre"
        }else{
            return "$apellidoPaterno $apellidoMaterno, $nombre"
        }
    }

    String toString() {
        return "$nombreCompleto"
    }
}
