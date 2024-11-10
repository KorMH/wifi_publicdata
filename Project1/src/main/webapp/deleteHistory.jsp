<%@ page import = "pubdata.DatabaseControl"%>
<%@ page import = "pubdata.APICall"%>
<%@ page import = "org.json.simple.*" %>
<%@ page import = "org.json.simple.parser.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.io.*" %>
<%@ page import = "java.net.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.sql.Date" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<body>
    <%
        String deleteIdParam = request.getParameter("deleteId");
        if (deleteIdParam != null && !deleteIdParam.isEmpty()) {
            try {
                int deleteId = Integer.parseInt(deleteIdParam);
                out.println(Integer.toString(deleteId));
                
                DatabaseControl dbControl = new DatabaseControl();
                dbControl.deleteSearchLog(deleteId);
            } catch (NumberFormatException e) {
                out.println("잘못된 ID 형식입니다.");
            }
        } else {
            out.println("ID 파라미터가 없습니다.");
        }
    %>
    
    <%
        pageContext.forward("./History.jsp");
    %>

</body>

</html>
