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
<%@ include file="auth.sec.jsp" %>
<%
  boolean isCSV = false;
  if (request.getParameter("csv") != null && request.getParameter("csv").equalsIgnoreCase("true")) {
    isCSV = true;
  }

  if (isCSV) {
    response.setContentType("text/csv");
    response.setHeader("Content-Disposition", "attachment; filename=\"contact.csv\"");

    // Create a StringBuilder to store the CSV content
    StringBuilder csvContent = new StringBuilder();
    csvContent.append("Contact ID,Name,Email,Subject,Message,Created At\n");

    ContactDAO dao = new ContactDAO();
    List<Contact> contacts = contactDAO.getContactsByUsername(username);

    // Append each subscription's data to the CSV content
    for (Contact contact : contacts) {
      csvContent.append(contact.getId()).append(",");
      csvContent.append(contact.getName()).append(",");
      csvContent.append(contact.getEmail()).append(",");
      csvContent.append(contact.getSubject()).append(",");
      csvContent.append(contact.getMessage()).append(",");
      csvContent.append(contact.getCreatedAt()).append("\n");
    }

    // Write the CSV content to the response output stream
    response.getWriter().write(csvContent.toString());
  }
%>
