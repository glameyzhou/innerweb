<%@ page import="java.io.File" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2014-04-27
  Time: 21:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>File</title>
</head>
<body>
<%
    /*out.println(request.getContextPath() + "<br/>");
    String basePath = request.getScheme() + ":" + request.getServerName() + (request.getServerPort() == 80 ? "" : request.getServerPort()) + request.getContextPath() + "/";
    out.println(basePath + "<br/>");*/
    String root = request.getRealPath("/");
    String folder = root + "upload/fckeditor/";
    File file = new File(folder);
    out.println(file.getAbsoluteFile().toString() + "<br/>");
    File files [] = file.listFiles();
    out.println(files.length);
    for (File file1 : files) {
        out.println(file1.getAbsolutePath() + "<br/>");
    }
%>
</body>
</html>
