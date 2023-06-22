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
<%@ page import="com.tfnlab.mysql.UserProfile,com.tfnlab.mysql.UserProfileDao" %>
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
          <a href="<%=rootUpdate%>lead.new.sec.jsp/" class="btn btn-primary" tabindex="2"><i class="fas fa-plus"></i></a>
          <a href="<%=rootUpdate%>lead.list.sec.jsp/" class="btn btn-primary" tabindex="2"><i class="fas fa-list"></i></a>
          <a href="<%=rootUpdate%>lead.list.table.sec.jsp/" class="btn btn-primary" tabindex="2"><i class="fas fa-table"></i></a>
          <a href="<%=rootUpdate%>lead.list.dash.sec.jsp/" class="btn btn-primary" tabindex="2"><i class="fas fa-tachometer-alt"></i></a>

        <HR>
          <div class="container mt-5">
            <div class="container">
                <h3>Lead List CSV <a href="<%=rootUpdate%>lead.list.csv.sec.jsp/?csv=true" tabindex="2"><i class="fas fa-download"></i></a> <a href="<%=rootUpdate%>lead.new.bulk.sec.jsp/?csv=true" tabindex="2"><i class="fas fa-upload"></i></a>  </h3>


                <%
                UserProfile userProfile = new UserProfile();
                UserProfileDao userProfileDao = new UserProfileDao();
                userProfile = userProfileDao.getUserProfileByUsernameAndEmail(username, useremail);

                if (userProfile == null) {
                  userProfile = new UserProfile();
                  userProfile.setSettings("display=panel;");
                  userProfile.setUsername(username);
                  userProfile.setUseremail(useremail);
                  userProfile.setDateCreated(new java.util.Date());
                  userProfileDao.createUserProfile(userProfile);
                }else{
                  if(!userProfile.getSettings().contains("display=panel;")){
                    userProfile.getSettings().replace("display=table;", "display=panel;");
                    userProfileDao.updateUserProfile(userProfile);
                  }

                }
                List<Lead> leads = null;
                try {
                    LeadDAO leadDAO = new LeadDAO();
                    if(request.getParameter("lead_source")!=null) leads = leadDAO.getLeadsByUsernameandLeadSource(username, request.getParameter("lead_source"));
                    else if(request.getParameter("lead_status")!=null) leads = leadDAO.getLeadsByUsernameandLeadStatus(username, request.getParameter("lead_status"));
                    else leads = leadDAO.getLeadsByUsername(username);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                %>

                <div class="row">
                    <% for (Lead lead : leads) { %>
                    <div class="col-md-4">
                        <div class="card mb-3">
                            <div class="card-body">
                                <h5 class="card-title">
                                    <a href="<%=rootUpdate%>lead.edit.sec.jsp/?lead_id=<%= lead.getRecordId() %>" tabindex="2">
                                        <%= lead.getRecordId() %>
                                    </a>
                                </h5>
                                <p class="card-text"><%= lead.getName() %> <%= lead.getLname() %></p>
                                <p class="card-text"><%= lead.getAddress() %></p>
                                <p class="card-text"><%= lead.getPhone() %></p>
                                <p class="card-text"><%= lead.getEmailAddress() %></p>
                                <p class="card-text"><%= lead.getLeadStatus() %></p>
                                <p class="card-text"><%= lead.getExternal_id() %></p>
                                <!-- Add more card content for other lead properties -->
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
