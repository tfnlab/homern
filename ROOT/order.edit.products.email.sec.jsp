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
<%@ page import="com.tfnlab.business.CreateInvoice" %>
<%@ page import="java.util.UUID" %>
<%@ page import="com.tfnlab.mysql.OrderCustomer" %>
<%@ page import="com.tfnlab.mysql.OrderCustomerDao" %>
<%@ page import="com.tfnlab.mysql.PaymentPostDao" %>
<%@ page import="com.tfnlab.api.con.APIConfig" %>
<%@ include file="auth.sec.jsp" %><%
OrderDao dao = new OrderDao();

UUID uuid = UUID.randomUUID();
int orderId = 0;
if (request.getParameter("orderId") != null && !request.getParameter("orderId").isEmpty()) {
  orderId = Integer.parseInt(request.getParameter("orderId"));
}
  // Get the content from the query parameter
  Order order = dao.getOrderByOrderId(orderId, username);
  CreateInvoice cpdf = new CreateInvoice();

  cpdf.createPD(uuid + ".pdf", order, request.getParameter("type"));

                 OrderCustomerDao ocDao = new OrderCustomerDao();
                 List<OrderCustomer> ocList = ocDao.getCustomersByOrderId(orderId);
                 for (OrderCustomer ocItem : ocList) {

                        APIConfig conf = new APIConfig();
                        String filename = uuid + ".pdf";
                        String filepath = conf.getPdfloc();
                        UUID uuidEmail = UUID.randomUUID();
                        String rm = "";
                        APIConfig ac = new APIConfig();
                        try{
                              File file = new File(ac.getPdfloc() + uuidEmail.toString() + ".txt");
                              FileWriter fw = new FileWriter(file);
                              BufferedWriter bw = new BufferedWriter(fw);
                              bw.write(ocItem.getCustomer().getEmail() + "<CONTENT>" + request.getParameter("type") + "<CONTENT>" + request.getParameter("message") + "<CONTENT>" + usernameOBJ.getSendgrid_email() + "<CONTENT>" + filepath + filename + "<CONTENT>" + orderId);
                              bw.close();
                              Process pweb3 = new ProcessBuilder("python3", "/var/lib/tomcat9/webapps/py/sendmail.file.py", uuidEmail.toString(), usernameOBJ.getSendgrid_key()).start();
                              String stderr = IOUtils.toString(pweb3.getErrorStream(), Charset.defaultCharset());
                              String stdout = IOUtils.toString(pweb3.getInputStream(), Charset.defaultCharset());
                              rm = stdout + stderr + " TEST ";
                          }catch(IOException ex){
                              rm = ex.getMessage();
                          }
                            %>TEST UPDATE : <%=uuid.toString()%> - DONE <%=rm%><%
                 }
                 %>Process Done
