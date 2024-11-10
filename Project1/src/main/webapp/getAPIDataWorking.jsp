<%@ page import = "pubdata.DatabaseControl"%>
<%@ page import = "pubdata.APICall"%>
<%@ page import = "org.json.simple.*" %>
<%@ page import = "org.json.simple.parser.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.io.*" %>
<%@ page import = "java.net.*" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>와이파이 정보 구하기</title>
	
	<style>
		div{
			text-align : center;
		}
	</style>
</head>

<body>

	<%
		// # API 호출 준비
		APICall apiCall = new APICall();
		int startIndex = 0;
		int pageNum = 500;
		String authKey = "71476f536f64766b3131356947476b77";
	
    	
    	// #  API 호출 시작
    	while(true) {
    		apiCall.getData(authKey, Integer.toString(startIndex), Integer.toString(startIndex + pageNum - 1));
    		
        	// # 데이터 호출 종료 조건
        	JSONObject TbPublicWifiInfo = (JSONObject) apiCall.result.get("TbPublicWifiInfo");
        	if(TbPublicWifiInfo == null) {
        		out.println("모든 데이터를 호출하였습니다. 호출을 종료합니다.");
        		break;
        	}
        	
        	out.println(startIndex + " ~ " + Integer.toString(startIndex + pageNum - 1) + " 데이터 호출 성공");
    		startIndex += pageNum;
    	}
    	
    	// # DB에 저장
    	DatabaseControl dbControl = new DatabaseControl();
    	out.println("데이터베이스에 저장중입니다.");
    	dbControl.dbInsert(apiCall.allResult);
    	out.println("데이터베이스에 저장이 완료되었습니다.");
    	
    	
    	request.setAttribute("wifiNum", APICall.wifiNum);
    	pageContext.forward("./getAPIDataDone.jsp");
     			
	%>
</body>
</html>