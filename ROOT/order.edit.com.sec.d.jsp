<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.tfnlab.mysql.User"%>
<%@ page import="com.tfnlab.mysql.UserDao" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.hrn.mysql.Order" %>
<%@ page import="com.hrn.mysql.OrderDao" %>
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
    OrderDao dao = new OrderDao();

    String orderId = "";
    if (request.getParameter("orderId") != null && !request.getParameter("orderId").isEmpty()) {
      orderId =  request.getParameter("orderId") ;
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
      var select = document.getElementById("customer-touch-points");
      var selectedOption = select.options[select.selectedIndex];
      var text = selectedOption.text;
      const encodedString = encodeURIComponent(text);
      var urlString = "<%=rootUpdate%>genmessage.sec.jsp/?orderId=" + document.getElementById("orderId").value + "&comType=" + encodedString ;
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
      var select = document.getElementById("customer-touch-points");
      var selectedOption = select.options[select.selectedIndex];
      var com = selectedOption.value;
      var orderId = '<%=orderId%>';
      var url = "<%=rootUpdate%>order.edit.com.jsp/?orderId=" + orderId +  "&comType=" + com;
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

        <%
        Order order = dao.getOrderByOrderId(orderId, username);
        %>
        <HR>

                    <div class="form-group">
                      Order:
                        <a href="<%=rootUpdate%>order.edit.sec.jsp/?orderId=<%= order.getOrderId() %>" ><%= order.getOrderId() %> - <%= order.getOrderName() %></a><br>
                    </div>
        <HR>
            <div class="form-group">
          <label for="business-type">Select a type of business:</label>
          <select class="form-control" id="customer-touch-points" name="customer-touch-points">
            <option value="greeting" <%if(comType.equals("greeting")){%>selected<%}%> >Greeting</option>
            <option value="interestletter" <%if(comType.equals("interestletter")){%>selected<%}%> >Interest letter</option>
            <option value="proposal" <%if(comType.equals("proposal")){%>selected<%}%> >Proposal</option>
            <option value="invoicing" <%if(comType.equals("invoicing")){%>selected<%}%> >Invoicing</option>
            <option value="thankyou" <%if(comType.equals("thankyou")){%>selected<%}%> >Thank you</option>
            <option value="paymentrequest" <%if(comType.equals("paymentrequest")){%>selected<%}%> >Payment request</option>
            <option value="latepaymentrequest" <%if(comType.equals("latepaymentrequest")){%>selected<%}%> >Late Payment request</option>
            <option value="paymentconfirmation" <%if(comType.equals("paymentconfirmation")){%>selected<%}%> >Payment confirmation</option>
            <option value="progressupdate" <%if(comType.equals("progressupdate")){%>selected<%}%> >Progress update</option>
            <option value="changeorderrequest" <%if(comType.equals("changeorderrequest")){%>selected<%}%> >Change order request</option>
            <option value="warrantyormaintenanceinformation" <%if(comType.equals("warrantyormaintenanceinformation")){%>selected<%}%> >Warranty or maintenance information</option>
            <option value="customersatisfactionsurvey" <%if(comType.equals("customersatisfactionsurvey")){%>selected<%}%> >Customer satisfaction survey</option>
            <option value="followup" <%if(comType.equals("followup")){%>selected<%}%> >Follow-up</option>
            <option value="estimaterequest" <%if(comType.equals("estimaterequest")){%>selected<%}%> >Estimate request</option>
            <option value="scheduling" <%if(comType.equals("scheduling")){%>selected<%}%> >Scheduling</option>
            <option value="sitevisit" <%if(comType.equals("sitevisit")){%>selected<%}%> >Site visit</option>
            <option value="permitapplication" <%if(comType.equals("permitapplication")){%>selected<%}%> >Permit application</option>
          </select>

          </div>
          <HR>
          <a href="javascript:void(0)" onclick="getMessage()">Generate Message</a>
          <HR>

        <!-- ======= Contact Section ======= -->

        <form action="order.edit.com.print.jsp" method="POST" >
          <input type="hidden" id="orderId" name="orderId" value="<%= order.getOrderId() %>" >
          <p>Order Description: <%= order.getOrderDescription() %></p><br>
          <label for="orderId">Touch Point</label><br>
          <textarea class="form-control" id="orderCom" name="orderCom" rows="5"></textarea>
          <input type="submit" value="Download">
        </form>


                                                                 </div>
                                                                 </div>

                                                                 </section><!-- End Blog Section -->

                                                                 </main><!-- End #main -->
</body>

</html>
