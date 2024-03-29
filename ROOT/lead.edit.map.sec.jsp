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

    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDHwbVpNgh3G5yG1cmT0HMe8TikX4DC2qE&libraries=places"></script>
    <style>
      #map-container-img {
        width: 640px;
        height: 640px;
      }
    </style>
  </head>
<body>
  <main id="main">
    <section id="blog" class="blog">
      <div class="container px-4 px-lg-5">
          <div class="container mt-5">
            <h2><a href="<%=rootUpdate%>user.menu.sec.jsp/" tabindex="1" >Home Renovation Nation</a></h2>
            <HR>
        <h2>Lead <a href="<%=rootUpdate%>lead.edit.sec.jsp/?lead_id=<%=request.getParameter("lead_id")%>" tabindex="2"><%=request.getParameter("lead_id")%></a></h2>
        <HR>

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
          <a href="<%=rootUpdate%>lead.new.sec.jsp/" class="btn btn-primary mt-3" tabindex="2"><i class="fas fa-plus"></i></a>
          <a href="<%=rootUpdate%>lead.new.bulk.sec.jsp/" class="btn btn-primary mt-3" tabindex="2"><i class="fas fa-cubes"></i></a>
          <a href="<%=rootUpdate%>lead.list.sec.jsp/" class="btn btn-primary mt-3" tabindex="3"><i class="fas fa-list"></i></a>
          <a href="<%=rootUpdate%>lead.list.table.sec.jsp/" class="btn btn-primary mt-3" tabindex="4"><i class="fas fa-table"></i></a>
          <a href="<%=rootUpdate%>lead.list.dash.sec.jsp/" class="btn btn-primary mt-3" tabindex="5"><i class="fas fa-tachometer-alt"></i></a>
          <a href="<%=rootUpdate%>lead.list.csv.sec.jsp/?csv=true" class="btn btn-primary mt-3" tabindex="6"><i class="fas fa-download"></i></a>
          <a href="<%=rootUpdate%>lead.new.bulk.sec.jsp/?csv=true" class="btn btn-primary mt-3" tabindex="7"><i class="fas fa-upload"></i></a>
          <a href="<%=rootUpdate%>lead.edit.images.sec.jsp/?lead_id=<%=lead.getRecordId()%>" class="btn btn-primary mt-3" tabindex="8"><i class="fas fa-image"></i></a>
          <a href="<%=rootUpdate%>lead.edit.com.sec.jsp/?lead_id=<%=lead.getRecordId()%>" class="btn btn-primary mt-3" tabindex="8"><i class="fas fa-envelope"></i></a>
          <a href="<%=rootUpdate%>lead.edit.map.sec.jsp/?lead_id=<%=lead.getRecordId()%>" class="btn btn-success mt-3" tabindex="9"><i class="fas fa-map"></a>
          <a href="https://sunroof.withgoogle.com/building/<%= lead.getLocation_pointlat() %>/<%= lead.getLocation_pointlng() %>/#?f=buy" tabindex="2" class="btn btn-primary mt-3" target="_blank" ><i class="fas fa-sun"></a>
        <HR>
          <div class="container mt-5">
            <div class="container">
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


                <BR>

                      <div id="map-container" style="">
                        <img id="map-container-img" />
                    </div>
                </form>

            </div>
          </div>
        </div>
      </div>
    </section><!-- End Blog Section -->
  </main>

  <script>
  // Replace 'YOUR_API_KEY' with your own Google Maps API key
  window.onload = initMap();


  // Function to initialize and load the map image
  function initMap() {

    console.log('Initializing map...');
    const address = '<%=lead.getAddress()%>';

    // Create a new instance of the Geocoder
    const geocoder = new google.maps.Geocoder();

    // Convert the address to geographic coordinates
    geocoder.geocode({ address: address }, (results, status) => {
      if (status === 'OK' && results.length > 0) {
        // Get the latitude and longitude of the address
        console.log('Geocode status:', status);
        console.log('Geocode results:', results);

        const lat = results[0].geometry.location.lat();
        const lng = results[0].geometry.location.lng();


        console.log('Latitude:', lat);
        console.log('Longitude:', lng);

            console.log('Initializing map... LAT');
        // Build the map URL with the satellite map type
        const mapUrl = 'https://maps.googleapis.com/maps/api/staticmap?center=' + lat + ',' + lng + '&zoom=21&size=640x640&maptype=satellite&key=AIzaSyDHwbVpNgh3G5yG1cmT0HMe8TikX4DC2qE';
        console.log(mapUrl);
        // Set the background image of the map container div
        const imgElement = document.getElementById('map-container-img');
        imgElement.src = mapUrl;

        // Append the <img> element to the map container div
        const mapContainer = document.getElementById('map-container');
        mapContainer.innerHTML = '';
        mapContainer.appendChild(imgElement);
      } else {
        console.error('Geocode was not successful for the following reason: ' + status);
      }
    });
  }




  </script>
  <script>
  // Variables to store click positions
  let firstClick = null;
  let secondClick = null;

  const image = document.getElementById('map-container-img');
  const container = document.getElementById('map-container');
  // Event listener for the first click
  let fencePoints = []; // Array to store fence points
  let area = 0; // Variable to store calculated area

  document.getElementById("map-container-img").addEventListener("click", function(event) {
    const clickPosition = { x: event.clientX, y: event.clientY };
    console.log("Click position:", clickPosition);

    // Store the click position as a fence point
    fencePoints.push(clickPosition);

    if (fencePoints.length > 1) {
      const firstPoint = fencePoints[0];
      const lastPoint = fencePoints[fencePoints.length - 1];
      const secondToLastPoint = fencePoints[fencePoints.length - 2];

      // Calculate distance between first and last fence points
      const distanceX = Math.abs(lastPoint.x - firstPoint.x);
      const distanceY = Math.abs(lastPoint.y - firstPoint.y);
      const distanceFirstToLast = Math.sqrt(Math.pow(distanceX, 2) + Math.pow(distanceY, 2));
      console.log("Distance between first and last points:", distanceFirstToLast);

      // Calculate distance between last and second-to-last fence points
      const distanceX2 = Math.abs(secondToLastPoint.x - lastPoint.x);
      const distanceY2 = Math.abs(secondToLastPoint.y - lastPoint.y);
      const distanceLastToSecondToLast = Math.sqrt(Math.pow(distanceX2, 2) + Math.pow(distanceY2, 2));
      console.log("Distance between last and second-to-last points:", distanceLastToSecondToLast);

      // Calculate the total distance
      const distance = distanceFirstToLast * 0.22;
      alert("Distance From First Point to Last Point: " + Math.round(distanceFirstToLast * 0.22) + " ft");
      alert("Distance From Last Point to Second-to-Last Point: " + Math.round(distanceLastToSecondToLast * 0.22) + " ft");


      if (distance < 10 || fencePoints.length > 2 && isClosed(fencePoints)) {
        // Fence is closed, calculate area using Shoelace formula
        area = calculateArea(fencePoints);
        console.log("Fence is closed. Area:", area);
        alert("Area " + area * 0.018);

        // Reset fence points and area for future calculations
        fencePoints = [];
        area = 0;
      }
    }
    markClick(event); // Assuming you have a function called markClick to handle displaying the click visually
  });

  function isClosed(points) {
    const firstPoint = points[0];
    const lastPoint = points[points.length - 1];

    // Calculate distance between last fence point and first fence point
    const distanceX = Math.abs(lastPoint.x - firstPoint.x);
    const distanceY = Math.abs(lastPoint.y - firstPoint.y);
    const distance = Math.sqrt(Math.pow(distanceX, 2) + Math.pow(distanceY, 2));

    return distance < 10;
  }

  function calculateArea(points) {
    let sum = 0;
    const numPoints = points.length;

    for (let i = 0; i < numPoints; i++) {
      const currentPoint = points[i];
      const nextPoint = points[(i + 1) % numPoints]; // Wrap around to the first point for the last iteration

      sum += (currentPoint.x * nextPoint.y) - (nextPoint.x * currentPoint.y);
    }

    return Math.abs(sum) / 2;
  }






  // Function to handle click event
  function markClick(event) {
    // Get the position of the click relative to the image
    const rect = image.getBoundingClientRect();
    const x = event.clientX - rect.left;
    const y = event.clientY - rect.top;

    // Create a marker element
    const marker = document.createElement('div');
    marker.className = 'click-marker';
    marker.style.left = x + 'px';
    marker.style.top = y + 'px';

    // Append the marker to the container
    container.appendChild(marker);
  }

  // Define CSS styles using a <style> tag
  const styleTag = document.createElement('style');
  styleTag.innerHTML = `
    #map-container {
      position: relative;
    }

    .click-marker {
      position: absolute;
      width: 10px;
      height: 10px;
      background-color: red;
      border-radius: 50%;
    }
  `;

  // Append the <style> tag to the document's head
  document.head.appendChild(styleTag);
</script>
</body>
</html>
