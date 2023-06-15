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
<%@ page import="com.tfnlab.mysql.LeadDAO" %>
<%@ page import="com.tfnlab.mysql.Lead" %>
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
        <h2>Lead</h2>
        <HR>
        <HR>
          <a href="<%=rootUpdate%>lead.list.sec.jsp/" tabindex="2"><i class="fas fa-list"></i> Leads</a>
          <%
              LeadDAO leadDAO = new LeadDAO();
              Lead lead = leadDAO.getLead(username, Integer.parseInt(request.getParameter("lead_id")));

              SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
          %>
        <HR>
          <div class="container mt-5">
            <div class="container">
              <form action="<%=rootUpdate%>lead.new.sec.jsp/" method="post">
                <div class="form-group">
                    <label>Name:</label>
                    <input type="text" class="form-control" name="name" value="<%=lead.getName()%>">
                </div>
                <div class="form-group">
                  <label>Phone:</label>
                  <input type="text" class="form-control" name="phone" value="<%= lead.getPhone() %>">
                </div>

                <div class="form-group">
                  <label>Address:</label>
                  <input type="text" class="form-control" name="address" value="<%= lead.getAddress() %>">
                </div>

                <div class="form-group">
                  <label>City:</label>
                  <input type="text" class="form-control" name="city" value="<%= lead.getCity() %>">
                </div>

                <div class="form-group">
                  <label>Email Address:</label>
                  <input type="text" class="form-control" name="emailAddress" value="<%= lead.getEmailAddress() %>">
                </div>

                <div class="form-group">
                  <label>Lead Status:</label>
                  <input type="text" class="form-control" name="leadStatus" value="<%= lead.getLeadStatus() %>">
                </div>

                <div class="form-group">
                  <label>Change:</label>
                  <input type="text" class="form-control" name="change" value="<%= lead.getChange() %>">
                </div>

                <div class="form-group">
                  <label>Interconnection Status:</label>
                  <input type="text" class="form-control" name="interconnectionStatus" value="<%= lead.getInterconnectionStatus() %>">
                </div>

                <div class="form-group">
                  <label>Sales Notes:</label>
                  <textarea class="form-control" name="salesNotes"><%= lead.getSalesNotes() %></textarea>
                </div>

                <div class="form-group">
                  <label>Link Email Address:</label>
                  <input type="text" class="form-control" name="linkEmailAddress" value="<%= lead.getLinkEmailAddress() %>">
                </div>

                <div class="form-group">
                  <label>User Responsible:</label>
                  <input type="text" class="form-control" name="userResponsible" value="<%= lead.getUserResponsible() %>">
                </div>

                <div class="form-group">
                  <label>Lead Rating:</label>
                  <input type="text" class="form-control" name="leadRating" value="<%= lead.getLeadRating() %>">
                </div>

                <div class="form-group">
                  <label>Organization:</label>
                  <input type="text" class="form-control" name="organization" value="<%= lead.getOrganization() %>">
                </div>

                <div class="form-group">
                  <label>Lead Source:</label>
                  <input type="text" class="form-control" name="leadSource" value="<%= lead.getLeadSource() %>">
                </div>

                <div class="form-group">
                  <label>Accounting Notes:</label>
                  <textarea class="form-control" name="accountingNotes"><%= lead.getAccountingNotes() %></textarea>
                </div>

                <div class="form-group">
                  <label>Contract Amount:</label>
                  <input type="number" step="0.01" class="form-control" name="contractAmount" value="<%= lead.getContractAmount() %>">
                </div>

                <div class="form-group">
                  <label>Financing Type:</label>
                  <input type="text" class="form-control" name="financingType" value="<%= lead.getFinancingType() %>">
                </div>

                <div class="form-group">
                  <label>CASH Price:</label>
                  <input type="number" step="0.01" class="form-control" name="cashPrice" value="<%= lead.getCashPrice() %>">
                </div>

                <div class="form-group">
                  <label>Project Notes:</label>
                  <textarea class="form-control" name="projectNotes"><%= lead.getProjectNotes() %></textarea>
                </div>

                <div class="form-group">
                  <label>DC KW:</label>
                  <input type="number" step="0.01" class="form-control" name="dcKw" value="<%= lead.getDcKw() %>">
                </div>

                <div class="form-group">
                  <label>Solar Modules:</label>
                  <input type="text" class="form-control" name="solarModules" value="<%= lead.getSolarModules() %>">
                </div>

                <div class="form-group">
                  <label>Solar Panel Quantity:</label>
                  <input type="number" class="form-control" name="solarPanelQuantity" value="<%= lead.getSolarPanelQuantity() %>">
                </div>

                <div class="form-group">
                  <label>Inverter's:</label>
                  <input type="text" class="form-control" name="inverters" value="<%= lead.getInverters() %>">
                </div>

                <div class="form-group">
                  <label>Inverter Quantity:</label>
                  <input type="number" class="form-control" name="inverterQuantity" value="<%= lead.getInverterQuantity() %>">
                </div>

                <div class="form-group">
                  <label>Other Adders:</label>
                  <input type="text" class="form-control" name="otherAdders" value="<%= lead.getOtherAdders() %>">
                </div>

                <div class="form-group">
                  <label for="ev">EV:</label>
                  <input type="text" class="form-control" id="ev" name="ev">
                </div>

                <div class="form-group">
                  <label for="mainPanelUpgrade">Main Panel Upgrade:</label>
                  <input type="text" class="form-control" id="mainPanelUpgrade" name="mainPanelUpgrade">
                </div>

                <div class="form-group">
                  <label for="battery">Battery:</label>
                  <input type="text" class="form-control" id="battery" name="battery">
                </div>

                <div class="form-group">
                  <label for="meterspotRequested">Meterspot Requested:</label>
                  <input type="text" class="form-control" id="meterspotRequested" name="meterspotRequested">
                </div>

                <div class="form-group">
                  <label for="utilityCo">Utility Co:</label>
                  <input type="text" class="form-control" id="utilityCo" name="utilityCo">
                </div>
                <div class="form-group">
                  <label>EV:</label>
                  <input type="text" class="form-control" name="ev" value="<%= lead.getEv() %>">
                </div>

                <div class="form-group">
                  <label>Main Panel Upgrade:</label>
                  <input type="text" class="form-control" name="mainPanelUpgrade" value="<%= lead.getMainPanelUpgrade() %>">
                </div>

                <div class="form-group">
                  <label>Battery:</label>
                  <input type="text" class="form-control" name="battery" value="<%= lead.getBattery() %>">
                </div>

                <div class="form-group">
                  <label>Meterspot Requested:</label>
                  <input type="text" class="form-control" name="meterspotRequested" value="<%= lead.getMeterspotRequested() %>">
                </div>

                <div class="form-group">
                  <label>Utility Co:</label>
                  <input type="text" class="form-control" name="utilityCo" value="<%= lead.getUtilityCo() %>">
                </div>

                <div class="form-group">
                  <label>Roof Information:</label>
                  <input type="text" class="form-control" name="roofInformation" value="<%= lead.getRoofInformation() %>">
                </div>

                <div class="form-group">
                  <label>Company Cam Link:</label>
                  <input type="text" class="form-control" name="companyCamLink" value="<%= lead.getCompanyCamLink() %>">
                </div>




                    <input type="submit" value="Create">
                </form>

            </div>
          </div>
        </div>
      </div>
    </section><!-- End Blog Section -->
  </main>
</body>
</html>
