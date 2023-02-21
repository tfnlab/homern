<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<%
    String firstName = request.getParameter("filename");
    APIConfig conf = new APIConfig();
    String filename = firstName + ".png";
    String filepath = conf.getPdfloc();
    String logofilepath  = filepath +  "../img/" + filename;
    response.setContentType("image/jpeg");
//    response.setContentLength(new File(logofilepath).length());
    response.setHeader("Content-Length", String.valueOf(new File(logofilepath).length()));

    FileInputStream fis = new FileInputStream(logofilepath);
    byte[] buffer = new byte[1024];
    int length;
    while ((length = fis.read(buffer)) > 0) {
      response.getOutputStream().write(buffer, 0, length);
    }
    fis.close();
%>
