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
          <a href="<%=rootUpdate%>lead.list.sec.jsp/" tabindex="2"><i class="fas fa-list"></i> Leads</a> |
            <a href="<%=rootUpdate%>lead.list.dash.sec.jsp/" tabindex="2"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
          <%
              LeadDAO leadDAO = new LeadDAO();
              Lead lead = new Lead();

              if (request.getMethod().equalsIgnoreCase("post")) {
                  // Create an instance of the LeadDAO class
                  SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

                  String name = request.getParameter("name");
                  String lname = request.getParameter("lname");
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

                  lead.setLocation_pointlat(request.getParameter("location_pointlat"));
                  lead.setLocation_pointlng(request.getParameter("location_pointlng"));
                  // Create an instance of the Lead class and populate it with the form data
                  lead.setName(name);
                  lead.setLname(lname);
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
                  lead.setLocation_pointlat(request.getParameter("location_pointlat"));
                  lead.setLocation_pointlng(request.getParameter("location_pointlng"));
                  lead.setRecordId(Integer.parseInt(request.getParameter("lead_id")));
                  leadDAO.updateLead(lead);
                }

              lead = leadDAO.getLead(username, Integer.parseInt(request.getParameter("lead_id")));

              SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
          %>
        <HR>
          <div class="container mt-5">
            <div class="container">

              <h4>Lead ID: <%=lead.getRecordId()%> (<a href="<%=rootUpdate%>lead.edit.com.sec.jsp/?lead_id=<%=lead.getRecordId()%>" tabindex="2">Messaging</a>)</h4>
              <form action="<%=rootUpdate%>lead.edit.sec.jsp/" method="post">
                <input type="hidden" class="form-control" name="lead_id" value="<%=lead.getRecordId()%>">
                <input type="hidden" class="form-control" id="location_pointlat" name="location_pointlat" value="<%= lead.getLocation_pointlat() %>">
                <input type="hidden" class="form-control" id="location_pointlng" name="location_pointlng" value="<%= lead.getLocation_pointlng() %>">
                <div class="form-group">
                    <label>First Name:</label>
                    <input type="text" class="form-control" name="name" value="<%=lead.getName()%>">
                </div>
                <div class="form-group">
                    <label>Last Name:</label>
                    <input type="text" class="form-control" name="lname" value="<%=lead.getLname()%>">
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
                  <select class="form-control" name="leadStatus">
                    <option value="Lead Generation" <%= lead.getLeadStatus().equals("Lead Generation") ? "selected" : "" %>>Lead Generation</option>
                    <option value="Initial Contact" <%= lead.getLeadStatus().equals("Initial Contact") ? "selected" : "" %>>Initial Contact</option>
                    <option value="Site Assessment" <%= lead.getLeadStatus().equals("Site Assessment") ? "selected" : "" %>>Site Assessment</option>
                    <option value="Roof Check" <%= lead.getLeadStatus().equals("Roof Check") ? "selected" : "" %>>Roof Check</option>
                    <option value="Electrical Panel Check" <%= lead.getLeadStatus().equals("Electrical Panel Check") ? "selected" : "" %>>Electrical Panel Check</option>
                    <option value="Shade Analysis" <%= lead.getLeadStatus().equals("Shade Analysis") ? "selected" : "" %>>Shade Analysis</option>
                    <option value="Proposal Preparation" <%= lead.getLeadStatus().equals("Proposal Preparation") ? "selected" : "" %>>Proposal Preparation</option>
                    <option value="Proposal Presentation" <%= lead.getLeadStatus().equals("Proposal Presentation") ? "selected" : "" %>>Proposal Presentation</option>
                    <option value="Financial Analysis" <%= lead.getLeadStatus().equals("Financial Analysis") ? "selected" : "" %>>Financial Analysis</option>
                    <option value="Incentives and Rebates" <%= lead.getLeadStatus().equals("Incentives and Rebates") ? "selected" : "" %>>Incentives and Rebates</option>
                    <option value="Negotiation and Agreement" <%= lead.getLeadStatus().equals("Negotiation and Agreement") ? "selected" : "" %>>Negotiation and Agreement</option>
                    <option value="Permitting and Documentation" <%= lead.getLeadStatus().equals("Permitting and Documentation") ? "selected" : "" %>>Permitting and Documentation</option>
                    <option value="Equipment Procurement" <%= lead.getLeadStatus().equals("Equipment Procurement") ? "selected" : "" %>>Equipment Procurement</option>
                    <option value="Installation Scheduling" <%= lead.getLeadStatus().equals("Installation Scheduling") ? "selected" : "" %>>Installation Scheduling</option>
                    <option value="Installation and Commissioning" <%= lead.getLeadStatus().equals("Installation and Commissioning") ? "selected" : "" %>>Installation and Commissioning</option>
                    <option value="Inspections and Approvals" <%= lead.getLeadStatus().equals("Inspections and Approvals") ? "selected" : "" %>>Inspections and Approvals</option>
                    <option value="System Activation and Monitoring" <%= lead.getLeadStatus().equals("System Activation and Monitoring") ? "selected" : "" %>>System Activation and Monitoring</option>
                    <option value="Customer Satisfaction and Referrals" <%= lead.getLeadStatus().equals("Customer Satisfaction and Referrals") ? "selected" : "" %>>Customer Satisfaction and Referrals</option>
                    <option value="Ongoing Customer Relationship" <%= lead.getLeadStatus().equals("Ongoing Customer Relationship") ? "selected" : "" %>>Ongoing Customer Relationship</option>
                  </select>
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

                <div class="form-group">
                  <label>Actual Closed Date:</label>
                  <input type="date" class="form-control" name="actualClosedDate" value="<% if (lead.getActualClosedDate() != null) { %><%= formatDate.format(lead.getActualClosedDate()) %><%}%>">
                </div>

                <div class="form-group">
                  <label>Layout Drafted:</label>
                  <input type="text" class="form-control" name="layoutDrafted" value="<%= lead.getLayoutDrafted() %>">
                </div>

                <div class="form-group">
                  <label>Lead Created:</label>
                  <input type="date" class="form-control" name="leadCreated" value="<% if (lead.getLeadCreated() != null) { %><%= formatDate.format(lead.getLeadCreated()) %><%}%>">
                </div>

                <div class="form-group">
                  <label>Date of Last Activity:</label>
                  <input type="date" class="form-control" name="dateOfLastActivity" value="<% if (lead.getDateOfLastActivity() != null) { %><%= formatDate.format(lead.getDateOfLastActivity()) %><%}%>">
                </div>

                <div class="form-group">
                  <label>Date of Next Activity:</label>
                  <input type="date" class="form-control" name="dateOfNextActivity" value="<% if (lead.getDateOfNextActivity() != null) { %><%= formatDate.format(lead.getDateOfNextActivity()) %><%}%>">
                </div>

                <div class="form-group">
                  <label>Converted Contact:</label>
                  <input type="text" class="form-control" name="convertedContact" value="<%= lead.getConvertedContact() %>">
                </div>

                <div class="form-group">
                  <label>Converted Organization:</label>
                  <input type="text" class="form-control" name="convertedOrganization" value="<%= lead.getConvertedOrganization() %>">
                </div>

                <div class="form-group">
                  <label>Converted Opportunity:</label>
                  <input type="text" class="form-control" name="convertedOpportunity" value="<%= lead.getConvertedOpportunity() %>">
                </div>

                <BR>
                    <input type="submit" value="Save">
                </form>

            </div>
          </div>
        </div>
      </div>
    </section><!-- End Blog Section -->
  </main>
</body>
</html>
