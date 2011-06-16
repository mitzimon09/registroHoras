<html>
  <head>
    <title><g:message code="empleado.perfil" /></title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="layout" content="main" />
  </head>
  <body>
    <div class="nav">
      <ul>
        <li><a class="home" href="${resource(dir: '')}"><g:message code="general.inicio" /></a></li>
      </ul>
    </div>
    <div class="body">
      <h1><g:message code="empleado.perfil" /></h1>
      <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
      </g:if>
      <g:hasErrors bean="${empleado}">
        <div class="errors">
          <g:renderErrors bean="${empleado}" as="list" />
        </div>
      </g:hasErrors>
      <g:form method="post" >
        <input type="hidden" name="id" value="${empleado?.id}" />
        <input type="hidden" name="version" value="${empleado?.version}" />
        <input type="hidden" name="perfil" value="true" />
        <div class="dialog">
          <table>
            <tbody>
              <tr class="prop">
                <td valign="top" class="name"><label for="nombre"><g:message code="empleado.nombre" /></label></td>
                <td valign="top" class="value ${hasErrors(bean:empleado,field:'nombre','errors')}">
                  <input type="text" id="nombre" name="nombre" value="${empleado.nombre}"/>
                </td>
              </tr>
              <tr class="prop">
                <td valign="top" class="name"><label for="apellidoPaterno"><g:message code="empleado.apellidoPaterno" /></label></td>
                <td valign="top" class="value ${hasErrors(bean:empleado,field:'apellidoPaterno','errors')}">
                  <input type="text" id="apellidoPaterno" name="apellidoPaterno" value="${empleado.apellidoPaterno}"/>
                </td>
              </tr>
              <tr class="prop">
                <td valign="top" class="name"><label for="apellidoMaterno"><g:message code="empleado.apellidoMaterno" /></label></td>
                <td valign="top" class="value ${hasErrors(bean:empleado,field:'apellidoMaterno','errors')}">
                  <input type="text" id="apellidoMaterno" name="apellidoMaterno" value="${empleado.apellidoMaterno}"/>
                </td>
              </tr>
              <tr class="prop">
                <td valign="top" class="name"><label for="passwd"><g:message code="empleado.password" /></label></td>
                <td valign="top" class="value ${hasErrors(bean:empleado,field:'password','errors')}">
                  <input type="password" id="password" name="password" value="${empleado.password.encodeAsHTML()}"/>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
        <div class="buttons">
          <span class="button"><g:actionSubmit class="save" value="${message(code: 'empleado.actualizaPerfil')}" action="actualizaPerfil" /></span>
        </div>
      </g:form>
    </div>
  <g:javascript>
    jQuery(document).ready(function() {
    jQuery('#nombre').focus();
    });
  </g:javascript>
</body>
</html>
