<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ page import="com.tfnlab.mysql.User, com.tfnlab.mysql.UserDao, com.tfnlab.mysql.OrderDao, com.tfnlab.mysql.EntityDao, com.tfnlab.mysql.EventDao, com.tfnlab.mysql.Technician, com.tfnlab.mysql.TechnicianDao, com.tfnlab.mysql.ProductDao, java.sql.Timestamp, java.util.Calendar, java.math.BigDecimal, java.util.Map, java.util.HashMap, java.util.List, com.tfnlab.mysql.Product, com.tfnlab.mysql.ProductLineItemDao, com.tfnlab.mysql.ProductDashBoard, java.util.UUID, com.tfnlab.api.con.APIConfig, java.util.Date, java.text.SimpleDateFormat, com.tfnlab.mysql.ContactDAO, com.tfnlab.mysql.Contact, com.tfnlab.util.Translate, com.tfnlab.mysql.Lead, com.tfnlab.mysql.LeadDAO, java.util.StringJoiner"%><%@ include file="auth.sec.jsp" %><%
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

                %><%=csvString%>
