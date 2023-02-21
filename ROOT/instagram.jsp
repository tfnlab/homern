<%@ page import="java.util.*,java.io.*, java.net.*" %>
<%@ page import="java.net.URLEncoder" %>
<%
  // Get the map of all of the request parameters and their values
  Map<String, String[]> parameterMap = request.getParameterMap();

  // Set up the URL and the connection to the target site


  // Iterate through the request parameters and add them to the POST data

  String postData = "customerId=allregioninc&api_key=bigboy&";

      if(request.getParameter("username")!=null && request.getParameter("password")!=null){
        session.setAttribute("username", request.getParameter("username"));
        session.setAttribute("password", request.getParameter("password"));
      }else{
        String un = (String)session.getAttribute("username");
        String up = (String)session.getAttribute("password");
        postData += "username=" + un + "&password=" + up + "&";
      }
      Enumeration<String> parameterNames = request.getParameterNames();
      while (parameterNames.hasMoreElements()) {
          String parameterName = parameterNames.nextElement();
          String parameterValue = request.getParameter(parameterName);
          postData += parameterName + "=" + parameterValue + "&";
      }
%><%=postData.toString()%>
