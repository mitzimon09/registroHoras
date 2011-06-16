<html>
  <head>
    <title><g:message code="admin.titulo"/></title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="layout" content="main" />
  </head>
  <body>
    <div class="nav">
      <ul>
        <li><a class="home" href="${resource(dir: '')}"><g:message code="general.inicio"/></a></li>
        <li><g:link class="list" controller="empleado"><g:message code="empleado.lista"/></g:link></li>
      </ul>
    </div>
    <div class="body">
      <h1><g:message code="admin.titulo"/></h1>
      <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
      </g:if>
    </div>
  </body>
</html>
