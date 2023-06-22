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
        <h2>User Profile</h2>

        <%
        UserProfile userProfile = new UserProfile();
        UserProfileDao userProfileDao = new UserProfileDao();
        userProfile = userProfileDao.getUserProfileByUsernameAndEmail(username, useremail);
        if (userProfile == null)userProfile = new UserProfile();
        if (request.getMethod().equalsIgnoreCase("post")) {
            UserProfile existingUserProfile = userProfileDao.getUserProfileByUsernameAndEmail(username, useremail);
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String settings = request.getParameter("settings");
            userProfile.setFirstName(firstName);
            userProfile.setLastName(lastName);
            userProfile.setEmail(email);
            userProfile.setPhone(phone);
            userProfile.setDateCreated(new java.util.Date());
            userProfile.setSettings(settings);
            if (existingUserProfile == null) {
              userProfileDao.createUserProfile(userProfile);
            } else {
              userProfileDao.createUserProfile(userProfile);
            }
        }
        %>
        <HR>
          <div class="container mt-5">
            <div class="container">
                <div class="row">
                  <form action="<%=rootUpdate%>user.profile.edit.sec.jsp/" method="post">
                  <input type="hidden" class="form-control" id="id" name="id" value="<%=userProfile.getId()%>" >
                  <div class="form-group">
                     <label for="firstName">First Name:</label>
                     <input type="text" class="form-control" id="firstName" name="firstName" value="<%=userProfile.getFirstName()%>" required>
                 </div>
                 <div class="form-group">
                     <label for="lastName">Last Name:</label>
                     <input type="text" class="form-control" id="lastName" name="lastName" value="<%=userProfile.getLastName()%>" required>
                 </div>
                 <div class="form-group">
                     <label for="email">Email:</label>
                     <input type="email" class="form-control" id="email" name="email" value="<%=userProfile.getEmail()%>">
                 </div>
                 <div class="form-group">
                     <label for="phone">Phone:</label>
                     <input type="tel" class="form-control" id="phone" name="phone" value="<%=userProfile.getPhone()%>">
                 </div>
                 <div class="form-group">
                     <label for="username">Username:</label>
                     <input type="text" class="form-control" id="username" name="username" value="<%=userProfile.getUsername()%>">
                 </div>
                 <div class="form-group">
                     <label for="useremail">User Email:</label>
                     <input type="email" class="form-control" id="useremail" name="useremail" value="<%=userProfile.getUseremail()%>">
                 </div>
                 <div class="form-group">
                     <label for="dateCreated">Date Created:</label>
                     <input type="date" class="form-control" id="dateCreated" name="dateCreated" value="<%=userProfile.getDateCreated()%>">
                 </div>
                 <div class="form-group">
                     <label for="settings">Settings:</label>
                     <textarea class="form-control" id="settings" name="settings" rows="3"><%=userProfile.getSettings()%></textarea>
                 </div>
                 <button type="submit" class="btn btn-primary">Add User Profile</button>

                  </form>
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
