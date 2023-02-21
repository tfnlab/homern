<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.tfnlab.mysql.User"%>
<%@ page import="com.tfnlab.mysql.UserDao" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.tfnlab.mysql.Order" %>
<%@ page import="com.tfnlab.mysql.OrderDao" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.tfnlab.mysql.Technician" %>
<%@ page import="com.tfnlab.mysql.TechnicianDao" %>
<%@ page import="com.tfnlab.mysql.OrderTechnicians" %>
<%@ page import="com.tfnlab.mysql.OrderTechniciansDAO" %>
<%@ page import="com.tfnlab.mysql.Product" %>
<%@ page import="com.tfnlab.mysql.ProductDao" %>
<%@ page import="com.tfnlab.mysql.Event" %>
<%@ page import="com.tfnlab.mysql.EventDao" %>
<%@ page import="java.util.UUID" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.tfnlab.mysql.ProductLineItem" %>
<%@ page import="com.tfnlab.mysql.ProductLineItemDao" %>
<%@ page import="com.tfnlab.mysql.OrderCustomer" %>
<%@ page import="com.tfnlab.mysql.OrderCustomerDao" %>




<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>Home Renovation Nation - Sign-up</title>
  <meta content="" name="description">
  <meta content="" name="keywords">

  <!-- Favicons -->
  <link href="assets/img/favicon.png" rel="icon">
  <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" crossorigin="anonymous" />

  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="assets/vendor/aos/aos.css" rel="stylesheet">
  <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
  <link href="assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
  <link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet">

  <!-- Template Main CSS File -->
  <link href="assets/css/style.css" rel="stylesheet">
  <%
    OrderDao dao = new OrderDao();
    OrderTechniciansDAO otD = new OrderTechniciansDAO();
    EventDao evd = new EventDao();
    TechnicianDao technicianDao = new TechnicianDao();
    ProductDao pDao = new ProductDao();
    int orderId = 0;
    String username = (String) session.getAttribute("username");
    User usernameOBJ = (User) session.getAttribute("usernameOBJ");
    if (request.getParameter("orderId") != null && !request.getParameter("orderId").isEmpty()) {
      orderId = Integer.parseInt(request.getParameter("orderId"));
    }
    int customerId = 0;
    if (!request.getParameter("customerId").isEmpty()) {
      customerId = Integer.parseInt(request.getParameter("customerId"));
    }

  %>
  <!-- =======================================================
  * Template Name: Presento - v3.9.1
  * Template URL: https://bootstrapmade.com/presento-bootstrap-corporate-template/
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
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
      var urlString = "genmessage.jsp?orderId=" + document.getElementById("orderId").value + "&comType=" + encodedString ;
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
      var orderId = <%=orderId%>;
      var url = "order.edit.com.jsp?orderId=" + orderId +  "&comType=" + com;
      window.open(url, "_self");
    }
    function getProductDetail() {
      var select = document.getElementById("productsId");
      var selectedOption = select.options[select.selectedIndex];
      var productsId = selectedOption.value;
      var orderId = <%=orderId%>;
      var url = "product.xml.jsp?productId=" + productsId ;
      var xhttp = new XMLHttpRequest();
      xhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
          document.getElementById("name").value = removeTrailingSpaces(this.responseText.split("<HRNITEM>")[0].trim());
          document.getElementById("description").innerHTML = removeTrailingSpaces(this.responseText.split("<HRNITEM>")[1].trim());
          document.getElementById("price").value = removeTrailingSpaces(this.responseText.split("<HRNITEM>")[2].trim());
          calTotal();
        }
      };
      xhttp.open("GET", url, true);
      xhttp.send();
    }
    function calTotal() {
        document.getElementById("total").value = document.getElementById("units").value * document.getElementById("price").value;
    }

    function getInv() {
      var orderId = <%=orderId%>;
      var url = "order.edit.products.print.jsp?orderId=" + orderId;
      window.open(url, "_blank");
    }
    function searchCustomer() {
      var orderId = <%=orderId%>;
      var url = "order.edit.customers.search.jsp?searchKey=" + document.getElementById("search").value  + "&orderId=" + orderId ;
      var xhttp = new XMLHttpRequest();
      xhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            document.getElementById("searchR").innerHTML = this.responseText;
        }
      };
      xhttp.open("GET", url, true);
      xhttp.send();
    }
  </script>
</head>

<body onload="getProductDetail()">
  <canvas id="signature-canvas" width="400" height="200" style="border: 2px solid #000000;"></canvas>
  <form action="order.edit.customers.sign.jsp" id="signature-form" method="post" enctype="multipart/form-data">
    <input type="file" name="signature" id="signature-input" accept="image/*">
    <button type="submit">Upload Signature</button>
  </form>
  <script>
    // JavaScript code
    var canvas = document.getElementById('signature-canvas');
    var form = document.getElementById('signature-form');
    var input = document.getElementById('signature-input');

    // Set up an event listener for the form submission event
    form.addEventListener('submit', uploadSignature);

    function uploadSignature(event) {
      alert('Test');
      // Prevent the form from being submitted
      event.preventDefault();

      // Get the data URL of the canvas image
      var dataURL = canvas.toDataURL();

      // Create a blob from the data URL
      var blob = dataURLToBlob(dataURL);


      alert('Test 2');
      // Set the value of the signature input to the blob
      var formData = new FormData();

      // Append the blob to the form data
      formData.append('signature', blob, 'signature.png');

      // Submit the form using the FormData object
      fetch('order.edit.customers.sign.save.jsp?orderId=<%=orderId+""%>&customerId=<%=customerId +""%>', {
        method: 'POST',
        body: formData
      })
      .then(function(response) {
        response.text().then(function(text) {
          // Display the text
          alert(text);
          var url = "order.edit.customers.jsp?orderId=" + <%=orderId +""%>  ;
          window.open(url, "_self");
        });
      })
      .catch(function(error) {
        // Handle any errors
      });
    }

    function dataURLToBlob(dataURL) {
      // Convert the data URL to a binary string
      var binaryString = atob(dataURL.split(',')[1]);

      // Create an array of bytes from the binary string
      var byteArray = new Uint8Array(binaryString.length);
      for (var i = 0; i < binaryString.length; i++) {
        byteArray[i] = binaryString.charCodeAt(i);
      }

      // Create a blob from the array of bytes
      return new Blob([byteArray], { type: 'image/png' });
    }
  </script>


        <script>
          // JavaScript code
          var canvas = document.getElementById('signature-canvas');
          var context = canvas.getContext('2d');

          // Flag to track whether the user is currently drawing
          var isDrawing = false;

          // Set up event listeners for mouse and touch events
          canvas.addEventListener('mousedown', startSignature);
          canvas.addEventListener('mousemove', drawSignature);
          canvas.addEventListener('mouseup', endSignature);
          canvas.addEventListener('touchstart', startSignature);
          canvas.addEventListener('touchmove', drawSignature);
          canvas.addEventListener('touchend', endSignature);

          function startSignature(event) {
            event.preventDefault();
            isDrawing = true;
            context.moveTo(event.pageX, event.pageY);
          }

          function drawSignature(event) {
            if (isDrawing) {
              context.lineTo(event.pageX, event.pageY);
              context.stroke();
            }
          }

          function endSignature(event) {
            isDrawing = false;
          }

          canvas.addEventListener('touchstart', startSignature);
          canvas.addEventListener('touchmove', drawSignature);
          canvas.addEventListener('touchend', endSignature);

        </script>


                <h2>Customer Signature</h2>
                        <%
                        ProductLineItemDao plDao = new ProductLineItemDao();
                        OrderCustomerDao ocDao = new OrderCustomerDao();
                        Order order = dao.getOrderByOrderId(orderId, username);
                        String action = request.getParameter("action");
                        if (action != null && action.trim().length() > 0) {
                          if(action.equals("add")){
                            int cId = 0;
                            if (!request.getParameter("customerId").isEmpty()) {
                              cId = Integer.parseInt(request.getParameter("customerId"));
                            }
                            long currentTimeMillis = System.currentTimeMillis();
                            Timestamp currentTime = new Timestamp(currentTimeMillis);
                            OrderCustomer oc = new OrderCustomer(0,orderId, cId, currentTime, username);
                            ocDao.insert(oc);
                          }
                          if(action.equals("remove")){
                            int ocId = 0;
                            if (!request.getParameter("ocId").isEmpty()) {
                              ocId = Integer.parseInt(request.getParameter("ocId"));
                            }
                            ocDao.deleteById(ocId, username);
                          }
                        }
                        %>
                        <div class="form-group">
                          Order:
                            <a href="order.edit.jsp?orderId=<%= order.getOrderId() %>" ><%= order.getOrderId() %> - <%= order.getOrderName() %></a><br>
                        </div>
  <!-- Vendor JS Files -->
  <script src="assets/vendor/purecounter/purecounter_vanilla.js"></script>
  <script src="assets/vendor/aos/aos.js"></script>
  <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="assets/vendor/glightbox/js/glightbox.min.js"></script>
  <script src="assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
  <script src="assets/vendor/php-email-form/validate.js"></script>

  <!-- Template Main JS File -->
  <script src="assets/js/main.js"></script>

</body>

</html>
