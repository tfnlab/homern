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
<%@ page import="com.tfnlab.util.Translate" %>
<%@ page import="com.tfnlab.mysql.Subscription" %>
<%@ page import="com.tfnlab.mysql.SubscriptionDAO" %>
<%@ include file="auth.jsp" %>
<%
User usernameOBJ = (User)session.getAttribute("usernameOBJ");
String username = (String) session.getAttribute("username");
%>
<%
  boolean isCSV = false;
  if (request.getParameter("csv") != null && request.getParameter("csv").equalsIgnoreCase("true")) {
    isCSV = true;
  }

  if (isCSV) {
    response.setContentType("text/csv");
    response.setHeader("Content-Disposition", "attachment; filename=\"subscriptions.csv\"");

    // Create a StringBuilder to store the CSV content
    StringBuilder csvContent = new StringBuilder();
    csvContent.append("Subscription ID,Email,Subscribed At,Source\n");

    SubscriptionDAO dao = new SubscriptionDAO();
    List<Subscription> subscriptions = dao.getSubscriptionsByUsername(username);

    // Append each subscription's data to the CSV content
    for (Subscription subscription : subscriptions) {
      csvContent.append(subscription.getId()).append(",");
      csvContent.append(subscription.getEmail()).append(",");
      csvContent.append(subscription.getSubscribedAt()).append(",");
      csvContent.append(subscription.getSource()).append("\n");
    }

    // Write the CSV content to the response output stream
    response.getWriter().write(csvContent.toString());
  }
%>test
