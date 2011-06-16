<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
  <head>
    <title>R. HORAS - <g:layoutTitle /></title>
    <link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon" />
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}" type="text/css" />
    <g:layoutHead />
    <g:javascript library="jquery" />
  </head>
  <body>
    <div id="spinner" class="spinner" style="display:none;">
      <img src="${resource(contextPath:"",dir:'images',file:'spinner.gif')}" alt="${message(code:'spinner.alt')}" />
    </div>
    <div id="header">
      <g:render template="/common/header" />
    </div>
    <g:layoutBody />
    <div id="footer">
      <g:render template="/common/footer" />
    </div>
  </body>
</html>
