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
          <a href="<%=rootUpdate%>opportunity.list.sec.jsp/" tabindex="2"><i class="fas fa-list"></i> Opportunity</a> |
            <a href="<%=rootUpdate%>opportunity.list.dash.sec.jsp/" tabindex="2"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
            <%

            OpportunityDAO opportunityDAO = new OpportunityDAO();
            Opportunity opportunity = new Opportunity();
            if (request.getMethod().equalsIgnoreCase("post")) {
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

                String hasAProjectBeenCreated = request.getParameter("hasAProjectBeenCreated");
                String name = request.getParameter("name");
                String organization = request.getParameter("organization");
                String convertedFromLead = request.getParameter("convertedFromLead");
                String email = request.getParameter("email");
                String interconnectionStatus = request.getParameter("interconnectionStatus");
                String phoneNumber = request.getParameter("phoneNumber");
                String address = request.getParameter("address");
                String city = request.getParameter("city");
                String linkedEmailAddress = request.getParameter("linkedEmailAddress");
                String wifiInformation = request.getParameter("wifiInformation");
                String salesNotes = request.getParameter("salesNotes");
                String userResponsible = request.getParameter("userResponsible");
                String currentState = request.getParameter("currentState");
                String siteEvaluation = request.getParameter("siteEvaluation");
                String utilityCo = request.getParameter("utilityCo");
                String solarModules = request.getParameter("solarModules");
                String inverters = request.getParameter("inverters");
                String solarPanelQuantityParam = request.getParameter("solarPanelQuantity");
                int solarPanelQuantity = 0; // Default value

                if (solarPanelQuantityParam != null && !solarPanelQuantityParam.isEmpty()) {
                    solarPanelQuantity = Integer.parseInt(solarPanelQuantityParam);
                }

                String inverterQuantityParam = request.getParameter("inverterQuantity");
                int inverterQuantity = 0; // Default value

                if (inverterQuantityParam != null && !inverterQuantityParam.isEmpty()) {
                    inverterQuantity = Integer.parseInt(inverterQuantityParam);
                }

                String mainPanelUpgrade = request.getParameter("mainPanelUpgrade");
                String otherAdders = request.getParameter("otherAdders");
                String companyCamLink = request.getParameter("companyCamLink");
                String dateOfNextActivity = request.getParameter("dateOfNextActivity");
                String dateOfLastActivity = request.getParameter("dateOfLastActivity");
                String battery = request.getParameter("battery");
                String financingType = request.getParameter("financingType");
                String accountingNotes = request.getParameter("accountingNotes");
                String actualCloseDate = request.getParameter("actualCloseDate");
                String opportunityCreated = request.getParameter("opportunityCreated");

                BigDecimal probabilityOfWinning;
                try {
                    String probabilityOfWinningParam = request.getParameter("probabilityOfWinning");
                    probabilityOfWinning = new BigDecimal(probabilityOfWinningParam);
                } catch (NumberFormatException | NullPointerException e) {
                    probabilityOfWinning = BigDecimal.ZERO;
                }

                BigDecimal dcKw;
                try {
                    String dcKwParam = request.getParameter("dcKw");
                    dcKw = new BigDecimal(dcKwParam);
                } catch (NumberFormatException | NullPointerException e) {
                    dcKw = BigDecimal.ZERO;
                }

                BigDecimal roofingPrice;
                try {
                    String roofingPriceParam = request.getParameter("roofingPrice");
                    roofingPrice = new BigDecimal(roofingPriceParam);
                } catch (NumberFormatException | NullPointerException e) {
                    roofingPrice = BigDecimal.ZERO;
                }

                BigDecimal opportunityValue;
                try {
                    String opportunityValueParam = request.getParameter("opportunityValue");
                    opportunityValue = new BigDecimal(opportunityValueParam);
                } catch (NumberFormatException | NullPointerException e) {
                    opportunityValue = BigDecimal.ZERO;
                }

                BigDecimal cashPrice;
                try {
                    String cashPriceParam = request.getParameter("cashPrice");
                    cashPrice = new BigDecimal(cashPriceParam);
                } catch (NumberFormatException | NullPointerException e) {
                    cashPrice = BigDecimal.ZERO;
                }

                BigDecimal contractAmount;
                try {
                    String contractAmountParam = request.getParameter("contractAmount");
                    contractAmount = new BigDecimal(contractAmountParam);
                } catch (NumberFormatException | NullPointerException e) {
                    contractAmount = BigDecimal.ZERO;
                }


                opportunity.setHasAProjectBeenCreated(hasAProjectBeenCreated);
                opportunity.setName(name);
                opportunity.setOrganization(organization);
                opportunity.setConvertedFromLead(convertedFromLead);
                opportunity.setEmail(email);
                opportunity.setInterconnectionStatus(interconnectionStatus);
                opportunity.setPhoneNumber(phoneNumber);
                opportunity.setAddress(address);
                opportunity.setCity(city);
                opportunity.setLinkedEmailAddress(linkedEmailAddress);
                opportunity.setWifiInformation(wifiInformation);
                opportunity.setSalesNotes(salesNotes);
                opportunity.setProbabilityOfWinning(probabilityOfWinning);
                opportunity.setUserResponsible(userResponsible);
                opportunity.setCurrentState(currentState);
                opportunity.setSiteEvaluation(siteEvaluation);
                opportunity.setUtilityCo(utilityCo);
                opportunity.setDcKw(dcKw);
                opportunity.setSolarModules(solarModules);
                opportunity.setInverters(inverters);
                opportunity.setSolarPanelQuantity(solarPanelQuantity);
                opportunity.setInverterQuantity(inverterQuantity);
                opportunity.setMainPanelUpgrade(mainPanelUpgrade);
                opportunity.setOtherAdders(otherAdders);
                opportunity.setCompanyCamLink(companyCamLink);
                if (dateOfNextActivity != null && !dateOfNextActivity.isEmpty()) {
                    opportunity.setDateOfNextActivity(dateFormat.parse(dateOfNextActivity));
                }
                if (dateOfLastActivity != null && !dateOfLastActivity.isEmpty()) {
                    opportunity.setDateOfLastActivity(dateFormat.parse(dateOfLastActivity));
                }
                opportunity.setBattery(battery);
                opportunity.setFinancingType(financingType);
                opportunity.setAccountingNotes(accountingNotes);
                opportunity.setRoofingPrice(roofingPrice);
                opportunity.setOpportunityValue(opportunityValue);
                opportunity.setCashPrice(cashPrice);
                opportunity.setContractAmount(contractAmount);
                if (actualCloseDate != null && !actualCloseDate.isEmpty()) {
                    opportunity.setActualCloseDate(dateFormat.parse(actualCloseDate));
                }
                opportunity.setUsername(username);
                opportunity.setUserEmail(useremail);
                //opportunityDAO.insertOpportunity(opportunity);
            }
            opportunity = opportunityDAO.getOpportunityByUsernameANDID(Integer.parseInt(request.getParameter("opportunity_id")),username);
            %>
        <HR>
          <div class="container mt-5">
            <div class="container">
                <h2>Create Opportunity</h2>
                <form action="<%=rootUpdate%>opportunity.new.sec.jsp/" method="post">
                <div class="form-group">
                    <label>Has a Project Been Created?</label>
                    <input type="text" class="form-control" name="hasAProjectBeenCreated">
                </div>

                <div class="form-group">
                    <label>Name</label>
                    <input type="text" class="form-control" name="name" value="<%=opportunity.getName()%>">
                </div>

                <div class="form-group">
                    <label>Organization</label>
                    <input type="text" class="form-control" name="organization">
                </div>

                <div class="form-group">
                    <label>Converted from Lead</label>
                    <input type="text" class="form-control" name="convertedFromLead">
                </div>

                <div class="form-group">
                    <label>Email</label>
                    <input type="email" class="form-control" name="email">
                </div>

                <div class="form-group">
                    <label>Interconnection Status</label>
                    <input type="text" class="form-control" name="interconnectionStatus">
                </div>

                <div class="form-group">
                    <label>Phone Number</label>
                    <input type="text" class="form-control" name="phoneNumber">
                </div>

                <div class="form-group">
                    <label>Address</label>
                    <input type="text" class="form-control" name="address">
                </div>

                <div class="form-group">
                    <label>City</label>
                    <input type="text" class="form-control" name="city">
                </div>

                <div class="form-group">
                    <label>Linked Email Address</label>
                    <input type="email" class="form-control" name="linkedEmailAddress">
                </div>

                <div class="form-group">
                    <label>WiFi Information</label>
                    <input type="text" class="form-control" name="wifiInformation">
                </div>

                <div class="form-group">
                    <label>Sales Notes</label>
                    <textarea class="form-control" name="salesNotes"></textarea>
                </div>

                <div class="form-group">
                    <label>Probability of Winning</label>
                    <input type="text" class="form-control" name="probabilityOfWinning">
                </div>

                <div class="form-group">
                    <label>User Responsible</label>
                    <input type="text" class="form-control" name="userResponsible">
                </div>

                <div class="form-group">
                    <label>Current State</label>
                    <input type="text" class="form-control" name="currentState">
                </div>

                <div class="form-group">
                    <label>Site Evaluation</label>
                    <input type="text" class="form-control" name="siteEvaluation">
                </div>

                <div class="form-group">
                    <label>Utility Co</label>
                    <input type="text" class="form-control" name="utilityCo">
                </div>
                    <!-- Include other input fields for Opportunity data -->
                    <div class="form-group">
                        <label>DC kW</label>
                        <input type="text" class="form-control" name="dcKw">
                    </div>

                    <div class="form-group">
                        <label>Solar Modules</label>
                        <input type="text" class="form-control" name="solarModules">
                    </div>

                    <div class="form-group">
                        <label>Inverters</label>
                        <input type="text" class="form-control" name="inverters">
                    </div>

                    <div class="form-group">
                        <label>Solar Panel Quantity</label>
                        <input type="number" class="form-control" name="solarPanelQuantity">
                    </div>

                    <div class="form-group">
                        <label>Inverter Quantity</label>
                        <input type="number" class="form-control" name="inverterQuantity">
                    </div>

                    <div class="form-group">
                        <label>Main Panel Upgrade</label>
                        <input type="text" class="form-control" name="mainPanelUpgrade">
                    </div>

                    <div class="form-group">
                        <label>Other Adders</label>
                        <input type="text" class="form-control" name="otherAdders">
                    </div>

                    <div class="form-group">
                        <label>Company CAM Link</label>
                        <input type="text" class="form-control" name="companyCamLink">
                    </div>

                    <div class="form-group">
                        <label>Date of Next Activity</label>
                        <input type="date" class="form-control" name="dateOfNextActivity">
                    </div>

                    <div class="form-group">
                        <label>Date of Last Activity</label>
                        <input type="date" class="form-control" name="dateOfLastActivity">
                    </div>

                    <div class="form-group">
                        <label>Battery</label>
                        <input type="text" class="form-control" name="battery">
                    </div>

                    <div class="form-group">
                        <label>Financing Type</label>
                        <input type="text" class="form-control" name="financingType">
                    </div>

                    <div class="form-group">
                        <label>Accounting Notes</label>
                        <textarea class="form-control" name="accountingNotes"></textarea>
                    </div>

                    <div class="form-group">
                        <label>Roofing Price</label>
                        <input type="text" class="form-control" name="roofingPrice">
                    </div>

                    <div class="form-group">
                        <label>Opportunity Value</label>
                        <input type="text" class="form-control" name="opportunityValue">
                    </div>

                    <div class="form-group">
                        <label>Cash Price</label>
                        <input type="text" class="form-control" name="cashPrice">
                    </div>

                    <div class="form-group">
                        <label>Contract Amount</label>
                        <input type="text" class="form-control" name="contractAmount">
                    </div>

                    <div class="form-group">
                        <label>Actual Close Date</label>
                        <input type="date" class="form-control" name="actualCloseDate">
                    </div>

                    <div class="form-group">
                        <label>Opportunity Created</label>
                        <input type="date" class="form-control" name="opportunityCreated">
                    </div>


                    <button type="submit" class="btn btn-primary">Submit</button>
                </form>

                <HR>
            </div>
          </div>
        </div>
      </div>
    </section><!-- End Blog Section -->
  </main>
</body>
</html>
