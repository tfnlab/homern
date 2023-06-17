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
        <h2>Leads</h2>
        <HR>
        <HR>
          <a href="<%=rootUpdate%>lead.new.sec.jsp/" tabindex="2"><i class="fas fa-plus"></i> Lead</a> |
            <a href="<%=rootUpdate%>lead.list.sec.jsp/" tabindex="2"><i class="fas fa-list"></i> Leads</a>
        <HR>
          <div class="container mt-5">
            <div class="container">
                <h3>Lead List CSV <a href="<%=rootUpdate%>lead.list.csv.sec.jsp/?csv=true" tabindex="2"><i class="fas fa-download"></i></a> <a href="<%=rootUpdate%>lead.new.bulk.sec.jsp/?csv=true" tabindex="2"><i class="fas fa-upload"></i></a>  </h3>


                <%
                List<Lead> leads = null;
                try {
                    LeadDAO leadDAO = new LeadDAO();
                    Map<String, Integer> leadsByStatus = leadDAO.getLeadsByStatus(username);

                    %>
                    <h4>Lead Status</h4>
                    <%

                    String[] optionValues = {"Lead Generation", "Initial Contact", "Site Assessment", "Roof Check", "Electrical Panel Check", "Shade Analysis", "Proposal Preparation", "Proposal Presentation", "Financial Analysis", "Incentives and Rebates", "Negotiation and Agreement", "Permitting and Documentation", "Equipment Procurement", "Installation Scheduling", "Installation and Commissioning", "Inspections and Approvals", "System Activation and Monitoring", "Customer Satisfaction and Referrals", "Ongoing Customer Relationship", "Site Plan Approval", "Unwilling to Engage", "LOST", "Not Viable", "Finalize Contract/Financing Docs", "Site Plan Creation/Meter Spot", "Converted", "NotContacted", "Contacted", "AttemptedContact", "Roof Check", "Site Evaluation", "Ready to Convert", "Appointment Set", "Lead Generation", "Incentives and Rebates", "Quoted", "Disqualified", "WON"};
                    for (String option : optionValues) {
                        %><a href="<%=rootUpdate%>lead.list.sec.jsp/?lead_status=<%= option %>" tabindex="2"><%= option %></a> <% if (leadsByStatus.containsKey(option)) { %> <%=leadsByStatus.get(option)%> <%}%> <BR><%
                     }
                     %>
                     <BR>
                     <HR>
                     <h4>Lead Source</h4>
                     <%
                     Map<String, Integer> leadsBySource = leadDAO.getLeadsBySource(username);

                     // Iterate over the map and print lead status with lead count
                     for (Map.Entry<String, Integer> entry : leadsBySource.entrySet()) {
                         String leadSource = entry.getKey();
                         int leadCount = entry.getValue();
                         %><a href="<%=rootUpdate%>lead.list.sec.jsp/?lead_source=<%= leadSource %>" tabindex="2"> <%=leadSource%> </a> <%=leadCount%> <BR><%
                     }
                } catch (Exception e) {
                    e.printStackTrace();
                }
                %>

                <HR>
            </div>
          </div>
        </div>
      </div>
    </section><!-- End Blog Section -->
  </main>
</body>
</html>
