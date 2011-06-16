package general

import org.apache.commons.lang.builder.HashCodeBuilder

class EmpleadoRol implements Serializable {

    Empleado empleado
    Rol rol

    boolean equals(other) {
        if (!(other instanceof EmpleadoRol)) {
            return false
        }
        other.empleado?.id == empleado?.id &&
        other.rol?.id == rol?.id
    }

    int hashCode() {
        def builder = new HashCodeBuilder()
        if (empleado) builder.append(empleado.id)
        if (rol) builder.append(rol.id)
        builder.toHashCode()
    }

    static EmpleadoRol get(long empleadoId, long rolId) {
        find 'from EmpleadoRol where empleado.id=:empleadoId and rol.id=:rolId',
        [empleadoId: empleadoId, rolId: rolId]
    }

    static EmpleadoRol create(Empleado empleado, Rol rol, boolean flush = false) {
        new EmpleadoRol(empleado: empleado, rol: rol).save(flush: flush, insert: true)
    }

    static boolean remove(Empleado empleado, Rol rol, boolean flush = false) {
        EmpleadoRol instance = EmpleadoRol.findByEmpleadoAndRol(empleado, rol)
        instance ? instance.delete(flush: flush) : false
    }

    static void removeAll(Empleado empleado) {
        executeUpdate 'DELETE FROM EmpleadoRol WHERE empleado=:empleado', [empleado: empleado]
    }

    static void removeAll(Rol rol) {
        executeUpdate 'DELETE FROM EmpleadoRol WHERE rol=:rol', [rol: rol]
    }

    static mapping = {
        id composite: ['rol', 'empleado']
        version false
    }
}
