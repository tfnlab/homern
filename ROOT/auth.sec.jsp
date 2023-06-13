<%
String rip = request.getHeader("X-Real-IP");
String usernameCheck = null;
if(rip.equals("149.28.77.249") || rip.equals("96.40.155.153")){
    usernameCheck = request.getParameter("username");

}
if (usernameCheck == null || usernameCheck.isEmpty() || usernameCheck.length() < 2 ) {
     RequestDispatcher dispatcher = request.getRequestDispatcher("signin.jsp");
     dispatcher.forward(request, response);
}
%>
