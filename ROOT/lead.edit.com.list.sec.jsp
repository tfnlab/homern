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
<%@ page import="com.tfnlab.mysql.LeadCorrespondenceDAO" %>
<%@ page import="com.tfnlab.mysql.LeadCorrespondence" %>
<%@ include file="auth.sec.jsp" %>
<!DOCTYPE html>
<html lang="en">
  <%
     int recordId = Integer.parseInt(request.getParameter("lead_id"));
  %>
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
    <script >
    function getMessage(event) {
      event.preventDefault();
      var xhttp = new XMLHttpRequest();
      xhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
          document.getElementById("orderCom").value = this.responseText.trim();
          // Set textarea color or border based on success
            document.getElementById("orderCom").style.backgroundColor = "#FFFFFF"; // Set background color to green
            document.getElementById("orderCom").style.borderColor = "#5CE1E6"; // Set border color to green
        }
      };
      document.getElementById("orderCom").style.backgroundColor = "#5CE1E6"; // Set background color to warning color
      document.getElementById("orderCom").style.borderColor = "#0097B2"; // Set border color to warning color
      var select = document.getElementById("leadStatus");
      var selectedOption = select.options[select.selectedIndex];
      var text = selectedOption.text;
      const encodedString = encodeURIComponent(text);
      var urlString = "<%=rootUpdate%>genmessage.lead.sec.jsp/?lead_id=" + document.getElementById("lead_id").value + "&comType=" + encodedString;
      xhttp.open("GET", urlString, true);
      xhttp.send();
    }

    </script>
  </head>
<body>
  <main id="main">
    <section id="blog" class="blog">
      <div class="container px-4 px-lg-5">
          <div class="container mt-5">
            <h2><a href="<%=rootUpdate%>user.menu.sec.jsp/" tabindex="1" >Home Renovation Nation</a></h2>
            <HR>
        <h2>Lead <a href="<%=rootUpdate%>lead.edit.sec.jsp/?lead_id=<%=recordId%>" tabindex="2"><%=recordId%></a></h2>
        <HR>
          <%

              LeadCorrespondenceDAO cdao = new LeadCorrespondenceDAO();


              List<LeadCorrespondence> correspondences = null;
              correspondences = cdao.getCorrespondenceByUsername(username);
          %>
          <a href="<%=rootUpdate%>lead.new.sec.jsp/" class="btn btn-primary mt-3" tabindex="2" ><i class="fas fa-plus" ></i></a>
          <a href="<%=rootUpdate%>lead.new.bulk.sec.jsp/" class="btn btn-primary mt-3" tabindex="2"><i class="fas fa-cubes"></i></a>
          <a href="<%=rootUpdate%>lead.list.sec.jsp/" class="btn btn-primary mt-3" tabindex="3"><i class="fas fa-list"></i></a>
          <a href="<%=rootUpdate%>lead.list.table.sec.jsp/" class="btn btn-primary mt-3" tabindex="4"><i class="fas fa-table"></i></a>
          <a href="<%=rootUpdate%>lead.list.dash.sec.jsp/" class="btn btn-primary mt-3" tabindex="5"><i class="fas fa-tachometer-alt"></i></a>
          <a href="<%=rootUpdate%>lead.list.csv.sec.jsp/?csv=true" class="btn btn-primary mt-3" tabindex="6"><i class="fas fa-download"></i></a>
          <a href="<%=rootUpdate%>lead.new.bulk.sec.jsp/?csv=true" class="btn btn-primary mt-3" tabindex="7"><i class="fas fa-upload"></i></a>
          <a href="<%=rootUpdate%>lead.edit.images.sec.jsp/?lead_id=<%=lead.getRecordId()%>" class="btn btn-primary mt-3" tabindex="8"><i class="fas fa-image"></i></a>
          <a href="<%=rootUpdate%>lead.edit.com.sec.jsp/?lead_id=<%=lead.getRecordId()%>" class="btn btn-success mt-3" tabindex="8"><i class="fas fa-envelope"></i></a>
          <a href="<%=rootUpdate%>lead.edit.map.sec.jsp/?lead_id=<%=lead.getRecordId()%>" class="btn btn-primary mt-3" tabindex="9"><i class="fas fa-map"></a>
          <a href="https://sunroof.withgoogle.com/building/<%= lead.getLocation_pointlat() %>/<%= lead.getLocation_pointlng() %>/#?f=buy" tabindex="2" class="btn btn-primary mt-3" target="_blank" ><i class="fas fa-sun"></a>
        <HR>
          <div id="orderComRes"  name="orderComRes" ></div>
          <div class="container mt-5">
            <div class="container">

                  <% for (LeadCorrespondence correspondence : correspondences) { %>
                      <div class="card my-2">
                          <div class="card-body">
                              <h5 class="card-title">ID: <%= correspondence.getCorrespondenceId() %></h5>
                              <h6 class="card-subtitle mb-2 text-muted">User Email: <%= correspondence.getUseremail() %></h6>
                              <p class="card-text">Correspondence Type: <%= correspondence.getCorrespondenceType() %></p>
                              <p class="card-text">Message: <%= correspondence.getMessage() %></p>
                              <p class="card-text">Date Created: <%= correspondence.getDateCreated() %></p>
                          </div>
                      </div>
                  <% } %>
              <HR>
              <BR><BR>
            </div>
          </div>
        </div>
      </div>
    </section><!-- End Blog Section -->
  </main>
  <script>
  function sendSMS() {
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function() {
      if (this.readyState == 4 && this.status == 200) {
        alert(this.responseText);
        document.getElementById("orderComRes").innerHTML = this.responseText.trim();
        //          document.getElementById("orderCom").innerHTML = this.responseText.trim();
      }
    };
    var lId = <%=recordId%>;
    var text = document.getElementById("orderCom").value;
    const encodedString = encodeURIComponent(text);

    var select = document.getElementById("leadStatus");
    var selectedOption = select.options[select.selectedIndex];
    var com = selectedOption.text;
    const encodedStringsub = encodeURIComponent(com);


    var urlString = "<%=rootUpdate%>customer.edit.com.sms.sec.jsp/?lead_id=" + lId + "&com=" + encodedString + "&sub=" + encodedStringsub ;
//      alert(urlString);
    xhttp.open("GET", urlString, true);
    xhttp.send();
  }

      function sendEmail() {
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function() {
          if (this.readyState == 4 && this.status == 200) {
            alert(this.responseText);
          }
        };
        var lId = <%=recordId%>;
        var text = document.getElementById("orderCom").value;
        const encodedString = encodeURIComponent(text);
        var select = document.getElementById("leadStatus");
        var selectedOption = select.options[select.selectedIndex];
        var com = selectedOption.text;
        const encodedStringsub = encodeURIComponent(com);
        var urlString = "<%=rootUpdate%>customer.edit.com.email.sec.jsp/?lead_id=" + lId + "&com=" + encodedString + "&sub=" + encodedStringsub ;
        xhttp.open("GET", urlString, true);
        xhttp.send();
      }
  </script>
</body>
</html>
