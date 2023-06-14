<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.tfnlab.mysql.User"%>
<%@ page import="com.tfnlab.mysql.UserDao" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.tfnlab.mysql.Entity" %>
<%@ page import="com.tfnlab.mysql.EntityDao" %>
<%@ include file="auth.sec.jsp" %>
<%
           
    int orderId = 0;
    if (request.getParameter("orderId") != null && !request.getParameter("orderId").isEmpty()) {
      orderId = Integer.parseInt(request.getParameter("orderId"));
    }

          EntityDao cDao = new EntityDao();
          List<Entity> es = null;

          String searchKey = request.getParameter("searchKey");
          if (searchKey != null && searchKey.trim().length() > 0) {
              es = cDao.searchSearchKeyByUsername(username, searchKey);
          }else{
              es = cDao.getEntitiesByUsername(username);
          }
        if(es.isEmpty()){
          %><a href="<%=rootUpdate%>customer.new.sec.jsp/?orderId=<%=orderId%>" >add customer</a><%
        }
        for (Entity entity : es) { %>
            Name: <%= entity.getFirstName() %>, <%= entity.getLastName() %><br>
            Phone: <%= entity.getPhone() %><br>
            Email: <%= entity.getEmail() %><br>
            Address: <%= entity.getAddress() %>, <%= entity.getCity() %><br>
          Customer ID: <a href="<%=rootUpdate%>order.edit.customers.sec.jsp/?action=add&orderId=<%=orderId%>&customerId=<%= entity.getId() %>" ><%= entity.getId() %></a><br>
          <hr>
        <% } %>
