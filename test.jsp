<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="config.SvConfig" %>

<%
	SvConfig svc = new SvConfig();
%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title></title>
  </head>
  <body>
  カレントディレクトリ:<%= svc.getCurrentlyPath() %><br />
  DB名:<%= svc.getDBName() %><br />
  </body>
</html>
