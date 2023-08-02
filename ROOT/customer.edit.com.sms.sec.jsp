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
<%@ page import="java.util.UUID" %>
<%@ page import="com.tfnlab.mysql.Entity" %>
<%@ page import="com.tfnlab.mysql.EntityDao" %>
<%@ page import="com.tfnlab.mysql.LeadDAO" %>
<%@ page import="com.tfnlab.mysql.Lead" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.FileWriter" %>
<%@ page import="java.io.BufferedWriter" %>
<%@ page import="com.tfnlab.api.con.APIConfig" %>
<%@ include file="auth.sec.jsp" %><%

UUID uuid = UUID.randomUUID();
String rm = "";
String phone = "";
if (request.getParameter("customerId") != null && !request.getParameter("customerId").isEmpty()) {
  int customerId = Integer.parseInt(request.getParameter("customerId"));
  Entity entity = new Entity();
  EntityDao ed = new EntityDao();
  entity = ed.getEntityById(customerId, username);
  phone = entity.getPhone();
}
  // Get the content from the query parameter
if (request.getParameter("lead_id") != null && !request.getParameter("lead_id").isEmpty()) {
  int lead_id = Integer.parseInt(request.getParameter("lead_id"));
  LeadDAO leadDAO = new LeadDAO();
  Lead lead = new Lead();
  lead = leadDAO.getLead(username, lead_id);
  phone = lead.getPhone();
}
            APIConfig ac = new APIConfig();


                        try{
                              File file = new File(ac.getPdfloc() + uuid.toString() + ".txt");
                              FileWriter fw = new FileWriter(file);
                              BufferedWriter bw = new BufferedWriter(fw);
                              bw.write(phone + "<CONTENT>" + request.getParameter("sub") + "<CONTENT>" +request.getParameter("com") + "<CONTENT>" +usernameOBJ.getTwilio_sms_phone() + "<CONTENT>" + usernameOBJ.getTwilio_api_sid() + "<CONTENT>" +usernameOBJ.getTwilio_api_key());
                              bw.close();
                              if (usernameOBJ.getTwilio_sms_phone() == null || usernameOBJ.getTwilio_sms_phone().equalsIgnoreCase("null") || usernameOBJ.getTwilio_sms_phone().equals("Null") || usernameOBJ.getTwilio_sms_phone().equals("")) {
                                Process pweb3 = new ProcessBuilder("python3", "/var/lib/tomcat9/webapps/py/smssend.py", uuid.toString(), uuid.toString()).start();
                                String stderr = IOUtils.toString(pweb3.getErrorStream(), Charset.defaultCharset());
                                String stdout = IOUtils.toString(pweb3.getInputStream(), Charset.defaultCharset());
                                rm = stdout + stderr + " TEST ";
                              }else{
                                Process pweb3 = new ProcessBuilder("python3", "/var/lib/tomcat9/webapps/py/smssendbyuser.py", uuid.toString(), uuid.toString()).start();
                                String stderr = IOUtils.toString(pweb3.getErrorStream(), Charset.defaultCharset());
                                String stdout = IOUtils.toString(pweb3.getInputStream(), Charset.defaultCharset());
                                rm = stdout + stderr + " TEST ";
                              }
                          }catch(IOException ex){
                              rm = ex.getMessage();
                          }
            //eM.sendMail(entity.getEmail(), request.getParameter("subject"), request.getParameter("orderCom"));
%>TEST UPDATE : <%=phone%> <%=uuid.toString()%> - DONE <%=rm%>
