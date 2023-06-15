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
          if (request.getMethod().equalsIgnoreCase("post")) {
              // Create an instance of the LeadDAO class
              LeadDAO leadDAO = new LeadDAO();
              SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

              String name = request.getParameter("name");
              String phone = request.getParameter("phone");
              String address = request.getParameter("address");
              String city = request.getParameter("city");
              String emailAddress = request.getParameter("emailAddress");
              String leadStatus = request.getParameter("leadStatus");
              String change = request.getParameter("change");
              String interconnectionStatus = request.getParameter("interconnectionStatus");
              String salesNotes = request.getParameter("salesNotes");
              String linkEmailAddress = request.getParameter("linkEmailAddress");
              String userResponsible = request.getParameter("userResponsible");
              String leadRating = request.getParameter("leadRating");
              String organization = request.getParameter("organization");
              String leadSource = request.getParameter("leadSource");
              String accountingNotes = request.getParameter("accountingNotes");
              double contractAmount = Double.parseDouble(request.getParameter("contractAmount"));
              String financingType = request.getParameter("financingType");
              double cashPrice = Double.parseDouble(request.getParameter("cashPrice"));
              String projectNotes = request.getParameter("projectNotes");
              double dcKw = Double.parseDouble(request.getParameter("dcKw"));
              String solarModules = request.getParameter("solarModules");
              int solarPanelQuantity = Integer.parseInt(request.getParameter("solarPanelQuantity"));
              String inverters = request.getParameter("inverters");
              int inverterQuantity = Integer.parseInt(request.getParameter("inverterQuantity"));
              String otherAdders = request.getParameter("otherAdders");
              String ev = request.getParameter("ev");
              String mainPanelUpgrade = request.getParameter("mainPanelUpgrade");
              String battery = request.getParameter("battery");
              String meterspotRequested = request.getParameter("meterspotRequested");
              String utilityCo = request.getParameter("utilityCo");
              String roofInformation = request.getParameter("roofInformation");
              String companyCamLink = request.getParameter("companyCamLink");
              String actualClosedDate = request.getParameter("actualClosedDate");
              String layoutDrafted = request.getParameter("layoutDrafted");
              String leadCreated = request.getParameter("leadCreated");
              String dateOfLastActivity = request.getParameter("dateOfLastActivity");
              String dateOfNextActivity = request.getParameter("dateOfNextActivity");
              String convertedContact = request.getParameter("convertedContact");
              String convertedOrganization = request.getParameter("convertedOrganization");
              String convertedOpportunity = request.getParameter("convertedOpportunity");

              // Create an instance of the Lead class and populate it with the form data
              Lead lead = new Lead();
              lead.setName(name);
              lead.setPhone(phone);
              lead.setAddress(address);
              lead.setCity(city);
              lead.setEmailAddress(emailAddress);
              lead.setLeadStatus(leadStatus);
              lead.setChange(change);
              lead.setInterconnectionStatus(interconnectionStatus);
              lead.setSalesNotes(salesNotes);
              lead.setLinkEmailAddress(linkEmailAddress);
              lead.setUserResponsible(userResponsible);
              lead.setLeadRating(leadRating);
              lead.setOrganization(organization);
              lead.setLeadSource(leadSource);
              lead.setAccountingNotes(accountingNotes);
              lead.setContractAmount(contractAmount);
              lead.setFinancingType(financingType);
              lead.setCashPrice(cashPrice);
              lead.setProjectNotes(projectNotes);
              lead.setDcKw(dcKw);
              lead.setSolarModules(solarModules);
              lead.setSolarPanelQuantity(solarPanelQuantity);
              lead.setInverters(inverters);
              lead.setInverterQuantity(inverterQuantity);
              lead.setOtherAdders(otherAdders);
              lead.setEv(ev);
              lead.setMainPanelUpgrade(mainPanelUpgrade);
              lead.setBattery(battery);
              lead.setMeterspotRequested(meterspotRequested);
              lead.setUtilityCo(utilityCo);
              lead.setRoofInformation(roofInformation);
              lead.setCompanyCamLink(companyCamLink);
              lead.setActualClosedDate(dateFormat.parse(actualClosedDate));
              lead.setLayoutDrafted(layoutDrafted);
              lead.setLeadCreated(dateFormat.parse(leadCreated));
              lead.setDateOfLastActivity(dateFormat.parse(dateOfLastActivity));
              lead.setDateOfNextActivity(dateFormat.parse(dateOfNextActivity));
              lead.setConvertedContact(convertedContact);
              lead.setConvertedOrganization(convertedOrganization);
              lead.setConvertedOpportunity(convertedOpportunity);
              lead.setUsername(username);
              lead.setUseremail(useremail)
              leadDAO.insertLead(lead);
            }
          %>
        <HR>
          <div class="container mt-5">
            <div class="container">
              <form action="<%=rootUpdate%>lead.new.sec.jsp/" method="post">
                <div class="form-group">
                    <label>Name:</label>
                    <input type="text" class="form-control" name="name">
                </div>

                <div class="form-group">
                    <label>Phone:</label>
                    <input type="text" class="form-control" name="phone">
                </div>

                <div class="form-group">
                    <label>Address:</label>
                    <input type="text" class="form-control" name="address">
                </div>

                <div class="form-group">
                    <label>City:</label>
                    <input type="text" class="form-control" name="city">
                </div>

                <div class="form-group">
                    <label>Email Address:</label>
                    <input type="text" class="form-control" name="emailAddress">
                </div>

                <div class="form-group">
                    <label>Lead Status:</label>
                    <input type="text" class="form-control" name="leadStatus">
                </div>

                <div class="form-group">
                    <label>Change:</label>
                    <input type="text" class="form-control" name="change">
                </div>

                <div class="form-group">
                    <label>Interconnection Status:</label>
                    <input type="text" class="form-control" name="interconnectionStatus">
                </div>

                <div class="form-group">
                    <label>Sales Notes:</label>
                    <textarea class="form-control" name="salesNotes"></textarea>
                </div>
                <div class="form-group">
                  <label for="linkEmailAddress">Link Email Address:</label>
                  <input type="text" class="form-control" id="linkEmailAddress" name="linkEmailAddress">
                </div>

                <div class="form-group">
                  <label for="userResponsible">User Responsible:</label>
                  <input type="text" class="form-control" id="userResponsible" name="userResponsible">
                </div>

                <div class="form-group">
                  <label for="leadRating">Lead Rating:</label>
                  <input type="text" class="form-control" id="leadRating" name="leadRating">
                </div>

                <div class="form-group">
                  <label for="organization">Organization:</label>
                  <input type="text" class="form-control" id="organization" name="organization">
                </div>

                <div class="form-group">
                  <label for="leadSource">Lead Source:</label>
                  <input type="text" class="form-control" id="leadSource" name="leadSource">
                </div>

                <div class="form-group">
                  <label for="accountingNotes">Accounting Notes:</label>
                  <textarea class="form-control" id="accountingNotes" name="accountingNotes"></textarea>
                </div>

                <div class="form-group">
                  <label for="contractAmount">Contract Amount:</label>
                  <input type="number" step="0.01" class="form-control" id="contractAmount" name="contractAmount">
                </div>
                <div class="form-group">
                  <label for="financingType">Financing Type:</label>
                  <input type="text" class="form-control" id="financingType" name="financingType">
                </div>

                <div class="form-group">
                  <label for="cashPrice">CASH Price:</label>
                  <input type="number" step="0.01" class="form-control" id="cashPrice" name="cashPrice">
                </div>

                <div class="form-group">
                  <label for="projectNotes">Project Notes:</label>
                  <textarea class="form-control" id="projectNotes" name="projectNotes"></textarea>
                </div>

                <div class="form-group">
                  <label for="dcKw">DC KW:</label>
                  <input type="number" step="0.01" class="form-control" id="dcKw" name="dcKw">
                </div>

                <div class="form-group">
                  <label for="solarModules">Solar Modules:</label>
                  <input type="text" class="form-control" id="solarModules" name="solarModules">
                </div>

                <div class="form-group">
                  <label for="solarPanelQuantity">Solar Panel Quantity:</label>
                  <input type="number" class="form-control" id="solarPanelQuantity" name="solarPanelQuantity">
                </div>

                <div class="form-group">
                  <label for="inverters">Inverter's:</label>
                  <input type="text" class="form-control" id="inverters" name="inverters">
                </div>

                <div class="form-group">
                  <label for="inverterQuantity">Inverter Quantity:</label>
                  <input type="number" class="form-control" id="inverterQuantity" name="inverterQuantity">
                </div>

                <div class="form-group">
                  <label for="otherAdders">Other Adders:</label>
                  <input type="text" class="form-control" id="otherAdders" name="otherAdders">
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
                  <label for="roofInformation">Roof Information:</label>
                  <input type="text" class="form-control" id="roofInformation" name="roofInformation">
                </div>

                <div class="form-group">
                  <label for="companyCamLink">Company Cam Link:</label>
                  <input type="text" class="form-control" id="companyCamLink" name="companyCamLink">
                </div>

                <div class="form-group">
                  <label for="actualClosedDate">Actual Closed Date:</label>
                  <input type="date" class="form-control" id="actualClosedDate" name="actualClosedDate">
                </div>

                <div class="form-group">
                  <label for="layoutDrafted">Layout Drafted:</label>
                  <input type="text" class="form-control" id="layoutDrafted" name="layoutDrafted">
                </div>

                <div class="form-group">
                  <label for="leadCreated">Lead Created:</label>
                  <input type="date" class="form-control" id="leadCreated" name="leadCreated">
                </div>

                <div class="form-group">
                  <label for="dateOfLastActivity">Date of Last Activity:</label>
                  <input type="date" class="form-control" id="dateOfLastActivity" name="dateOfLastActivity">
                </div>

                <div class="form-group">
                  <label for="dateOfNextActivity">Date of Next Activity:</label>
                  <input type="date" class="form-control" id="dateOfNextActivity" name="dateOfNextActivity">
                </div>

                <div class="form-group">
                  <label for="convertedContact">Converted Contact:</label>
                  <input type="text" class="form-control" id="convertedContact" name="convertedContact">
                </div>

                <div class="form-group">
                  <label for="convertedOrganization">Converted Organization:</label>
                  <input type="text" class="form-control" id="convertedOrganization" name="convertedOrganization">
                </div>

                <div class="form-group">
                  <label for="convertedOpportunity">Converted Opportunity:</label>
                  <input type="text" class="form-control" id="convertedOpportunity" name="convertedOpportunity">
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
