<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*, org.apache.commons.fileupload.*, org.apache.commons.fileupload.servlet.*, org.apache.commons.fileupload.disk.*" %>
<%@ page import="com.tfnlab.mysql.User"%>
<%@ page import="com.tfnlab.mysql.UserDao" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="com.tfnlab.api.con.APIConfig" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="javax.servlet.http.Part" %>
<%@ page import="java.util.List" %>
<%@ page import="org.apache.commons.fileupload.FileItem" %>
<%@ page import="java.util.Collection" %>
<%@ page import="javax.servlet.http.Part" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="java.util.UUID" %>
<%
try{
    User usernameOBJ = (User)session.getAttribute("usernameOBJ");
    String username = (String) session.getAttribute("username");
    String rootUpdate = "";
    if(request.getHeader("X-Real-IP").equals("144.202.119.205") || request.getHeader("X-Real-IP").equals("96.40.155.153")){
        UserDao uDao = new UserDao();
        username = request.getParameter("username");
        usernameOBJ = uDao.getUserByUsername(request.getParameter("username"));
        rootUpdate = "../";
    }

    UserDao dao = new UserDao();
    User user = dao.getUserByUsername(username);
    String contract_id = request.getParameter("contract_id");
    String token_id = request.getParameter("token_id");
    APIConfig conf = new APIConfig();
    String filename = contract_id + "." + token_id + ".png";
    String filepath = conf.getPdfloc();
    String logofilepath  = filepath +  filename;
    FileInputStream fis = new FileInputStream(logofilepath);
    response.setContentType("image/jpeg");
    response.setHeader("Content-Length", String.valueOf(new File(logofilepath).length()));
    byte[] buffer = new byte[1024];
    int length;
    while ((length = fis.read(buffer)) > 0) {
      response.getOutputStream().write(buffer, 0, length);
    }
    fis.close();
}catch(Exception Ex){

  %>ERROR <%=Ex.getMessage()%> <%=request.getParameter("contract_id")%><%
}
%>
