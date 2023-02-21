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
<%@ page import="com.tfnlab.mysql.PaymentPostDao" %>
<%@ page import="com.tfnlab.api.con.APIConfig" %><%
OrderDao dao = new OrderDao();

UUID uuid = UUID.randomUUID();
int orderId = 0;
String username = (String) session.getAttribute("username");
User usernameOBJ = (User) session.getAttribute("usernameOBJ");
if (request.getParameter("orderId") != null && !request.getParameter("orderId").isEmpty()) {
  orderId = Integer.parseInt(request.getParameter("orderId"));
}
  // Get the content from the query parameter
  Order order = dao.getOrderByOrderId(orderId, username);
  CreateInvoice cpdf = new CreateInvoice();

  cpdf.createPD(uuid + ".pdf", order, request.getParameter("type"));
%>DONE

<%
  APIConfig conf = new APIConfig();
  String filename = uuid + ".pdf";
  String filepath = conf.getPdfloc();
  response.setContentType("APPLICATION/OCTET-STREAM");
  response.setHeader("Content-Disposition","attachment; filename=\"" + order.getOrderId() + ".pdf" + "\"");

  java.io.FileInputStream fileInputStream=new java.io.FileInputStream(filepath + filename);

  int i;
  while ((i=fileInputStream.read()) != -1) {
    out.write(i);
  }
  fileInputStream.close();
%>
