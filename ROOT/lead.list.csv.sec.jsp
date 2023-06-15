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
<%@ page import="com.tfnlab.mysql.ContactDAO" %>
<%@ page import="com.tfnlab.mysql.Contact" %>
<%@ page import="com.tfnlab.util.Translate" %>
<%@ page import="com.tfnlab.mysql.Lead" %>
<%@ page import="com.tfnlab.mysql.LeadDAO" %>
<%@ page import="java.util.StringJoiner" %>
<%@ include file="auth.sec.jsp" %><%
                List<Lead> leads = null;
                try {
                    LeadDAO leadDAO = new LeadDAO();
                    leads = leadDAO.getLeadsByUsername(username);
                } catch (Exception e) {
                    e.printStackTrace();
                }

              StringJoiner csv = new StringJoiner("\n");
              csv.add("Lead ID,Name,Phone,Email,Status");
              for (Lead lead : leads) {
                  csv.add(String.format("%s,%s,%s,%s,%s",
                          lead.getRecordId(),
                          lead.getName(),
                          lead.getPhone(),
                          lead.getEmailAddress(),
                          lead.getLeadStatus()
                  ));
              }

              String csvString = csv.toString();
              System.out.println(csvString);

                %>
