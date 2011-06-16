<html>
  <head>
    <title><g:message code="empleado.lista" /></title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />
  </head>
  <body>
    <div class="nav">
      <ul>
        <li><g:link class="home" controller="admin"><g:message code="general.admin" /></g:link></li>
        <li><g:link class="list" action="nuevo"><g:message code="empleado.nuevo" /></g:link></li>
      </ul>  </div>
    <div class="body">
      <h1><g:message code="empleado.lista" /></h1>
      <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
      </g:if>
      <div class="search">
        <g:form method="post">
          <div>
            <table>
              <tbody>
                <tr>
                  <td style="vertical-align:middle;width:95px;">
                    <label for="filtro"><g:message code="empleado.buscar" />:</label>
                  </td>
                  <td style="width:320px; vertical-align: middle;">
                    <input type="text" maxlength="64" size="32" id="filtro" name="filtro" value="${params.filtro}" style="width:300px;"/>
                  </td>
                  <td>
              <g:actionSubmit action="lista" value="${message(code:'general.buscar')}" class="save" style="vertical-align: middle;" />
              </td>
              </tr>
              </tbody>
            </table>
          </div>
        </g:form>
      </div>
      <div class="list">
        <table id="empleados">
          <thead>
            <tr>
          <g:sortableColumn property="username" title="${message(code:'empleado.username')}" />
          <g:sortableColumn property="nombreCompleto" title="${message(code:'empleado.nombreCompleto')}" />
          <g:sortableColumn property="enabled" title="${message(code:'empleado.enabled')}" />
          <g:sortableColumn property="facultad" title="${message(code:'empleado.facultad')}" />
          <g:sortableColumn property="telefono" title="${message(code:'empleado.telefono')}" />
          <g:sortableColumn property="correo" title="${message(code:'empleado.correo')}" />
          </tr>
          </thead>
          <tbody>
          <g:each in="${empleados}" status="i" var="empleado">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
              <td><g:link action="ver" id="${empleado.id}">${fieldValue(bean: empleado, field: "username")}</g:link></td>
            <td>${fieldValue(bean: empleado, field: "nombreCompleto")}</td>
            <td><g:checkBox name="enabled" value="${empleado.enabled}" disabled="true"/></td>
            <td>${fieldValue(bean: empleado, field: "facultad")}</td>
            <td>${fieldValue(bean: empleado, field: "telefono")}</td>
            <td>${fieldValue(bean: empleado, field: "correo")}</td>
            </tr>
          </g:each>
          </tbody>
        </table>
      </div>
      <div class="paginateButtons">
        <g:paginate total="${totalDeEmpleados}" />
      </div>
    </div>
  <g:javascript>
    jQuery(document).ready(function() {
    jQuery('#filtro').focus();
    });
  </g:javascript>
</body>
</html>
