<%@ page language="java" import="java.lang.Thread,org.apache.commons.io.IOUtils,org.apache.commons.io.output.*,java.nio.charset.Charset,java.io.*,java.util.*,java.awt.image.BufferedImage,javax.imageio.ImageIO,java.io.OutputStream,java.io.FileInputStream,java.io.File"%>
<%@page import="com.itextpdf.kernel.pdf.PdfDocument"%>
<%@page import="com.itextpdf.kernel.pdf.PdfWriter"%>
<%@page import="com.itextpdf.layout.Document"%>
<%@page import="com.itextpdf.layout.element.Paragraph"%>
<%@page import="java.io.FileOutputStream"%>
<%@ page import="com.hrn.mysql.Order" %>
<%@ page import="com.hrn.mysql.OrderDao" %>
<%@ page import="com.tfnlab.mysql.User"%>
<%@ page import="com.tfnlab.mysql.UserDao" %>
<%@ page import="java.util.UUID" %>
<%@ page import="com.hrn.mysql.Entity" %>
<%@ page import="com.hrn.mysql.EntityDao" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.FileWriter" %>
<%@ page import="java.io.BufferedWriter" %>
<%@ page import="com.tfnlab.api.con.APIConfig" %>
<%@ page import="com.tfnlab.mysql.LeadDAO" %>
<%@ page import="com.tfnlab.mysql.Lead" %>
<%@ include file="auth.sec.jsp" %><%

UUID uuid = UUID.randomUUID();
String rm = "";
String email = "";
if (request.getParameter("customerId") != null && !request.getParameter("customerId").isEmpty()) {
  String  customerId = request.getParameter("customerId");
  Entity entity = new Entity();
  EntityDao ed = new EntityDao();
  entity = ed.getEntityById(customerId, username);
  email = entity.getEmail();
}
if (request.getParameter("lead_id") != null && !request.getParameter("lead_id").isEmpty()) {
  int lead_id = Integer.parseInt(request.getParameter("lead_id"));
  LeadDAO leadDAO = new LeadDAO();
  Lead lead = new Lead();
  lead = leadDAO.getLead(username, lead_id);
  email = lead.getEmailAddress();
}
  // Get the content from the query parameter
            APIConfig ac = new APIConfig();


                        try{
                              File file = new File(ac.getPdfloc() + uuid.toString() + ".txt");
                              FileWriter fw = new FileWriter(file);
                              BufferedWriter bw = new BufferedWriter(fw);
                              bw.write(email + "<CONTENT>" + request.getParameter("sub") + "<CONTENT>" +request.getParameter("com")+ "<CONTENT>" + usernameOBJ.getSendgrid_email());
                              bw.close();

                              Process pweb3 = new ProcessBuilder("python3", "/var/lib/tomcat9/webapps/py/sendmail.py", uuid.toString(), usernameOBJ.getSendgrid_key()).start();
                              String stderr = IOUtils.toString(pweb3.getErrorStream(), Charset.defaultCharset());
                              String stdout = IOUtils.toString(pweb3.getInputStream(), Charset.defaultCharset());
                              rm = stdout + stderr + " TEST ";
                          }catch(IOException ex){
                              rm = ex.getMessage();
                          }
            //eM.sendMail(entity.getEmail(), request.getParameter("subject"), request.getParameter("orderCom"));
%>INFO UPDATE : <%=uuid.toString()%> - DONE <%=rm%>
