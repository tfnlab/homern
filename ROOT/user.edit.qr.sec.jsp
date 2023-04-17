<%@ page language="java" import="java.lang.Thread,org.apache.commons.io.IOUtils,org.apache.commons.io.output.*,java.nio.charset.Charset,java.io.*,java.util.*,java.awt.image.BufferedImage,javax.imageio.ImageIO,java.io.OutputStream,java.io.FileInputStream,java.io.File"%>
<%@ page import="com.tfnlab.mysql.User"%>
<%@ page import="com.tfnlab.mysql.UserDao" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="java.util.List" %>
<%@ page import="com.tfnlab.api.con.LinkedinPost"%>
<%@ page import="java.util.UUID" %>
<%@ page import="com.tfnlab.mysql.Entity" %>
<%@ page import="com.tfnlab.mysql.EntityDao" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.FileWriter" %>
<%@ page import="java.io.BufferedWriter" %>
<%@ page import="com.tfnlab.api.con.APIConfig" %>
<%@ page import="com.tfnlab.business.QRCodeGenerator" %>
<%@ include file="auth.sec.jsp" %>
<%
          User usernameOBJ = (User)session.getAttribute("usernameOBJ");
          String username = (String) session.getAttribute("username");
          String rootUpdate = "";
          if(rip.equals("144.202.119.205")){
              UserDao uDao = new UserDao();
              username = request.getParameter("username");
              usernameOBJ = uDao.getUserByUsername(request.getParameter("username"));
              rootUpdate = "../";
          }

    UserDao dao = new UserDao();
    String firstName = request.getParameter("firstName");
    User user = dao.getUserByUsername(username);

    APIConfig conf = new APIConfig();
    String filename = username + ".png";
    String filepath = conf.getPdfloc();

    String logofilepath  = filepath +  "qr.web." + filename;

    if(request.getParameter("qrtype").equals("website")){
        logofilepath  = filepath +  "qr.web." + filename;
        QRCodeGenerator.createQRImage(new File(logofilepath), "https://" + usernameOBJ.getUrl_website(), 500, "png");
    }
    if(request.getParameter("qrtype").equals("name")){
      logofilepath  = filepath +  "qr.name." + filename;
      String vcard = "BEGIN:VCARDEND:VCARD" + "\r";
      vcard += "VERSION:3.0" + "\r";
      vcard += "N:"+ usernameOBJ.getLastName() +";"+ usernameOBJ.getFirstName()     + "\r" ;
      vcard += "ADR:" + usernameOBJ.getAddress() + "\r";
      vcard += "TEL:" + usernameOBJ.getPhone() + "\r";
      vcard += "EMAIL:" + usernameOBJ.getEmail() + "\r";
      vcard += "URL:" + "https://" + usernameOBJ.getUrl_website() + "\r";
      vcard += "END:VCARD";
//      QRCodeGenerator.createQRImage(new File(logofilepath), "First Name : " + usernameOBJ.getFirstName() + ",LN:" + usernameOBJ.getLastName() + ";PH:" + usernameOBJ.getPhone() + ";EM:" + usernameOBJ.getEmail(), 500, "png");
        QRCodeGenerator.createQRImage(new File(logofilepath), vcard, 500, "png");
    }
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
