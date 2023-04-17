<%
String usernameCheck = (String) session.getAttribute("username");
User usernameOBJCheck = (User) session.getAttribute("usernameOBJ");
if (usernameCheck == null || usernameCheck.isEmpty() || usernameCheck.length() < 2 ) {
     RequestDispatcher dispatcher = request.getRequestDispatcher("signin.jsp");
     dispatcher.forward(request, response);
}
if (usernameOBJCheck == null) {
     RequestDispatcher dispatcher = request.getRequestDispatcher("signin.jsp");
     dispatcher.forward(request, response);
}
%>
