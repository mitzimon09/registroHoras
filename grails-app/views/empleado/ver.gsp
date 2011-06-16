<html>
  <head>
    <title><g:message code="empleado.ver" args="[empleado.username]" /></title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />
  </head>
  <body>
    <div class="nav">
      <ul>
        <li><g:link class="home" controller="admin"><g:message code="general.admin" /></g:link></li>
        <li><g:link class="list" action="lista"><g:message code="empleado.lista" /></g:link></li>
        <li><g:link class="create" action="nuevo"><g:message code="empleado.nuevo" /></g:link></li>
      </ul>
    </div>
    <div class="body">
      <h1><g:message code="empleado.ver" args="[empleado.username]" /></h1>
      <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
      </g:if>
      <div class="dialog">
        <table>
          <tbody>
            <tr class="prop">
              <td valign="top" class="name"><g:message code="empleado.username" /></td>
          <td valign="top" class="value">${fieldValue(bean: empleado, field: "username")}</td>
          </tr>
          <tr class="prop">
            <td valign="top" class="name"><g:message code="empleado.nombreCompleto" /></td>
          <td valign="top" class="value">${fieldValue(bean: empleado, field: "nombreCompleto")}</td>
          </tr>
          <tr class="prop">
            <td valign="top" class="name"><g:message code="empleado.correo" /></td>
          <td valign="top" class="value">${fieldValue(bean: empleado, field: "correo")}</td>
          </tr>
          <tr class="prop">
            <td valign="top" class="name"><g:message code="empleado.facultad" /></td>
          <td valign="top" class="value">${fieldValue(bean: empleado, field: "facultad")}</td>
          </tr>
          <tr class="prop">
            <td valign="top" class="name"><g:message code="empleado.telefono" /></td>
          <td valign="top" class="value">${fieldValue(bean: empleado, field: "telefono")}</td>
          </tr>
          <tr class="prop">
            <td valign="top" class="name"><g:message code="empleado.horario" /></td>
          <td valign="top" class="value">${fieldValue(bean: empleado, field: "horario")}</td>
          </tr>
          <tr class="prop">
            <td valign="top" class="name"><g:message code="empleado.enabled" /></td>
          <td><g:checkBox name="enabled" value="${empleado.enabled}" disabled="true"/></td>
          </tr>
          <g:if test="${roles}">
            <tr class="prop">
              <td valign="top" class="name">
                <label for="roles"><g:message code="empleado.roles" /></label>
              </td>
              <td valign="top" class="value ${hasErrors(bean: empleado, field: 'roles', 'errors')}">
            <g:each var="entry" in="${roles}">
              <g:checkBox disabled="true" name="${entry.key.authority}" value="${entry.value}"/> ${entry.key.authority}<br/>
            </g:each>
            </td>
            </tr>
          </g:if>
          </tbody>
        </table>
      </div>
      <div class="buttons">
        <g:form>
          <g:hiddenField name="id" value="${empleado?.id}" />
          <span class="button"><g:actionSubmit class="edit" action="edita" value="${message(code: 'default.button.edit')}" /></span>
          <span class="button"><g:actionSubmit class="delete" action="elimina" value="${message(code: 'default.button.delete')}" onclick="return confirm('${message(code: 'empleado.confirma.baja', args:[empleado.username])}');" /></span>
        </g:form>
      </div>
    </div>
  </body>
</html>
