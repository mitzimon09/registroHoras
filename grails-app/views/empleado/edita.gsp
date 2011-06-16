<html>
  <head>
    <title><g:message code="empleado.edita" args="[empleado.username]" /></title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />
  </head>
  <body>
    <div class="nav">
      <ul>
        <li><g:link class="home" controller="admin"><g:message code="general.admin" /></g:link></li>
        <li><g:link class="list" action="lista"><g:message code="empleado.lista" /></g:link></li>
      </ul>
    </div>
    <div class="body">
      <h1><g:message code="empleado.edita" args="[empleado.username]" /></h1>
      <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
      </g:if>
      <g:hasErrors bean="${empleado}">
        <div class="errors">
          <g:renderErrors bean="${empleado}" as="list" />
        </div>
      </g:hasErrors>
      <g:form action="actualiza" method="post" >
        <g:hiddenField name="id" value="${empleado?.id}" />
        <g:hiddenField name="version" value="${empleado?.version}" />
        <div class="dialog">
          <table>
            <tbody>
              <tr class="prop">
                <td valign="top" class="name">
                  <label for="username"><g:message code="empleado.username" /></label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: empleado, field: 'username', 'errors')}">
            <g:textField name="username" maxlength="64" value="${empleado?.username}" />
            </td>
            </tr>
            <tr class="prop">
              <td valign="top" class="name">
                <label for="password"><g:message code="empleado.password" /></label>
              </td>
              <td valign="top" class="value ${hasErrors(bean: empleado, field: 'password', 'errors')}">
            <g:passwordField name="password" maxlength="64" value="${empleado?.password}" />
            </td>
            </tr>
            <tr class="prop">
              <td valign="top" class="name">
                <label for="nombre"><g:message code="empleado.nombre" /></label>
              </td>
              <td valign="top" class="value ${hasErrors(bean: empleado, field: 'nombre', 'errors')}">
            <g:textField name="nombre" maxlength="64" value="${empleado?.nombre}" />
            </td>
            </tr>
            <tr class="prop">
              <td valign="top" class="name">
                <label for="apellidoPaterno"><g:message code="empleado.apellidoPaterno" /></label>
              </td>
              <td valign="top" class="value ${hasErrors(bean: empleado, field: 'apellidoPaterno', 'errors')}">
            <g:textField name="apellidoPaterno" maxlength="64" value="${empleado?.apellidoPaterno}" />
            </td>
            </tr>
            <tr class="prop">
              <td valign="top" class="name">
                <label for="apellidoMaterno"><g:message code="empleado.apellidoMaterno" /></label>
              </td>
              <td valign="top" class="value ${hasErrors(bean: empleado, field: 'apellidoMaterno', 'errors')}">
            <g:textField name="apellidoMaterno" maxlength="64" value="${empleado?.apellidoMaterno}" />
            </td>
            </tr>
            <tr class="prop">
              <td valign="top" class="name">
                <label for="facultad"><g:message code="empleado.facultad" /></label>
              </td>
              <td valign="top" class="value ${hasErrors(bean: empleado, field: 'facultad', 'errors')}">
            <g:textField name="facultad" maxlength="128" value="${empleado?.facultad}" />
            </td>
            </tr>
            <tr class="prop">
              <td valign="top" class="name">
                <label for="telefono"><g:message code="empleado.telefono" /></label>
              </td>
              <td valign="top" class="value ${hasErrors(bean: empleado, field: 'telefono', 'errors')}">
            <g:textField name="telefono" maxlength="128" value="${empleado?.telefono}" />
            </td>
            </tr>
            <tr class="prop">
              <td valign="top" class="name">
                <label for="horario"><g:message code="empleado.horario" /></label>
              </td>
              <td valign="top" class="value ${hasErrors(bean: empleado, field: 'horario', 'errors')}">
            <g:textField name="horario" maxlength="128" value="${empleado?.horario}" />
            </td>
            </tr>
            <tr class="prop">
              <td valign="top" class="name">
                <label for="enabled"><g:message code="empleado.enabled" /></label>
              </td>
              <td valign="top" class="value ${hasErrors(bean: empleado, field: 'enabled', 'errors')}">
            <g:checkBox name="enabled" value="${empleado?.enabled}" />
            </td>
            </tr>
            <tr class="prop">
              <td valign="top" class="name">
                <label for="correo"><g:message code="empleado.correo" /></label>
              </td>
              <td valign="top" class="value ${hasErrors(bean: empleado, field: 'correo', 'errors')}">
            <g:textField name="correo" maxlength="128" value="${empleado?.correo}" />
            </td>
            </tr>
            <g:if test="${roles}">
              <tr class="prop">
                <td valign="top" class="name">
                  <label for="roles"><g:message code="empleado.roles" /></label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: empleado, field: 'roles', 'errors')}">
              <g:each var="entry" in="${roles}">
                <g:checkBox name="${entry.key.authority}" value="${entry.value}"/> ${entry.key.authority}<br/>
              </g:each>
              </td>
              </tr>
            </g:if>
            </tbody>
          </table>
        </div>
        <div class="buttons">
          <span class="button"><g:submitButton name="lista" class="save" value="${message(code: 'default.button.update')}" /></span>
        </div>
      </g:form>
    </div>
  <g:javascript>
    jQuery(document).ready(function() {
    jQuery('#username').focus();
    });
  </g:javascript>
</body>
</html>
