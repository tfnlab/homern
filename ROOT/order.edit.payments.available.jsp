<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.tfnlab.mysql.User"%>
<%@ page import="com.tfnlab.mysql.UserDao" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.tfnlab.mysql.Order" %>
<%@ page import="com.tfnlab.mysql.OrderDao" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.tfnlab.mysql.Technician" %>
<%@ page import="com.tfnlab.mysql.TechnicianDao" %>
<%@ page import="com.tfnlab.mysql.OrderTechnicians" %>
<%@ page import="com.tfnlab.mysql.OrderTechniciansDAO" %>
<%@ page import="com.tfnlab.mysql.Product" %>
<%@ page import="com.tfnlab.mysql.ProductDao" %>
<%@ page import="com.tfnlab.mysql.Event" %>
<%@ page import="com.tfnlab.mysql.EventDao" %>
<%@ page import="java.util.UUID" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.tfnlab.mysql.ProductLineItem" %>
<%@ page import="com.tfnlab.mysql.ProductLineItemDao" %>
<%@ page import="com.tfnlab.mysql.OrderCustomer" %>
<%@ page import="com.tfnlab.mysql.OrderCustomerDao" %>
<%@ page import="com.tfnlab.mysql.Payment" %>
<%@ page import="com.tfnlab.mysql.PaymentDao" %>
  <%
    OrderDao dao = new OrderDao();
    OrderTechniciansDAO otD = new OrderTechniciansDAO();
    EventDao evd = new EventDao();
    TechnicianDao technicianDao = new TechnicianDao();
    int orderId = 0;
    String username = (String) session.getAttribute("username");
    User usernameOBJ = (User) session.getAttribute("usernameOBJ");
    int ocId = 0;
    if (request.getParameter("orderId") != null && !request.getParameter("orderId").isEmpty()) {
      orderId = Integer.parseInt(request.getParameter("orderId"));
    }
    if (request.getParameter("ocId") != null && !request.getParameter("ocId").isEmpty()) {
      ocId = Integer.parseInt(request.getParameter("ocId"));
    }
    OrderCustomerDao ocDao  = new OrderCustomerDao();
    OrderCustomer oc = ocDao.getCustomersById(ocId);



        PaymentDao pDao = new PaymentDao();
        List<Payment> pList = pDao.getPaymentsWithAvailablePostBalance(oc.getCustomerId(), username);
        BigDecimal pTotal  = new BigDecimal("0");
        %>
        <div class="form-group">
         <label for="pId">Available Payments:</label>
          <select class="form-group" id="pId" name="pId" >
                  <%if(!(pList.size()>0)){%>
                    <option value="ap" >Add Payment</option>
                  <%}%>
        <%
        for (Payment pItem : pList) {
               pTotal = pTotal.add(pItem.getPaymentAmount());
       %>
                 <option value="<%= pItem.getPaymentId() %>" ><%=pItem.getPaymentAmount().subtract(pItem.getPostTotal())%> </option>
    <%
        }
  %>
</select>
<HR>
        <%if(!(pList.size()>0)){%>
            <a href="customer.edit.payments.jsp?customerId=<%=oc.getCustomerId()%>&orderId=<%=orderId%>" >Add Payment</a>
        <%}%>
</div>
