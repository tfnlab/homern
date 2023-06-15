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
          <a href="<%=rootUpdate%>lead.new.sec.jsp/" tabindex="2"><i class="fas fa-plus"></i> Lead</a>
        <HR>
          <div class="container mt-5">
            <div class="container">
                <h3>Lead List  <a href="<%=rootUpdate%>contact.list.csv.sec.jsp/?csv=true" tabindex="2"><i class="fas fa-download"></i> CSV</a></h3>

                <%
                List<Lead> leads = null;
                try {
                    LeadDAO leadDAO = new LeadDAO();
                    leads = leadDAO.getLeadsByUsername(username);
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                %>
                To create a JSP that calls the getLeadsByUsername method and displays the results, follow these steps:

                    Create a new JSP file (e.g., leadsByUsername.jsp) in your web project.

                    In the JSP file, import the necessary classes at the top:

                jsp

                <%@ page import="com.tfnlab.mysql.Lead" %>
                <%@ page import="java.util.List" %>
                <%@ page import="java.sql.SQLException" %>
                <%@ page import="your.package.name.LeadDAO" %> <!-- Replace "your.package.name" with the actual package name of LeadDAO -->



                <%
                List<Lead> leads = null;
                try {
                    LeadDAO leadDAO = new LeadDAO();
                    leads = leadDAO.getLeadsByUsername(username);
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                %>

                <table>
                    <thead>
                        <tr>
                            <th>Lead ID</th>
                            <th>Name</th>
                            <!-- Add more table headers for other lead properties -->
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Lead lead : leads) { %>
                        <tr>
                            <td><%= lead.getId() %></td>
                            <td><%= lead.getName() %></td>
                            <!-- Add more table cells for other lead properties -->
                        </tr>
                        <% } %>
                    </tbody>
                </table>

            </div>
          </div>
        </div>
      </div>
    </section><!-- End Blog Section -->
  </main>
</body>
</html>
