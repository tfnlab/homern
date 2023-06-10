<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.tfnlab.mysql.User"%>
<%@ page import="com.tfnlab.mysql.UserDao" %>
<%@ page import="com.tfnlab.mysql.OrderDao" %>
<%@ page import="com.tfnlab.mysql.EntityDao" %>
<%@ page import="com.tfnlab.mysql.EventDao" %>
<%@ page import="com.tfnlab.mysql.Technician" %>
<%@ page import="com.tfnlab.mysql.TechnicianDao" %>
<%@ page import="com.tfnlab.mysql.ProductDao" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.math.BigDecimal" %>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@ page import="java.util.List" %>
<%@ page import="com.tfnlab.mysql.Product" %>
<%@ page import="com.tfnlab.mysql.ProductLineItemDao" %>
<%@ page import="com.tfnlab.mysql.ProductDashBoard" %>
<%@ page import="java.util.UUID" %>
<%@ page import="com.tfnlab.api.con.APIConfig" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.tfnlab.mysql.Quote" %>
<%@ page import="com.tfnlab.mysql.QuoteDAO" %>
<%@ page import="com.tfnlab.util.Translate" %>
<%@ include file="auth.jsp" %>
<%
          User usernameOBJ = (User)session.getAttribute("usernameOBJ");
          String username = (String) session.getAttribute("username");

boolean isCSV = false;
if (request.getParameter("csv") != null && request.getParameter("csv").equalsIgnoreCase("true")) {
  isCSV = true;
}

if (isCSV) {
  response.setContentType("text/csv");
  response.setHeader("Content-Disposition", "attachment; filename=\"subscriptions.csv\"");

  // Create a StringBuilder to store the CSV content

  QuoteDAO dao = new QuoteDAO();
  List<Quote> quotes = dao.selectQuotesByUsername(username);

  // Append each subscription's data to the CSV content
  StringBuilder sb = new StringBuilder();
  sb.append("Customer Name,Email,Phone Number,Request Date,Product Name,Quantity,Additional Notes,Installation Address,Roof Type,Average Monthly Energy Usage,Additional Message\n");

  for (Quote quote : quotes) {
      sb.append(quote.getCustomerName() + ",");
      sb.append(quote.getEmail() + ",");
      sb.append(quote.getPhoneNumber() + ",");
      sb.append(quote.getRequestDate() + ",");
      sb.append(quote.getProductName() + ",");
      sb.append(quote.getQuantity() + ",");
      sb.append(quote.getAdditionalNotes() + ",");
      sb.append(quote.getInstallationAddress() + ",");
      sb.append(quote.getRoofType() + ",");
      sb.append(quote.getAvgMonthlyEnergyUsage() + ",");
      sb.append(quote.getAdditionalMessage() + "\n");
  }

  // Write the CSV content to the response output stream
  response.getWriter().write(sb.toString());
}
%>
