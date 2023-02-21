<%@ page language="java" import="java.lang.Thread,org.apache.commons.io.IOUtils,org.apache.commons.io.output.*,java.nio.charset.Charset,java.io.*,java.util.*,java.awt.image.BufferedImage,javax.imageio.ImageIO,java.io.OutputStream,java.io.FileInputStream,java.io.File"%>
<%@ page import="com.tfnlab.mysql.User"%>
<%@ page import="com.tfnlab.mysql.UserDao" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.tfnlab.mysql.Order" %>
<%@ page import="com.tfnlab.mysql.OrderDao" %>
<%@ page import="com.tfnlab.mysql.Entity" %>
<%@ page import="com.tfnlab.mysql.EntityDao" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="java.util.UUID" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="javax.servlet.http.Part" %>
<%@ page import="java.util.List" %>
<%@ page import="org.apache.commons.fileupload.FileItem" %>
<%@ page import="com.tfnlab.api.con.APIConfig" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.http.*" %><%
  String messageSid = request.getParameter("MessageSid");
  UUID uuid = UUID.randomUUID();
  String ocrDescription = "GOT REQUEST" ;
  try{
       Process pweb3 = new ProcessBuilder("python3", "/var/lib/tomcat9/webapps/py/smsgetmessage.py", messageSid, messageSid).start();
       String stderr = IOUtils.toString(pweb3.getErrorStream(), Charset.defaultCharset());
       String stdout = IOUtils.toString(pweb3.getInputStream(), Charset.defaultCharset());
       ocrDescription = stdout + stderr + " TEST " + request.getParameter("MessageSid");
       APIConfig ac = new APIConfig();
       File file = new File(ac.getPdfloc() + "sms." + uuid.toString() + ".txt");
       FileWriter fw = new FileWriter(file);
       BufferedWriter bw = new BufferedWriter(fw);
       bw.write(ocrDescription);
       bw.close();
   }catch(IOException ex){
       ocrDescription = ex.getMessage();
   }

%>
