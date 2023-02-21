<%@ page import="com.tfnlab.api.con.GeocodingExample,java.util.Vector, java.io.IOException" %>
<%
  GeocodingExample geocodingExample = new GeocodingExample();
  try {
    String[] results = geocodingExample.search(request.getParameter("search"));
      %><%=results[0]%><ITEM><%
      %><%=results[1]%><ITEM><%
      %><%=results[2]%><ITEM><%
  } catch (IOException e) {
    // handle the exception here
  } finally {
    // close the input stream and scanner objects here
  }
%><%=request.getParameter("sfor")%>
