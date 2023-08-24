<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.tfnlab.mysql.User"%>
<%@ page import="com.tfnlab.mysql.UserDao" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.hrn.mysql.Order" %>
<%@ page import="com.hrn.mysql.OrderDao" %>
<%@ page import="com.hrn.mysql.Entity" %>
<%@ page import="com.hrn.mysql.EntityDao" %>
<%@ page import="java.net.URLDecoder" %>
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

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <%
      String eId = "";
      if (request.getParameter("customerId") != null && !request.getParameter("customerId").isEmpty()) {
        eId = request.getParameter("customerId");
      }

    String comType = request.getParameter("comType");

  %>
  <script>
    function callGeo(sk, fNameLink) {
        document.getElementById(fNameLink.substring(0,fNameLink.length-2)).value = sk;
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function() {
          if (this.readyState == 4 && this.status == 200) {
            let items = this.responseText.split('<ITEM>');
            fNamenew = items[items.length-1];
            fNamenew = removeTrailingSpaces(fNamenew);
            document.getElementById(fNamenew+"lat").value = items[0];
            document.getElementById(fNamenew+"lng").value = items[1];


          }
        };

        const encodedString = encodeURIComponent(sk);
        var urlString = "GeocodingExample.jsp?search=" + encodedString + "&sfor=" + fNameLink;
        xhttp.open("GET", urlString, true);
        xhttp.send();
    }

    function removeTrailingSpaces(str) {
            return str.replace(/\s+$/g, "");
    }
    function getMessage() {
      //genmessage.jsp?comType=latepaymentrequest
      var xhttp = new XMLHttpRequest();
      xhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {

          document.getElementById("orderCom").innerHTML = this.responseText.trim();
        }
      };
      var select = document.getElementById("touchPoints");
      var selectedOption = select.options[select.selectedIndex];
      var text = selectedOption.text;
      const encodedString = encodeURIComponent(text);
      var urlString = "<%=rootUpdate%>genmessage.sec.d.jsp/?customerId=" + document.getElementById("customerId").value + "&comType=" + encodedString ;
      xhttp.open("GET", urlString, true);
      xhttp.send();
    }
    function callAC(sfor) {
      var xhttp = new XMLHttpRequest();
      xhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
          let items = this.responseText.split('<ITEM>');
          fName = items[items.length-1];
          fName = removeTrailingSpaces(fName);
          for (let i = 0; i < items.length-1; i++) {
            if (items[i].length > 5) {
              let newL = "<li>" + "<a href=\"javascript:void(0)\" onclick=\"callGeo('" + items[i] +"' , '" + fName+ "')\" >" + items[i] + "</a>" + "</li>";
              document.getElementById(fName).innerHTML = document.getElementById(fName).innerHTML  + newL;
            }
          }
        }
      };
      let elName = sfor.name + "ac";
      let search = document.getElementById(sfor.name).value;

      if (search.length > 5) {
        document.getElementById(elName).innerHTML = "";
        var urlString = "GoogleAutocomplete.jsp?search=" + search + "&sfor=" + sfor.name;
        xhttp.open("GET", urlString, true);
        xhttp.send();
      }
    }
    function getCom() {
      var select = document.getElementById("touchPoints");
      var selectedOption = select.options[select.selectedIndex];
      var com = selectedOption.value;
      var eId = '<%=eId%>';
      var url = "<%=rootUpdate%>customer.edit.com.sec.d.jsp/?customerId=" + eId +  "&comType=" + com;
      window.open(url, "_self");
    }
    function sendMail() {
      var xhttp = new XMLHttpRequest();
      xhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
          alert(this.responseText);
          // document.getElementById("orderCom").innerHTML = this.responseText.trim();
        }
      };
      var eId = '<%=eId%>';
      var text = document.getElementById("orderCom").innerHTML;
      const encodedString = encodeURIComponent(text);

      var select = document.getElementById("touchPoints");
      var selectedOption = select.options[select.selectedIndex];
      var com = selectedOption.text;
      const encodedStringsub = encodeURIComponent(com);


      var urlString = "<%=rootUpdate%>customer.edit.com.email.sec.d.jsp/?customerId=" + eId + "&com=" + encodedString + "&sub=" + encodedStringsub ;
//      alert(urlString);
      xhttp.open("GET", urlString, true);
      xhttp.send();
    }

    function getPayments(){
        var eId = '<%=eId%>';
        var url = "<%=rootUpdate%>customer.edit.payments.sec.d.jsp/?customerId=" + eId ;
        window.open(url, "_self");
    }
    function getOrders() {
      var eId = '<%=eId%>';
      var url = "<%=rootUpdate%>customer.edit.orders.sec.d.jsp/?customerId=" + eId;
      window.open(url, "_self");
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
          <%
          if (comType != null) {
          %>
            <div class="form-group">
              <label for="touchPoints">Choose a touch point:</label>
              <select class="form-control" id="touchPoints">
                <option value="initialConsultation" <%= comType.equals("initialConsultation") ? "selected" : "" %>>Initial consultation</option>
                <option value="needsAssessment" <%= comType.equals("needsAssessment") ? "selected" : "" %>>Needs Assessment</option>
                <option value="contractSigning" <%= comType.equals("contractSigning") ? "selected" : "" %>>Contract signing</option>
                <option value="preConstructionMeeting" <%= comType.equals("preConstructionMeeting") ? "selected" : "" %>>Pre-construction meeting</option>
                <option value="onSiteVisits" <%= comType.equals("onSiteVisits") ? "selected" : "" %>>On-site visits</option>
                <option value="maintenanceduereminder" <%= comType.equals("maintenanceduereminder") ? "selected" : "" %>>Maintenance Due Reminder</option>

                <option value="progressUpdates" <%= comType.equals("progressUpdates") ? "selected" : "" %>>Progress updates</option>
                <option value="finalWalkThrough" <%= comType.equals("finalWalkThrough") ? "selected" : "" %>>Final walk-through</option>
                <option value="warrantyAndMaintenance" <%= comType.equals("warrantyAndMaintenance") ? "selected" : "" %>>Warranty and maintenance</option>
                <option value="1">Scheduling regular maintenance appointments</option>
                <option value="2">Sending email reminders before appointments</option>
                <option value="3">Text message reminders</option>
                <option value="4">Phone call reminders</option>
                <option value="5">Post-maintenance follow-up</option>
                <option value="6">Maintenance reminders in customer account portal</option>
                <option value="7">In-app notifications</option>
                <option value="8">Customer satisfaction surveys after maintenance</option>
                <option value="9">Including maintenance reminders in product manuals/guides</option>
                <option value="10">Providing preventative maintenance tips and information</option>
                <option value="10">Energy Audit</option>
                <option value="10">Testing</option>
                <option value="10">Report</option>
              </select>

            </div>
          <%
          }
          %>

        <HR>
        <button class="btn btn-primary" onclick="getCom()">Correspondence</button>
        <button class="btn btn-primary" onclick="getPayments()">Payments</button>
        <button class="btn btn-primary" onclick="getOrders()">Orders</button>

        <HR>

          <%

          Entity entity = new Entity();
          EntityDao ed = new EntityDao();


            entity = ed.getEntityById(eId, username);

          %>
                    <div class="form-group">
                        <a href="<%=rootUpdate%>customer.edit.sec.d.jsp/?customerId=<%= entity.getId() %>" ><%= entity.getFirstName() %></a><br>
                    </div>
        <HR>
          <a href="javascript:void(0)" onclick="getMessage()">Generate Message</a>
          <HR>

        <!-- ======= Contact Section ======= -->

        <form action="<%=rootUpdate%>customer.edit.com.print.sec.jsp/" method="POST" target="_blank" >
          <input type="hidden" id="customerId" name="customerId" value="<%= entity.getId() %>" >
          <label for="orderId">Touch Point</label><br>
          <textarea class="form-control" id="orderCom" name="orderCom" rows="5"></textarea>

          <HR>
          <button type="submit" class="btn btn-primary" >Download</button>
        </form>
        <HR>
          <button class="btn btn-primary" onclick="sendMail()" id="emailButton" name="emailButton">Email</button>
          <button class="btn btn-primary" onclick="sendSMS()" id="emailButton" name="emailButton">SMS</button>

                                                                                        </div>
                                                                                    </div>

                                                                                  </section><!-- End Blog Section -->

                                                                                </main><!-- End #main -->
<script>
function sendSMS() {
  var xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      alert(this.responseText);
      //          document.getElementById("orderCom").innerHTML = this.responseText.trim();
    }
  };
  var eId = <%=eId%>;
  var text = document.getElementById("orderCom").value;
  alert(text);

  const encodedString = encodeURIComponent(text);

  var select = document.getElementById("touchPoints");
  var selectedOption = select.options[select.selectedIndex];
  var com = selectedOption.text;
  const encodedStringsub = encodeURIComponent(com);


  var urlString = "<%=rootUpdate%>customer.edit.com.sms.sec.jsp/?customerId=" + eId + "&com=" + encodedString + "&sub=" + encodedStringsub ;
//      alert(urlString);
  xhttp.open("GET", urlString, true);
  xhttp.send();
}
</script>
</body>

</html>
