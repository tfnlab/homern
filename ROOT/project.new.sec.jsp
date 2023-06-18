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
        <h2>Projects</h2>
        <HR>
        <HR>
          <a href="<%=rootUpdate%>project.list.sec.jsp/" tabindex="2"><i class="fas fa-list"></i> Projects</a> |
            <a href="<%=rootUpdate%>project.list.dash.sec.jsp/" tabindex="2"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
        <HR>
          <div class="container mt-5">
            <div class="container">
                <h3>Project List CSV <a href="<%=rootUpdate%>project.list.csv.sec.jsp/?csv=true" tabindex="2"><i class="fas fa-download"></i></a> <a href="<%=rootUpdate%>project.new.bulk.sec.jsp/?csv=true" tabindex="2"><i class="fas fa-upload"></i></a>  </h3>
                <div class="row">
                  <form action="<%=rootUpdate%>project.new.sec.jsp/" method="post">
                  <div class="form-group">
                    <label for="projectName">Project Name:</label>
                    <input type="text" class="form-control" id="projectName" name="projectName" required>
                  </div>
                  <div class="form-group">
                    <label for="phoneNumber">Phone Number:</label>
                    <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" required>
                  </div>
                  <div class="form-group">
                    <label for="address">Address:</label>
                    <input type="text" class="form-control" id="address" name="address" required>
                  </div>
                  <div class="form-group">
                    <label for="city">City:</label>
                    <input type="text" class="form-control" id="city" name="city" required>
                  </div>
                  <div class="form-group">
                    <label for="emailOrContactInformation">Email or Contact Information:</label>
                    <input type="text" class="form-control" id="emailOrContactInformation" name="emailOrContactInformation" required>
                  </div>
                  <div class="form-group">
                    <label for="interconnectionStatus">Interconnection Status:</label>
                    <input type="text" class="form-control" id="interconnectionStatus" name="interconnectionStatus" required>
                  </div>
                  <div class="form-group">
                    <label for="projectsStatus">Projects Status:</label>
                    <input type="text" class="form-control" id="projectsStatus" name="projectsStatus" required>
                  </div>
                  <div class="form-group">
                    <label for="wifiInformation">Wifi Information:</label>
                    <input type="text" class="form-control" id="wifiInformation" name="wifiInformation" required>
                  </div>
                  <div class="form-group">
                    <label for="wifiNetwork">Wifi Network:</label>
                    <input type="text" class="form-control" id="wifiNetwork" name="wifiNetwork" required>
                  </div>
                  <div class="form-group">
                    <label for="wifiPassword">Wifi Password:</label>
                    <input type="text" class="form-control" id="wifiPassword" name="wifiPassword" required>
                  </div>
                  <div class="form-group">
                    <label for="projectNotes">Project Notes:</label>
                    <textarea class="form-control" id="projectNotes" name="projectNotes" required></textarea>
                  </div>
                  <div class="form-group">
                    <label for="userResponsible">User Responsible:</label>
                    <input type="text" class="form-control" id="userResponsible" name="userResponsible" required>
                  </div>
                  <div class="form-group">
                    <label for="projectsDescription">Projects Description:</label>
                    <textarea class="form-control" id="projectsDescription" name="projectsDescription" required></textarea>
                  </div>
                          <div class="form-group">
                            <label for="installDate">Install Date:</label>
                          <input type="date" class="form-control" id="installDate" name="installDate" required>
                        </div>
                        <div class="form-group">
                          <label for="projectsOrganization">Projects Organization:</label>
                          <input type="text" class="form-control" id="projectsOrganization" name="projectsOrganization" required>
                        </div>
                        <div class="form-group">
                          <label for="siteEvaluation">Site Evaluation:</label>
                          <input type="text" class="form-control" id="siteEvaluation" name="siteEvaluation" required>
                        </div>
                        <div class="form-group">
                          <label for="meterspotRequested">Meterspot Requested:</label>
                          <input type="text" class="form-control" id="meterspotRequested" name="meterspotRequested" required>
                        </div>
                        <div class="form-group">
                          <label for="layoutDrafted">Layout Drafted:</label>
                          <input type="text" class="form-control" id="layoutDrafted" name="layoutDrafted" required>
                        </div>
                        <div class="form-group">
                          <label for="plansDrafted">Plans Drafted:</label>
                          <input type="text" class="form-control" id="plansDrafted" name="plansDrafted" required>
                        </div>
                        <div class="form-group">
                          <label for="submittedToPermitting">Submitted to Permitting:</label>
                          <input type="text" class="form-control" id="submittedToPermitting" name="submittedToPermitting" required>
                        </div>
                        <div class="form-group">
                          <label for="salesNotes">Sales Notes:</label>
                          <textarea class="form-control" id="salesNotes" name="salesNotes" required></textarea>
                        </div>
                        <div class="form-group">
                          <label for="otherAdders">Other Adders:</label>
                          <input type="text" class="form-control" id="otherAdders" name="otherAdders" required>
                        </div>
                        <div class="form-group">
                          <label for="companyCamLink">Company Cam Link:</label>
                          <input type="text" class="form-control" id="companyCamLink" name="companyCamLink" required>
                        </div>
                        <div class="form-group">
                          <label for="utilityCo">Utility Co:</label>
                          <input type="text" class="form-control" id="utilityCo" name="utilityCo" required>
                        </div>
                        <div class="form-group">
                          <label for="solarModules">Solar Modules:</label>
                          <input type="text" class="form-control" id="solarModules" name="solarModules" required>
                        </div>
                        <div class="form-group">
                          <label for="inverters">Inverters:</label>
                          <input type="text" class="form-control" id="inverters" name="inverters" required>
                        </div>
                        <div class="form-group">
                          <label for="dcKw">DC kW:</label>
                          <input type="number" step="0.01" class="form-control" id="dcKw" name="dcKw" required>
                        </div>
                        <div class="form-group">
                                <label for="solarPanelQuantity">Solar Panel Quantity:</label>
                                <input type="number" class="form-control" id="solarPanelQuantity" name="solarPanelQuantity" required>
                                      </div>
                                      <div class="form-group">
                                        <label for="inverterQuantity">Inverter Quantity:</label>
                                        <input type="number" class="form-control" id="inverterQuantity" name="inverterQuantity" required>
                                      </div>
                                      <div class="form-group">
                                        <label for="battery">Battery:</label>
                                        <input type="text" class="form-control" id="battery" name="battery" required>
                                      </div>
                                      <div class="form-group">
                                        <label for="sgipRebate">SGIP Rebate:</label>
                                        <input type="number" step="0.01" class="form-control" id="sgipRebate" name="sgipRebate" required>
                                      </div>
                                      <div class="form-group">
                                        <label for="sgipRebateType">SGIP Rebate Type:</label>
                                        <input type="text" class="form-control" id="sgipRebateType" name="sgipRebateType" required>
                                      </div>
                                      <div class="form-group">
                                        <label for="sgipRebateStatus">SGIP Rebate Status:</label>
                                        <input type="text" class="form-control" id="sgipRebateStatus" name="sgipRebateStatus" required>
                                      </div>
                                      <div class="form-group">
                                        <label for="mainPanelUpgrade">Main Panel Upgrade:</label>
                                        <input type="text" class="form-control" id="mainPanelUpgrade" name="mainPanelUpgrade" required>
                                      </div>
                                      <div class="form-group">
                                        <label for="breakerTypeNeeded">Breaker Type Needed:</label>
                                        <input type="text" class="form-control" id="breakerTypeNeeded" name="breakerTypeNeeded" required>
                                      </div>
                                      <div class="form-group">
                                        <label for="downsizeNeeded">Downsize Needed:</label>
                                        <input type="text" class="form-control" id="downsizeNeeded" name="downsizeNeeded" required>
                                      </div>
                                      <div class="form-group">
                                        <label for="isEv">Is EV:</label>
                                        <input type="text" class="form-control" id="isEv" name="isEv" required>
                                      </div>
                                      <div class="form-group">
                                        <label for="subPanel">Sub Panel:</label>
                                        <input type="text" class="form-control" id="subPanel" name="subPanel" required>
                                      </div>
                                      <div class="form-group">
                                        <label for="panelDescription">Panel Description:</label>
                                        <input type="text" class="form-control" id="panelDescription" name="panelDescription" required>
                                      </div>
                                      <div class="form-group">
                                        <label for="inspectionDate">Inspection Date:</label>
                                        <input type="date" class="form-control" id="inspectionDate" name="inspectionDate" required>
                                      </div>
                                      <div class="form-group">
                                        <label for="inspectionPassed">Inspection Passed:</label>
                                        <input type="text" class="form-control" id="inspectionPassed" name="inspectionPassed" required>
                                      </div>
                                      <div class="form-group">
                                        <label for="reinspectionDate">Reinspection Date:</label>
                                        <input type="date" class="form-control" id="reinspectionDate" name="reinspectionDate" required>
                                              </div>
                                              <div class="form-group">
                                                <label for="placardStatus">Placard Status:</label>
                                                <input type="text" class="form-control" id="placardStatus" name="placardStatus" required>
                                              </div>
                                              <div class="form-group">
                                                <label for="placardsInPossession">Placards in Possession:</label>
                                                <input type="text" class="form-control" id="placardsInPossession" name="placardsInPossession" required>
                                              </div>
                                              <div class="form-group">
                                                <label for="acDiscoPlacardsNeeded">AC Disco Placards Needed:</label>
                                                <input type="text" class="form-control" id="acDiscoPlacardsNeeded" name="acDiscoPlacardsNeeded" required>
                                              </div>
                                              <div class="form-group">
                                                <label for="inspectionTech">Inspection Tech:</label>
                                                <input type="text" class="form-control" id="inspectionTech" name="inspectionTech" required>
                                              </div>
                                              <div class="form-group">
                                                <label for="accountingNotes">Accounting Notes:</label>
                                                <textarea class="form-control" id="accountingNotes" name="accountingNotes" required></textarea>
                                              </div>
                                              <div class="form-group">
                                                <label for="roofingPrice">Roofing Price:</label>
                                                <input type="number" step="0.01" class="form-control" id="roofingPrice" name="roofingPrice" required>
                                              </div>
                                              <div class="form-group">
                                                <label for="otherAddersPrice">Other Adders Price:</label>
                                                <input type="number" step="0.01" class="form-control" id="otherAddersPrice" name="otherAddersPrice" required>
                                              </div>
                                              <div class="form-group">
                                                <label for="contractAmount">Contract Amount:</label>
                                                <input type="number" step="0.01" class="form-control" id="contractAmount" name="contractAmount" required>
                                              </div>
                                              <div class="form-group">
                                                <label for="cashPrice">Cash Price:</label>
                                                <input type="number" step="0.01" class="form-control" id="cashPrice" name="cashPrice" required>
                                              </div>
                                              <div class="form-group">
                                                <label for="financingType">Financing Type:</label>
                                                <input type="text" class="form-control" id="financingType" name="financingType" required>
                                              </div>
                                              <div class="form-group">
                                                <label for="m1Amount">M1 Amount:</label>
                                                <input type="number" step="0.01" class="form-control" id="m1Amount" name="m1Amount" required>
                                              </div>
                                              <div class="form-group">
                                                <label for="m1PaymentRequested">M1 Payment Requested:</label>
                                                <input type="number" step="0.01" class="form-control" id="m1PaymentRequested" name="m1PaymentRequested" required>
                                              </div>
                                              <div class="form-group">
                                                <label for="paymentReceivedM1">Payment Received M1:</label>
                                                <input type="number" step="0.01" class="form-control" id="paymentReceivedM1" name="paymentReceivedM1" required>
                                              </div>
                                              <div class="form-group">
                                                <label for="m2Amount">M2 Amount:</label>
                                                <input type="number" step="0.01" class="form-control" id="m2Amount" name="m2Amount" required>
                                              </div>
                                              <div class="form-group">
                                                <label for="m2PaymentRequested">M2 Payment Requested:</label>
                                                <input type="number" step="0.01" class="form-control" id="m2PaymentRequested" name="m2PaymentRequested" required>
                                              </div>
                                              <div class="form-group">
                                                <label for="paymentReceivedM2">Payment Received M2:</label>
                                                <input type="number" step="0.01" class="form-control" id="paymentReceivedM2" name="paymentReceivedM2" required>
                                              </div>
                                              <div class="form-group">
                                                <label for="isSalesCommissionsPaid">Is Sales Commissions Paid:</label>
                                                <input type="text" class="form-control" id="isSalesCommissionsPaid" name="isSalesCommissionsPaid" required>
                                              </div>

                                              <!-- Add more fields if needed -->

                                              <button type="submit" class="btn btn-primary">Submit</button>
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
