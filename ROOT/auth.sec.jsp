<%
String rip = request.getHeader("X-Real-IP");
String usernameCheck = null;
User usernameOBJ = null;
String username = null;
String useremail = null;
String rootUpdate = "";
if(rip.equals("149.28.77.249") || rip.equals("96.40.155.153")){
    usernameCheck = request.getParameter("username");
    UserDao uDao = new UserDao();
    username = request.getParameter("username");
    useremail = request.getParameter("hrnemail");
    usernameOBJ = uDao.getUserByUsername(request.getParameter("username"));
    rootUpdate = "../";
    boolean auth = false;
    if (useremail.equals(usernameOBJ.getEmail()) ) {
      auth = true;
    }
    if (usernameOBJ.getHrn_access_email()!=null && usernameOBJ.getHrn_access_email().contains(useremail)) ) {
      auth = true;
    }
    if(!auth){
      RequestDispatcher dispatcher = request.getRequestDispatcher("auth.error.sec.jsp");
      dispatcher.forward(request, response);
    }
}
if (usernameCheck == null || usernameCheck.isEmpty() || usernameCheck.length() < 2 ) {
     RequestDispatcher dispatcher = request.getRequestDispatcher("auth.error.sec.jsp");
     dispatcher.forward(request, response);
}
%>
