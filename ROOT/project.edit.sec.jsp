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
<%@ page import="com.tfnlab.mysql.Project,com.tfnlab.mysql.ProjectDAO" %>
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
        <h2>Project</h2>
        <%

        ProjectDAO projectDAO = new ProjectDAO();
        Project project = new Project();

          if (request.getMethod().equalsIgnoreCase("post")) {
              // Retrieve form data
              String projectName = request.getParameter("projectName");
              String phoneNumber = request.getParameter("phoneNumber");
              String address = request.getParameter("address");
              String city = request.getParameter("city");
              String emailOrContactInformation = request.getParameter("emailOrContactInformation");
              String interconnectionStatus = request.getParameter("interconnectionStatus");
              String projectsStatus = request.getParameter("projectsStatus");
              String wifiInformation = request.getParameter("wifiInformation");
              String wifiNetwork = request.getParameter("wifiNetwork");
              String wifiPassword = request.getParameter("wifiPassword");
              String projectNotes = request.getParameter("projectNotes");
              String userResponsible = request.getParameter("userResponsible");
              String projectsDescription = request.getParameter("projectsDescription");
              java.sql.Date installDate = null;
              String installDateParam = request.getParameter("installDate");
              if (installDateParam != null && !installDateParam.isBlank()) {
                  try {
                      installDate = java.sql.Date.valueOf(installDateParam);
                  } catch (IllegalArgumentException e) {
                      // Handle invalid date format
                  }
              }
              String projectsOrganization = request.getParameter("projectsOrganization");
              String siteEvaluation = request.getParameter("siteEvaluation");
              java.sql.Date projectCreated = new java.sql.Date(System.currentTimeMillis());
              String meterspotRequested = request.getParameter("meterspotRequested");
              String layoutDrafted = request.getParameter("layoutDrafted");
              String plansDrafted = request.getParameter("plansDrafted");
              String submittedToPermitting = request.getParameter("submittedToPermitting");
              String salesNotes = request.getParameter("salesNotes");
              String otherAdders = request.getParameter("otherAdders");
              String companyCamLink = request.getParameter("companyCamLink");
              String utilityCo = request.getParameter("utilityCo");
              String solarModules = request.getParameter("solarModules");
              String inverters = request.getParameter("inverters");
              double dcKw = 0.0;
              String dcKwParam = request.getParameter("dcKw");
              if (dcKwParam != null && !dcKwParam.isBlank()) {
                  try {
                      dcKw = Double.parseDouble(dcKwParam);
                  } catch (NumberFormatException e) {
                      // Handle invalid double format
                  }
              }
              int solarPanelQuantity = 0;
              String solarPanelQuantityParam = request.getParameter("solarPanelQuantity");
              if (solarPanelQuantityParam != null && !solarPanelQuantityParam.isBlank()) {
                  try {
                      solarPanelQuantity = Integer.parseInt(solarPanelQuantityParam);
                  } catch (NumberFormatException e) {
                      // Handle invalid integer format
                  }
              }
              int inverterQuantity = 0;
              String inverterQuantityParam = request.getParameter("inverterQuantity");
              if (inverterQuantityParam != null && !inverterQuantityParam.isBlank()) {
                  try {
                      inverterQuantity = Integer.parseInt(inverterQuantityParam);
                  } catch (NumberFormatException e) {
                      // Handle invalid integer format
                  }
              }
              String battery = request.getParameter("battery");
              double sgipRebate = 0.0;
              String sgipRebateParam = request.getParameter("sgipRebate");
              if (sgipRebateParam != null && !sgipRebateParam.isBlank()) {
                  try {
                      sgipRebate = Double.parseDouble(sgipRebateParam);
                  } catch (NumberFormatException e) {
                      // Handle invalid double format
                  }
              }
              String sgipRebateType = request.getParameter("sgipRebateType");
              String sgipRebateStatus = request.getParameter("sgipRebateStatus");
              String mainPanelUpgrade = request.getParameter("mainPanelUpgrade");
              String breakerTypeNeeded = request.getParameter("breakerTypeNeeded");
              String downsizeNeeded = request.getParameter("downsizeNeeded");
              String isEv = request.getParameter("isEv");
              String subPanel = request.getParameter("subPanel");
              String panelDescription = request.getParameter("panelDescription");
              java.sql.Date inspectionDate = null;
              String inspectionDateParam = request.getParameter("inspectionDate");
              if (inspectionDateParam != null && !inspectionDateParam.isBlank()) {
                  try {
                      inspectionDate = java.sql.Date.valueOf(inspectionDateParam);
                  } catch (IllegalArgumentException e) {
                      // Handle invalid date format
                  }
              }
              String inspectionPassed = request.getParameter("inspectionPassed");
              java.sql.Date reinspectionDate = null;
              String reinspectionDateParam = request.getParameter("reinspectionDate");
              if (reinspectionDateParam != null && !reinspectionDateParam.isBlank()) {
                  try {
                      reinspectionDate = java.sql.Date.valueOf(reinspectionDateParam);
                  } catch (IllegalArgumentException e) {
                      // Handle invalid date format
                  }
              }
              String placardStatus = request.getParameter("placardStatus");
              String placardsInPossession = request.getParameter("placardsInPossession");
              String acDiscoPlacardsNeeded = request.getParameter("acDiscoPlacardsNeeded");
              String inspectionTech = request.getParameter("inspectionTech");
              String accountingNotes = request.getParameter("accountingNotes");
              double roofingPrice = 0.0;
              String roofingPriceParam = request.getParameter("roofingPrice");
              if (roofingPriceParam != null && !roofingPriceParam.isBlank()) {
                  try {
                      roofingPrice = Double.parseDouble(roofingPriceParam);
                  } catch (NumberFormatException e) {
                      // Handle invalid double format
                  }
              }
              double otherAddersPrice = 0.0;
              String otherAddersPriceParam = request.getParameter("otherAddersPrice");
              if (otherAddersPriceParam != null && !otherAddersPriceParam.isBlank()) {
                  try {
                      otherAddersPrice = Double.parseDouble(otherAddersPriceParam);
                  } catch (NumberFormatException e) {
                      // Handle invalid double format
                  }
              }
              double contractAmount = 0.0;
              String contractAmountParam = request.getParameter("contractAmount");
              if (contractAmountParam != null && !contractAmountParam.isBlank()) {
                  try {
                      contractAmount = Double.parseDouble(contractAmountParam);
                  } catch (NumberFormatException e) {
                      // Handle invalid double format
                  }
              }
              double cashPrice = 0.0;
              String cashPriceParam = request.getParameter("cashPrice");
              if (cashPriceParam != null && !cashPriceParam.isBlank()) {
                  try {
                      cashPrice = Double.parseDouble(cashPriceParam);
                  } catch (NumberFormatException e) {
                      // Handle invalid double format
                  }
              }
              String financingType = request.getParameter("financingType");
              double m1Amount = 0.0;
              String m1AmountParam = request.getParameter("m1Amount");
              if (m1AmountParam != null && !m1AmountParam.isBlank()) {
                  try {
                      m1Amount = Double.parseDouble(m1AmountParam);
                  } catch (NumberFormatException e) {
                      // Handle invalid double format
                  }
              }
              double m1PaymentRequested = 0.0;
              String m1PaymentRequestedParam = request.getParameter("m1PaymentRequested");
              if (m1PaymentRequestedParam != null && !m1PaymentRequestedParam.isBlank()) {
                  try {
                      m1PaymentRequested = Double.parseDouble(m1PaymentRequestedParam);
                  } catch (NumberFormatException e) {
                      // Handle invalid double format
                  }
              }
              double paymentReceivedM1 = 0.0;
              String paymentReceivedM1Param = request.getParameter("paymentReceivedM1");
              if (paymentReceivedM1Param != null && !paymentReceivedM1Param.isBlank()) {
                  try {
                      paymentReceivedM1 = Double.parseDouble(paymentReceivedM1Param);
                    } catch (NumberFormatException e) {
                        // Handle invalid double format
                    }
                }
                      double m2Amount = 0.0;
                      String m2AmountParam = request.getParameter("m2Amount");
                      if (m2AmountParam != null && !m2AmountParam.isBlank()) {
                          try {
                              m2Amount = Double.parseDouble(m2AmountParam);
                          } catch (NumberFormatException e) {
                              // Handle invalid double format
                          }
                      }
                      double m2PaymentRequested = 0.0;
                      String m2PaymentRequestedParam = request.getParameter("m2PaymentRequested");
                      if (m2PaymentRequestedParam != null && !m2PaymentRequestedParam.isBlank()) {
                          try {
                              m2PaymentRequested = Double.parseDouble(m2PaymentRequestedParam);
                          } catch (NumberFormatException e) {
                              // Handle invalid double format
                          }
                      }
                      double paymentReceivedM2 = 0.0;
                      String paymentReceivedM2Param = request.getParameter("paymentReceivedM2");
                      if (paymentReceivedM2Param != null && !paymentReceivedM2Param.isBlank()) {
                          try {
                              paymentReceivedM2 = Double.parseDouble(paymentReceivedM2Param);
                          } catch (NumberFormatException e) {
                              // Handle invalid double format
                          }
                      }
                      String isSalesCommissionsPaid = request.getParameter("isSalesCommissionsPaid");

                      java.sql.Date actualCloseDate = null;
                      String actualCloseDateParam = request.getParameter("actualCloseDate");
                      if (actualCloseDateParam != null && !actualCloseDateParam.isBlank()) {
                          try {
                              actualCloseDate = java.sql.Date.valueOf(actualCloseDateParam);
                          } catch (IllegalArgumentException e) {
                              // Handle invalid date format
                          }
                      }

              // Create a new project object
              project.setProjectName(projectName);
              project.setPhoneNumber(phoneNumber);
              project.setAddress(address);
              project.setCity(city);
              project.setEmailOrContactInformation(emailOrContactInformation);
              project.setInterconnectionStatus(interconnectionStatus);
              project.setProjectsStatus(projectsStatus);
              project.setWifiInformation(wifiInformation);
              project.setWifiNetwork(wifiNetwork);
              project.setWifiPassword(wifiPassword);
              project.setProjectNotes(projectNotes);
              project.setUserResponsible(userResponsible);
              project.setProjectsDescription(projectsDescription);
              project.setInstallDate(installDate);
              project.setProjectsOrganization(projectsOrganization);
              project.setSiteEvaluation(siteEvaluation);
              project.setProjectCreated(projectCreated);
              project.setMeterspotRequested(meterspotRequested);
              project.setLayoutDrafted(layoutDrafted);
              project.setPlansDrafted(plansDrafted);
              project.setSubmittedToPermitting(submittedToPermitting);
              project.setSalesNotes(salesNotes);
              project.setOtherAdders(otherAdders);
              project.setCompanyCamLink(companyCamLink);
              project.setUtilityCo(utilityCo);
              project.setSolarModules(solarModules);
              project.setInverters(inverters);
              project.setDcKw(dcKw);
              project.setSolarPanelQuantity(solarPanelQuantity);
              project.setInverterQuantity(inverterQuantity);
              project.setBattery(battery);
              project.setSgipRebate(sgipRebate);
              project.setSgipRebateType(sgipRebateType);
              project.setSgipRebateStatus(sgipRebateStatus);
              project.setMainPanelUpgrade(mainPanelUpgrade);
              project.setBreakerTypeNeeded(breakerTypeNeeded);
              project.setDownsizeNeeded(downsizeNeeded);
              project.setIsEv(isEv);
              project.setSubPanel(subPanel);
              project.setPanelDescription(panelDescription);
              project.setInspectionDate(inspectionDate);
              project.setInspectionPassed(inspectionPassed);
              project.setReinspectionDate(reinspectionDate);
              project.setPlacardStatus(placardStatus);
              project.setPlacardsInPossession(placardsInPossession);
              project.setAcDiscoPlacardsNeeded(acDiscoPlacardsNeeded);
              project.setInspectionTech(inspectionTech);
              project.setAccountingNotes(accountingNotes);
              project.setRoofingPrice(roofingPrice);
              project.setOtherAddersPrice(otherAddersPrice);
              project.setContractAmount(contractAmount);
              project.setCashPrice(cashPrice);
              project.setFinancingType(financingType);
              project.setM1Amount(m1Amount);
              project.setM1PaymentRequested(m1PaymentRequested);
              project.setPaymentReceivedM1(paymentReceivedM1);
              project.setM2Amount(m2Amount);
              project.setM2PaymentRequested(m2PaymentRequested);
              project.setPaymentReceivedM2(paymentReceivedM2);
              project.setIsSalesCommissionsPaid(isSalesCommissionsPaid);
              project.setActualCloseDate(actualCloseDate);
              project.setUsername(username);
              project.setUserEmail(useremail);
              project.setRecordId(Integer.parseInt(request.getParameter("project_id")));
              // Set more project properties as needed

              // Create a new ProjectDAO instance and save the project
              try {
                  projectDAO.updateProjectByUsernameAndId(project);
                  out.println("Project saved successfully!");
              } catch (Exception e) {
                  out.println("Error saving project: " + e.getMessage());
              }
          }
          project = projectDAO.getProjectsByUsernameandId(username, Integer.parseInt(request.getParameter("project_id")));
        %>
        <HR>
        <HR>
          <a href="<%=rootUpdate%>project.list.sec.jsp/" tabindex="2"><i class="fas fa-list"></i> Projects</a> |
            <a href="<%=rootUpdate%>project.list.dash.sec.jsp/" tabindex="2"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
        <HR>
          <div class="container mt-5">
            <div class="container">
                <div class="row">
                  <form action="<%= rootUpdate %>project.edit.sec.jsp/" method="post">
                    <input type="hidden"  id="project_id" name="project_id" value="<%= project.getRecordId() %>" >
                    <div class="form-group">
                      <label for="projectName">Project Name:</label>
                      <input type="text" class="form-control" id="projectName" name="projectName" required value="<%= project.getProjectName() %>">
                    </div>

                    <div class="form-group">
                      <label for="phoneNumber">Phone Number:</label>
                      <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" value="<%= project.getPhoneNumber() %>">
                    </div>

                    <div class="form-group">
                      <label for="address">Address:</label>
                      <input type="text" class="form-control" id="address" name="address" value="<%= project.getAddress() %>">
                    </div>

                    <div class="form-group">
                      <label for="city">City:</label>
                      <input type="text" class="form-control" id="city" name="city" value="<%= project.getCity() %>">
                    </div>

                    <div class="form-group">
                      <label for="emailOrContactInformation">Email or Contact Information:</label>
                      <input type="text" class="form-control" id="emailOrContactInformation" name="emailOrContactInformation" value="<%= project.getEmailOrContactInformation() %>">
                    </div>

                    <div class="form-group">
                      <label for="interconnectionStatus">Interconnection Status:</label>
                      <input type="text" class="form-control" id="interconnectionStatus" name="interconnectionStatus" value="<%= project.getInterconnectionStatus() %>">
                    </div>

                    <div class="form-group">
                      <label for="projectsStatus">Projects Status:</label>
                      <select id="projectsStatus" name="projectsStatus" class="form-control">
                        <option value="Plan Set Creation">Plan Set Creation</option>
                        <option value="Technical Review">Technical Review</option>
                        <option value="Ready for Permitting">Ready for Permitting</option>
                        <option value="Permitting">Permitting</option>
                        <option value="Plan Corrections">Plan Corrections</option>
                        <option value="Installation">Installation</option>
                        <option value="Punchlist Items">Punchlist Items</option>
                        <option value="Inspection">Inspection</option>
                        <option value="Inspection Corrections">Inspection Corrections</option>
                        <option value="PTO">PTO</option>
                        <option value="Configure Enlighten">Configure Enlighten</option>
                        <option value="Finished">Finished</option>
                      </select>
                    </div>
                    <script>
                    $(document).ready(function() {
                      var projectStatus = '<%= project.getProjectsStatus() %>'; // Assuming this returns the project status value

                      // Set the selected option based on the project status
                      $('#projectsStatus').val(projectStatus);
                    });
                    </script>
                    <div class="form-group">
                      <label for="wifiInformation">Wifi Information:</label>
                      <input type="text" class="form-control" id="wifiInformation" name="wifiInformation" value="<%= project.getWifiInformation() %>">
                    </div>

                    <div class="form-group">
                      <label for="wifiNetwork">Wifi Network:</label>
                      <input type="text" class="form-control" id="wifiNetwork" name="wifiNetwork" value="<%= project.getWifiNetwork() %>">
                    </div>

                    <div class="form-group">
                      <label for="wifiPassword">Wifi Password:</label>
                      <input type="text" class="form-control" id="wifiPassword" name="wifiPassword" value="<%= project.getWifiPassword() %>">
                    </div>

                    <div class="form-group">
                      <label for="projectNotes">Project Notes:</label>
                      <textarea class="form-control" id="projectNotes" name="projectNotes"><%= project.getProjectNotes() %></textarea>
                    </div>

                    <div class="form-group">
                      <label for="userResponsible">User Responsible:</label>
                      <input type="text" class="form-control" id="userResponsible" name="userResponsible" value="<%= project.getUserResponsible() %>">
                    </div>

                    <div class="form-group">
                      <label for="projectsDescription">Projects Description:</label>
                      <textarea class="form-control" id="projectsDescription" name="projectsDescription"><%=project.getProjectsDescription() %></textarea>
                        </div>
                        <div class="form-group">
                          <label for="installDate">Install Date:</label>
                          <input type="date" class="form-control" id="installDate" name="installDate" value="<%= project.getInstallDate() %>">
                        </div>
                        <div class="form-group">
                          <label for="projectsOrganization">Projects Organization:</label>
                          <input type="text" class="form-control" id="projectsOrganization" name="projectsOrganization" value="<%= project.getProjectsOrganization() %>">
                        </div>
                        <div class="form-group">
                          <label for="siteEvaluation">Site Evaluation:</label>
                          <input type="text" class="form-control" id="siteEvaluation" name="siteEvaluation" value="<%= project.getSiteEvaluation() %>">
                        </div>
                        <div class="form-group">
                          <label for="meterspotRequested">Meterspot Requested:</label>
                          <input type="text" class="form-control" id="meterspotRequested" name="meterspotRequested" value="<%= project.getMeterspotRequested() %>">
                        </div>
                        <div class="form-group">
                          <label for="layoutDrafted">Layout Drafted:</label>
                          <input type="text" class="form-control" id="layoutDrafted" name="layoutDrafted" value="<%= project.getLayoutDrafted() %>">
                        </div>
                        <div class="form-group">
                          <label for="plansDrafted">Plans Drafted:</label>
                          <input type="text" class="form-control" id="plansDrafted" name="plansDrafted" value="<%= project.getPlansDrafted() %>">
                        </div>
                        <div class="form-group">
                          <label for="submittedToPermitting">Submitted to Permitting:</label>
                          <input type="text" class="form-control" id="submittedToPermitting" name="submittedToPermitting" value="<%= project.getSubmittedToPermitting() %>">
                        </div>
                        <div class="form-group">
                          <label for="salesNotes">Sales Notes:</label>
                          <textarea class="form-control" id="salesNotes" name="salesNotes"><%= project.getSalesNotes() %></textarea>
                        </div>
                        <div class="form-group">
                          <label for="otherAdders">Other Adders:</label>
                          <input type="text" class="form-control" id="otherAdders" name="otherAdders" value="<%= project.getOtherAdders() %>">
                        </div>
                        <div class="form-group">
                          <label for="companyCamLink">Company Cam Link:</label>
                          <input type="text" class="form-control" id="companyCamLink" name="companyCamLink" value="<%= project.getCompanyCamLink() %>">
                        </div>
                        <div class="form-group">
                          <label for="utilityCo">Utility Co:</label>
                          <input type="text" class="form-control" id="utilityCo" name="utilityCo" value="<%= project.getUtilityCo() %>">
                        </div>
                        <div class="form-group">
                          <label for="solarModules">Solar Modules:</label>
                          <input type="text" class="form-control" id="solarModules" name="solarModules" value="<%= project.getSolarModules() %>">
                        </div>
                        <div class="form-group">
                          <label for="inverters">Inverters:</label>
<input type="text" class="form-control" id="inverters" name="inverters" value="<%= project.getInverters() %>">
  </div>
  <div class="form-group">
    <label for="dcKw">DC kW:</label>
    <input type="number" step="0.01" class="form-control" id="dcKw" name="dcKw" value="<%= project.getDcKw() %>">
  </div>
  <div class="form-group">
    <label for="solarPanelQuantity">Solar Panel Quantity:</label>
    <input type="number" class="form-control" id="solarPanelQuantity" name="solarPanelQuantity" value="<%= project.getSolarPanelQuantity() %>">
  </div>
  <div class="form-group">
    <label for="inverterQuantity">Inverter Quantity:</label>
    <input type="number" class="form-control" id="inverterQuantity" name="inverterQuantity" value="<%= project.getInverterQuantity() %>">
  </div>
  <div class="form-group">
    <label for="battery">Battery:</label>
    <input type="text" class="form-control" id="battery" name="battery" value="<%= project.getBattery() %>">
  </div>
  <div class="form-group">
    <label for="sgipRebate">SGIP Rebate:</label>
    <input type="number" step="0.01" class="form-control" id="sgipRebate" name="sgipRebate" value="<%= project.getSgipRebate() %>">
  </div>
  <div class="form-group">
    <label for="sgipRebateType">SGIP Rebate Type:</label>
    <input type="text" class="form-control" id="sgipRebateType" name="sgipRebateType" value="<%= project.getSgipRebateType() %>">
  </div>
  <div class="form-group">
    <label for="sgipRebateStatus">SGIP Rebate Status:</label>
    <input type="text" class="form-control" id="sgipRebateStatus" name="sgipRebateStatus" value="<%= project.getSgipRebateStatus() %>">
  </div>
  <div class="form-group">
    <label for="mainPanelUpgrade">Main Panel Upgrade:</label>
    <input type="text" class="form-control" id="mainPanelUpgrade" name="mainPanelUpgrade" value="<%= project.getMainPanelUpgrade() %>">
  </div>
  <div class="form-group">
    <label for="breakerTypeNeeded">Breaker Type Needed:</label>
    <input type="text" class="form-control" id="breakerTypeNeeded" name="breakerTypeNeeded" value="<%= project.getBreakerTypeNeeded() %>">
  </div>
  <div class="form-group">
    <label for="downsizeNeeded">Downsize Needed:</label>
    <input type="text" class="form-control" id="downsizeNeeded" name="downsizeNeeded" value="<%= project.getDownsizeNeeded() %>">
  </div>
  <div class="form-group">
    <label for="isEv">Is EV:</label>
    <input type="text" class="form-control" id="isEv" name="isEv" value="<%= project.getIsEv() %>">
  </div>
  <div classclass="form-group">
<label for="subPanel">Sub Panel:</label>
<input type="text" class="form-control" id="subPanel" name="subPanel" value="<%= project.getSubPanel() %>">
  </div>
  <div class="form-group">
    <label for="panelDescription">Panel Description:</label>
    <input type="text" class="form-control" id="panelDescription" name="panelDescription" value="<%= project.getPanelDescription() %>">
  </div>
  <div class="form-group">
    <label for="inspectionDate">Inspection Date:</label>
    <input type="date" class="form-control" id="inspectionDate" name="inspectionDate" value="<%= project.getInspectionDate() %>">
  </div>
  <div class="form-group">
    <label for="inspectionPassed">Inspection Passed:</label>
    <input type="text" class="form-control" id="inspectionPassed" name="inspectionPassed" value="<%= project.getInspectionPassed() %>">
  </div>
  <div class="form-group">
    <label for="reinspectionDate">Reinspection Date:</label>
    <input type="date" class="form-control" id="reinspectionDate" name="reinspectionDate" value="<%= project.getReinspectionDate() %>">
  </div>
  <div class="form-group">
    <label for="placardStatus">Placard Status:</label>
    <input type="text" class="form-control" id="placardStatus" name="placardStatus" value="<%= project.getPlacardStatus() %>">
  </div>
  <div class="form-group">
    <label for="placardsInPossession">Placards in Possession:</label>
    <input type="text" class="form-control" id="placardsInPossession" name="placardsInPossession" value="<%= project.getPlacardsInPossession() %>">
  </div>
  <div class="form-group">
    <label for="acDiscoPlacardsNeeded">AC Disco Placards Needed:</label>
    <input type="text" class="form-control" id="acDiscoPlacardsNeeded" name="acDiscoPlacardsNeeded" value="<%= project.getAcDiscoPlacardsNeeded() %>">
  </div>
  <div class="form-group">
    <label for="inspectionTech">Inspection Tech:</label>
    <input type="text" class="form-control" id="inspectionTech" name="inspectionTech" value="<%= project.getInspectionTech() %>">
  </div>
  <div class="form-group">
    <label for="accountingNotes">Accounting Notes:</label>
    <textarea class="form-control" id="accountingNotes" name="accountingNotes"><%= project.getAccountingNotes() %></textarea>
  </div>
  <div class="form-group">
    <label for="roofingPrice">Roofing Price:</label>
    <input type="number" step="0.01" class="form-control" id="roofingPrice" name="roofingPrice" value="<%= project.getRoofingPrice() %>">
  </div>
  <div class="form-group">
    <label for="otherAddersPrice">Other Adders Price:</label>
    <input type="number" step="0.01" class="form-control" id="otherAddersPrice" name="otherAddersPrice" value="<%= project.getOtherAddersPrice() %>">
  </div>
  <div class="form-group">
    <label for="contractAmount">Contract Amount:</label>
    <input type="number" step="0.01" class="form-control" id="contractAmount" name="contractAmount" value="<%= project.getContractAmount() %>">
  </div>
  <div class="form-group">
    <label for="cashPrice">Cash Price:</label>
    <input type="number" step="0.01" class="form-control" id="cashPrice" name="cashPrice" value="<%= project.getCashPrice() %>">
  </div>
  <div class="form-group">
    <label for="financingType">Financing Type:</label>
    <input type="text" class="form-control" id="financingType" name="financingType" value="<%= project.getFinancingType() %>">
  </div>
  <div class="form-group">
    <label for="m1Amount">M1 Amount:</label>
    <input type="number" step="0.01" class="form-control" id="m1Amount" name="m1Amount" value="<%= project.getM1Amount() %>">
  </div>
  <div class="form-group">
    <label for="m1PaymentRequested">M1 Payment Requested:</label>
    <input type="number" step="0.01" class="form-control" id="m1PaymentRequested" name="m1PaymentRequested" value="<%= project.getM1PaymentRequested() %>">
  </div>
  <div class="form-group">
    <label for="paymentReceivedM1">Payment Received M1:</label>
    <input type="number" step="0.01" class="form-control" id="paymentReceivedM1" name="paymentReceivedM1" value="<%= project.getPaymentReceivedM1() %>">
  </div>
  <div class="form-group">
    <label for="m2Amount">M2 Amount:</label>
    <input type="number" step="0.01" class="form-control" id="m2Amount" name="m2Amount" value="<%= project.getM2Amount() %>">
  </div>
  <div class="form-group">
    <label for="m2PaymentRequested">M2 Payment Requested:</label>
    <input type="number" step="0.01" class="form-control" id="m2PaymentRequested" name="m2PaymentRequested" value="<%= project.getM2PaymentRequested() %>">
  </div>
  <div class="form-group">
    <label for="paymentReceivedM2">Payment Received M2:</label>
    <input type="number" step="0.01" class="form-control" id="paymentReceivedM2" name="paymentReceivedM2" value="<%= project.getPaymentReceivedM2() %>">
  </div>
  <div class="form-group">
    <label for="isSalesCommissionsPaid">Is Sales Commissions Paid:</label>
    <input type="text" class="form-control" id="isSalesCommissionsPaid" name="isSalesCommissionsPaid" value="<%= project.getIsSalesCommissionsPaid() %>">
  </div>

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
