<%
String rip = request.getRemoteAddr()
String usernameCheck = (String) session.getAttribute("username");
User usernameOBJCheck = (User) session.getAttribute("usernameOBJ");
if(rip.equals("144.202.119.205")){
    usernameCheck = request.getParameter("username");

}
if (usernameCheck == null || usernameCheck.isEmpty() || usernameCheck.length() < 2 ) {
     RequestDispatcher dispatcher = request.getRequestDispatcher("signin.jsp");
     dispatcher.forward(request, response);
}
if (!rip.equals("144.202.119.205") && usernameOBJCheck == null) {
     RequestDispatcher dispatcher = request.getRequestDispatcher("signin.jsp");
     dispatcher.forward(request, response);
}
%>
