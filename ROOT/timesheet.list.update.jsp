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
<%@ page import="com.tfnlab.mysql.EmployeeTimeSheet" %>
<%@ page import="com.tfnlab.mysql.EmployeeTimeSheetDAO" %>
<%@ page import="java.util.Date" %>
<%@ include file="auth.jsp" %>
<%
          User user = (User)session.getAttribute("usernameOBJ");
          String username = (String) session.getAttribute("username");
          int id = Integer.parseInt(request.getParameter("technicianId"));
          EmployeeTimeSheetDAO etsDao = new EmployeeTimeSheetDAO();
          EmployeeTimeSheet ets = etsDao.getLatestTimesheetEntryByTechnicianId(id);

          TechnicianDao tDao = new TechnicianDao();
          if(ets==null){
              tDao.updateRecordWorkingStatus(id, true);
                ets = new EmployeeTimeSheet();
                Date startDate = new Date();
                ets.setEmployeeID(id);
                ets.setDate(startDate);
                ets.setStartTime(startDate);
                ets.setEndTime(startDate);
                ets.setHoursWorked(0);
                ets.setUsername(username);
                etsDao.addEmployeeTimeSheet(ets);
                %>STARTED<%
          }else{
                if(ets.getStartTime().equals(ets.getEndTime())){
                    // set to true
                      Date endDate = new Date();
                      etsDao.updateEndTimeByTechnicianId(ets.getTimeSheetID(), endDate);
                      tDao.updateRecordWorkingStatus(id, false);
                      %>Stopped - STOPPED<%
                }else{
                    ets = new EmployeeTimeSheet();
                    Date startDate = new Date();
                    ets.setEmployeeID(id);
                    ets.setDate(startDate);
                    ets.setStartTime(startDate);
                    ets.setEndTime(startDate);
                    ets.setHoursWorked(0);
                    ets.setUsername(username);
                    etsDao.addEmployeeTimeSheet(ets);
                    tDao.updateRecordWorkingStatus(id, true);
                    %>STARTED<%
                }
          }

%>

CLOCK CHANGED
