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
              String contractAmountParam = request.getParameter("contractAmount");
              double contractAmount;

              if (contractAmountParam != null && !contractAmountParam.isEmpty()) {
                  contractAmount = Double.parseDouble(contractAmountParam);
              } else {
                  // Handle the case when contractAmount is not provided or empty
                  // For example, you can assign a default value or show an error message.
                  contractAmount = 0.0; // Default value or appropriate handling
              }

              String financingType = request.getParameter("financingType");
              String cashPriceParam = request.getParameter("cashPrice");
              double cashPrice;

              if (cashPriceParam != null && !cashPriceParam.isEmpty()) {
                  cashPrice = Double.parseDouble(cashPriceParam);
              } else {
                  // Handle the case when cashPrice is not provided or empty
                  // For example, you can assign a default value or show an error message.
                  cashPrice = 0.0; // Default value or appropriate handling
              }

              String projectNotes = request.getParameter("projectNotes");

              String dcKwParam = request.getParameter("dcKw");
              double dcKw;

              if (dcKwParam != null && !dcKwParam.isEmpty()) {
                  dcKw = Double.parseDouble(dcKwParam);
              } else {
                  // Handle the case when dcKw is not provided or empty
                  // For example, you can assign a default value or show an error message.
                  dcKw = 0.0; // Default value or appropriate handling
              }

              String solarModules = request.getParameter("solarModules");

              String solarPanelQuantityParam = request.getParameter("solarPanelQuantity");
              int solarPanelQuantity;

              if (solarPanelQuantityParam != null && !solarPanelQuantityParam.isEmpty()) {
                  solarPanelQuantity = Integer.parseInt(solarPanelQuantityParam);
              } else {
                  // Handle the case when solarPanelQuantity is not provided or empty
                  // For example, you can assign a default value or show an error message.
                  solarPanelQuantity = 0; // Default value or appropriate handling
              }

              String inverters = request.getParameter("inverters");

              String inverterQuantityParam = request.getParameter("inverterQuantity");
              int inverterQuantity;

              if (inverterQuantityParam != null && !inverterQuantityParam.isEmpty()) {
                  inverterQuantity = Integer.parseInt(inverterQuantityParam);
              } else {
                  // Handle the case when inverterQuantity is not provided or empty
                  // For example, you can assign a default value or show an error message.
                  inverterQuantity = 0; // Default value or appropriate handling
              }

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
              if (actualClosedDate != null && !actualClosedDate.isEmpty()) {
                  lead.setActualClosedDate(dateFormat.parse(actualClosedDate));
              }
              lead.setLayoutDrafted(layoutDrafted);

              if (leadCreated != null && !leadCreated.isEmpty()) {
                  lead.setLeadCreated(dateFormat.parse(leadCreated));
              }

              if (dateOfLastActivity != null && !dateOfLastActivity.isEmpty()) {
                  lead.setDateOfLastActivity(dateFormat.parse(dateOfLastActivity));
              }

              if (dateOfNextActivity != null && !dateOfNextActivity.isEmpty()) {
                  lead.setDateOfNextActivity(dateFormat.parse(dateOfNextActivity));
              }

              lead.setConvertedContact(convertedContact);
              lead.setConvertedOrganization(convertedOrganization);
              lead.setConvertedOpportunity(convertedOpportunity);
              lead.setUsername(username);
              lead.setUseremail(useremail);
              leadDAO.insertLead(lead);
            }
          %>

            </div>
          </div>
        </div>
      </div>
    </section><!-- End Blog Section -->
  </main>
</body>
</html>