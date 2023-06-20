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
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="javax.servlet.http.Part" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.FileItem" %>
<%@ page import="com.tfnlab.api.con.GoogleAutocomplete" %>
<%@ page import="com.tfnlab.api.con.GeocodingExample" %>
<%@ page import="org.apache.commons.csv.CSVFormat" %>
<%@ page import="org.apache.commons.csv.CSVParser" %>
<%@ page import="org.apache.commons.csv.CSVRecord" %>
<%@ page import="java.util.Iterator" %>
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
        boolean isMultipart = ServletFileUpload.isMultipartContent(request);
        if (isMultipart) {


            SimpleDateFormat dateFormat = new SimpleDateFormat("M/d/yyyy hh:mm:ss a");
            SimpleDateFormat datedFormat = new SimpleDateFormat("M/d/yyyy");

            UUID uuid = UUID.randomUUID();
            APIConfig conf = new APIConfig();
            String filename = "project.bulk." + username + "." + uuid + ".csv";
            String filepath = conf.getPdfloc();
            DiskFileItemFactory factory = new DiskFileItemFactory();
            factory.setSizeThreshold(1024 * 1024); // Set the size threshold for storing files in memory
            factory.setRepository(new File(filepath)); // Set the repository location for temporarily storing files
            ServletFileUpload upload = new ServletFileUpload(factory);
            List<FileItem> items = upload.parseRequest(request);
            for (FileItem item : items) {
              if (!item.isFormField()) { // Check if the item is an uploaded file
                InputStream fileContent = item.getInputStream(); // Get an InputStream for reading the file contents
                FileOutputStream fos = new FileOutputStream(filepath   + filename);
                byte[] buffer = new byte[1024];
                int length;
                while ((length = fileContent.read(buffer)) > 0) {
                  fos.write(buffer, 0, length);
                }
                fos.close();
                fileContent.close();
              }
            }


            try {
              BufferedReader reader = new BufferedReader(new FileReader(filepath   + filename));
              String line;
              int lineNumber = 0;
              CSVParser csvParser = new CSVParser(reader, CSVFormat.DEFAULT);
              Iterator<CSVRecord> iterator = csvParser.iterator();
              if (iterator.hasNext()) {
                  iterator.next(); // Skip the first record
              }
              while (iterator.hasNext()) {
                                        CSVRecord csvRecord = iterator.next();
              // Retrieve form data
              String external_id = csvRecord.get(0);
              String projectName = csvRecord.get(1);
              String phoneNumber = csvRecord.get(25);
              String address = csvRecord.get(24);
              String city = "";
              String emailOrContactInformation = csvRecord.get(79);
              String interconnectionStatus = csvRecord.get(84);
              String projectsStatus =  csvRecord.get(2);
              String wifiInformation = csvRecord.get(62);
              String wifiNetwork = "";
              String wifiPassword = "";
              String projectNotes = csvRecord.get(59);
              String userResponsible = csvRecord.get(9);
              String projectsDescription = csvRecord.get(44);
              java.sql.Date installDate = null;
              String installDateParam = csvRecord.get(56);
              if (installDateParam != null && !installDateParam.isBlank()) {
                  try {
                      installDate = new java.sql.Date(datedFormat.parse(installDateParam).getTime());
                  } catch (IllegalArgumentException e) {
                      // Handle invalid date format
                  }
              }
              String projectsOrganization = csvRecord.get(57);
              String siteEvaluation = csvRecord.get(50);

              java.sql.Date projectCreated = new java.sql.Date(datedFormat.parse(csvRecord.get(10)).getTime());
              String meterspotRequested = csvRecord.get(64);
              String layoutDrafted = csvRecord.get(66);
              String plansDrafted = csvRecord.get(65);
              String submittedToPermitting = csvRecord.get(67);
              String salesNotes = csvRecord.get(52);
              String otherAdders = "";
              String companyCamLink = csvRecord.get(41);
              String utilityCo = csvRecord.get(49);
              String solarModules = csvRecord.get(37);
              String inverters = csvRecord.get(54);
              double dcKw = 0.0;
              String dcKwParam = csvRecord.get(29);
              if (dcKwParam != null && !dcKwParam.isBlank()) {
                  try {
                      dcKw = Double.parseDouble(dcKwParam);
                  } catch (NumberFormatException e) {
                      // Handle invalid double format
                  }
              }
              int solarPanelQuantity = 0;
              String solarPanelQuantityParam = csvRecord.get(28);
              if (solarPanelQuantityParam != null && !solarPanelQuantityParam.isBlank()) {
                  try {
                      solarPanelQuantity = Integer.parseInt(solarPanelQuantityParam);
                  } catch (NumberFormatException e) {
                      // Handle invalid integer format
                  }
              }
              int inverterQuantity = 0;
              String inverterQuantityParam = csvRecord.get(30);
              if (inverterQuantityParam != null && !inverterQuantityParam.isBlank()) {
                  try {
                      inverterQuantity = Integer.parseInt(inverterQuantityParam);
                  } catch (NumberFormatException e) {
                      // Handle invalid integer format
                  }
              }
              String battery = csvRecord.get(42);
              double sgipRebate = 0.0;

              String sgipRebateParam = "";
              String sgipRebateType = csvRecord.get(58);
              String sgipRebateStatus = csvRecord.get(45);
              String mainPanelUpgrade = csvRecord.get(36);
              String breakerTypeNeeded = csvRecord.get(63);
              String downsizeNeeded = csvRecord.get(39);
              String isEv = csvRecord.get(35);
              String subPanel = csvRecord.get(38);
              String panelDescription = csvRecord.get(44);
              java.sql.Date inspectionDate = null;
              String inspectionDateParam =  csvRecord.get(74);
              if (inspectionDateParam != null && !inspectionDateParam.isBlank()) {
                  try {
                      inspectionDate = new java.sql.Date(dateFormat.parse(inspectionDateParam).getTime());
                  } catch (IllegalArgumentException e) {
                      // Handle invalid date format
                  }
              }
              String inspectionPassed = csvRecord.get(81);
              java.sql.Date inspectionPassedDate = null;
              String inspectionPassedDateParam = "";
              if (inspectionPassedDateParam != null && !inspectionDateParam.isBlank()) {
                  try {
                      inspectionPassedDate = new java.sql.Date(dateFormat.parse(inspectionPassedDateParam).getTime());
                  } catch (IllegalArgumentException e) {
                      // Handle invalid date format
                  }
              }
              java.sql.Date reinspectionDate = null;
              String reinspectionDateParam = csvRecord.get(82);
              if (reinspectionDateParam != null && !reinspectionDateParam.isBlank()) {
                  try {
                      reinspectionDate = new java.sql.Date(dateFormat.parse(reinspectionDateParam).getTime());
                  } catch (IllegalArgumentException e) {
                      // Handle invalid date format
                  }
              }
              String placardStatus = csvRecord.get(75);
              String placardsInPossession = csvRecord.get(75);
              String acDiscoPlacardsNeeded = csvRecord.get(76);
              String inspectionTech = csvRecord.get(80);
              String accountingNotes = csvRecord.get(55);
              double roofingPrice = 0.0;
              String roofingPriceParam = csvRecord.get(77);
              if (roofingPriceParam != null && !roofingPriceParam.isBlank()) {
                  try {
                      roofingPrice = Double.parseDouble(roofingPriceParam);
                  } catch (NumberFormatException e) {
                      // Handle invalid double format
                  }
              }
              double otherAddersPrice = 0.0;
              String otherAddersPriceParam =  csvRecord.get(60);
              if (otherAddersPriceParam != null && !otherAddersPriceParam.isBlank()) {
                  try {
                      otherAddersPrice = Double.parseDouble(otherAddersPriceParam);
                  } catch (NumberFormatException e) {
                      // Handle invalid double format
                  }
              }
              double contractAmount = 0.0;
              String contractAmountParam = csvRecord.get(27);
              if (contractAmountParam != null && !contractAmountParam.isBlank()) {
                  try {
                      contractAmount = Double.parseDouble(contractAmountParam);
                  } catch (NumberFormatException e) {
                      // Handle invalid double format
                  }
              }
              double cashPrice = 0.0;
              String cashPriceParam =  csvRecord.get(47);
              if (cashPriceParam != null && !cashPriceParam.isBlank()) {
                  try {
                      cashPrice = Double.parseDouble(cashPriceParam);
                  } catch (NumberFormatException e) {
                      // Handle invalid double format
                  }
              }
              String financingType =  csvRecord.get(53);
              double m1Amount = 0.0;
              String m1AmountParam = csvRecord.get(72);
              if (m1AmountParam != null && !m1AmountParam.isBlank()) {
                  try {
                      m1Amount = Double.parseDouble(m1AmountParam);
                  } catch (NumberFormatException e) {
                      // Handle invalid double format
                  }
              }
              double m1PaymentRequested = 0.0;
              String m1PaymentRequestedParam = csvRecord.get(68);
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
              Project project = new Project();
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
              project.setInspectionPassedDate(inspectionPassedDate);
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
              project.setExternal_id(external_id);

              // Set more project properties as needed

              // Create a new ProjectDAO instance and save the project
              ProjectDAO projectDAO = new ProjectDAO();
              try {
                  projectDAO.insertProject(project);
              } catch (Exception e) {
                  out.println("Error saving project: " + e.getMessage());
              }
            }
        reader.close();
      } catch (Exception e) {
        e.printStackTrace();
        %><%=e.getMessage()%><%
      }
          }
        %>
        <HR>
          <a href="<%=rootUpdate%>project.list.sec.jsp/" tabindex="2"><i class="fas fa-list"></i> Projects</a> |
            <a href="<%=rootUpdate%>project.list.dash.sec.jsp/" tabindex="2"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
        <HR>
          <div class="container mt-5">
            <div class="container">
                <div class="row">
                  <form method="post" action="<%=rootUpdate%>project.new.bulk.sec.jsp/" enctype="multipart/form-data">
                    <input type="file" name="file" />
                    <input type="submit" value="Upload" />
                  </form>
                  <HR>
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
