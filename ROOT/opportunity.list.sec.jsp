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
<%@ page import="com.tfnlab.mysql.Opportunity" %>
<%@ page import="com.tfnlab.mysql.OpportunityDAO" %>
<%@ include file="auth.sec.jsp" %>
<!DOCTYPE html>
<html lang="en">

  <head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <title>Home Renovation Nation - Sign-up</title>
    <meta content="" name="description">
    <meta content="" name="keywords">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" crossorigin="anonymous" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" crossorigin="anonymous" />
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>
  </head>
<body>
  <main id="main">
    <section id="blog" class="blog">
      <div class="container px-4 px-lg-5">
          <div class="container mt-5">
            <h2><a href="<%=rootUpdate%>user.menu.sec.jsp/" tabindex="1" >Home Renovation Nation</a></h2>
            <HR>
        <h2>Opportunities</h2>
        <HR>
        <HR>
          <a href="<%=rootUpdate%>opportunity.new.sec.jsp/" tabindex="2"><i class="fas fa-plus"></i> Opportunity</a> |
            <a href="<%=rootUpdate%>opportunity.list.dash.sec.jsp/" tabindex="2"><i class="fas fa-tachometer-alt"></i> Dashboard</a>

        <HR>
          <div class="container mt-5">
            <div class="container">
                <h3>Opportunities List CSV <a href="<%=rootUpdate%>opportunity.list.csv.sec.jsp/?csv=true" tabindex="2"><i class="fas fa-download"></i></a> <a href="<%=rootUpdate%>opportunity.new.bulk.sec.jsp/?csv=true" tabindex="2"><i class="fas fa-upload"></i></a>  </h3>

                <%

                OpportunityDAO opportunityDAO = new OpportunityDAO();
                List<Opportunity> opportunities = null;

                try {
                    opportunities = opportunityDAO.getOpportunitiesByUsername(username);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                %>
                <div class="row">
                    <% for (Opportunity opportunity : opportunities) { %>
                    <div class="col-md-4">
                        <div class="card mb-3">
                            <div class="card-body">
                                <h5 class="card-title">
                                    <a href="<%=rootUpdate%>opportunity.edit.sec.jsp/?opportunity_id=<%= opportunity.getRecordId() %>" tabindex="2">
                                        <%= opportunity.getRecordId() %>
                                    </a>
                                </h5>
                                <p class="card-text"><%= opportunity.getName() %></p>
                                <p class="card-text"><%= opportunity.getEmail() %></p>
                                <p class="card-text"><%= opportunity.getPhoneNumber() %></p>
                                <!-- Add more card content for other opportunity properties -->
                            </div>
                        </div>
                    </div>
                    <% } %>
                </div>

                <HR>
            </div>
          </div>
        </div>
      </div>
    </section><!-- End Blog Section -->
  </main>
</body>
</html>
