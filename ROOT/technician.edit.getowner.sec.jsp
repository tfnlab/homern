<%@ page language="java" import="com.tfnlab.mysql.User,com.tfnlab.mysql.UserDao,com.tfnlab.mysql.Entity,com.tfnlab.mysql.EntityDao,com.tfnlab.mysql.Order,com.tfnlab.mysql.OrderDao,com.tfnlab.mysql.User,com.tfnlab.mysql.TemplateDao,com.tfnlab.mysql.Template,java.util.UUID,java.lang.Thread,org.apache.commons.io.IOUtils,org.apache.commons.io.output.*,java.nio.charset.Charset,java.io.*,java.util.*,java.awt.image.BufferedImage,javax.imageio.ImageIO,java.io.OutputStream,java.io.FileInputStream,java.io.File"%><%


  String username = (String) session.getAttribute("username");
  UUID uuid = UUID.randomUUID();
  String strRes = "";
  User usernameOBJ = (User) session.getAttribute("usernameOBJ");
  String rootUpdate = "";
  if(rip.equals("144.202.119.205")){
      UserDao uDao = new UserDao();
      username = request.getParameter("username");
      usernameOBJ = uDao.getUserByUsername(request.getParameter("username"));
      rootUpdate = "../";
  }

  if(username!=null && username.length() >1 ){

    Process pweb3 = new ProcessBuilder("python3", "/var/lib/tomcat9/webapps/py/ownerof.py", request.getParameter("token_id")).start();
    String stderr = IOUtils.toString(pweb3.getErrorStream(), Charset.defaultCharset());
    String stdout = IOUtils.toString(pweb3.getInputStream(), Charset.defaultCharset());
    strRes = stdout + stderr;
  }
 %><%= strRes %>
