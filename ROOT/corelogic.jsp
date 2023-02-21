<%@ page language="java" import="java.lang.Thread,org.apache.commons.io.IOUtils,org.apache.commons.io.output.*,java.nio.charset.Charset,java.io.*,java.util.*,java.awt.image.BufferedImage,javax.imageio.ImageIO,java.io.OutputStream,java.io.FileInputStream,java.io.File"%>
<%@page import="com.itextpdf.kernel.pdf.PdfDocument"%>
<%@page import="com.itextpdf.kernel.pdf.PdfWriter"%>
<%@page import="com.itextpdf.layout.Document"%>
<%@page import="com.itextpdf.layout.element.Paragraph"%>
<%@page import="java.io.FileOutputStream"%>
<%@ page import="com.tfnlab.mysql.Order" %>
<%@ page import="com.tfnlab.mysql.OrderDao" %>
<%@ page import="com.tfnlab.mysql.User"%>
<%@ page import="com.tfnlab.mysql.UserDao" %>
<%@ page import="com.tfnlab.business.Email_Manager" %>
<%@ page import="java.util.UUID" %>
<%@ page import="com.tfnlab.mysql.Entity" %>
<%@ page import="com.tfnlab.mysql.EntityDao" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.FileWriter" %>
<%@ page import="java.io.BufferedWriter" %>
<%@ page import="com.tfnlab.api.con.APIConfig" %><%
UUID uuid = UUID.randomUUID();
String username = (String) session.getAttribute("username");
User usernameOBJ = (User) session.getAttribute("usernameOBJ");
String rm = "";
  // Get the content from the query parameter
            APIConfig ac = new APIConfig();


                        try{
                              File file = new File(ac.getPdfloc() + uuid.toString() + ".txt");
                              FileWriter fw = new FileWriter(file);
                              BufferedWriter bw = new BufferedWriter(fw);
                              bw.write(request.getParameter("search") + "<CONTENT>" + request.getParameter("zip") + "<CONTENT>" + username);
                              bw.close();

                              Process pweb3 = new ProcessBuilder("python3", "/var/lib/tomcat9/webapps/py/corelogic.py", uuid.toString(), uuid.toString()).start();
                              String stderr = IOUtils.toString(pweb3.getErrorStream(), Charset.defaultCharset());
                              String stdout = IOUtils.toString(pweb3.getInputStream(), Charset.defaultCharset());
                              rm = stdout + stderr + " TEST ";
                          }catch(IOException ex){
                              rm = ex.getMessage();
                          }
            //eM.sendMail(entity.getEmail(), request.getParameter("subject"), request.getParameter("orderCom"));
%>TEST UPDATE : <%=uuid.toString()%> - DONE <%=rm%>
