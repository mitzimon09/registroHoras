<html>
  <head>
    <title><g:message code="general.inicio" /></title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />
  </head>
  <body>
    <div class="nav">
      <ul>
        <li><a class="home" href="${resource(dir: '')}"><g:message code="general.inicio" /></a></li>
        <li><g:link class="list" controller="admin"><g:message code="general.admin" /></g:link></li>
        <sec:ifLoggedIn>
          <li><g:link class="list" controller="usuario" action="perfil"><g:message code="general.perfil" /></g:link></li>
        </sec:ifLoggedIn>
        <sec:ifLoggedIn>
          <li><g:link class="list" controller="logout" ><g:message code="general.salir" /></g:link></li>
        </sec:ifLoggedIn>
        <sec:ifNotLoggedIn>
          <li><g:link class="list" controller="login" ><g:message code="general.login" /></g:link></li>
        </sec:ifNotLoggedIn>
      </ul>
    </div>
    <div class="body">
      <h1>REGISTRO DE HORAS</h1>
      <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
      </g:if>
      <div id="text-body">
        <p>Bienvenido al Sistema para el REGISTRO DE HORAS:</p>
        <ul>
          <li>Gestión de Usuario</li>
          <li>Gestion de Horas</li>
        </ul>
      </div>
    </div>
  </body>
</html>
