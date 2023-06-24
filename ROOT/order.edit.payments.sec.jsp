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
<%@ page import="com.tfnlab.mysql.PaymentPost" %>
<%@ page import="com.tfnlab.mysql.PaymentPostDao" %>
<%@ page import="com.tfnlab.mysql.Payment" %>
<%@ page import="com.tfnlab.mysql.PaymentDao" %>
<%@ page import="com.tfnlab.mysql.OrderDiscount" %>
<%@ page import="com.tfnlab.mysql.OrderDiscountDAO" %>
<%@ page import="com.tfnlab.mysql.OrderRebate" %>
<%@ page import="com.tfnlab.mysql.OrderRebateDAO" %>
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
    OrderTechniciansDAO otD = new OrderTechniciansDAO();
    EventDao evd = new EventDao();
    TechnicianDao technicianDao = new TechnicianDao();
    ProductDao pDao = new ProductDao();
    int orderId = 0;
    if (request.getParameter("orderId") != null && !request.getParameter("orderId").isEmpty()) {
      orderId = Integer.parseInt(request.getParameter("orderId"));
    }


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
    function getOpenPayments(){
      var select = document.getElementById("ocId");
      var selectedOption = select.options[select.selectedIndex];
      var ocId = selectedOption.value;
      var orderId = <%=orderId%>;
      var url = "<%=rootUpdate%>order.edit.payments.available.sec.jsp/?ocId=" + ocId + "&orderId=" + orderId ;
      var xhttp = new XMLHttpRequest();
      xhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
              document.getElementById("pR").innerHTML = this.responseText;
              if(document.getElementById('pIdReq').value != "Done"){
                var pIdReqValue = document.getElementById('pIdReq').value;
                // get a reference to the pId select element
                var selectElement = document.getElementById('pId');
                // loop through the options of the select element
                for (var i = 0; i < selectElement.options.length; i++) {
                  // if the value of the option matches the pIdReq value
                  if (selectElement.options[i].value == pIdReqValue) {
                    // set the option as selected
                    selectElement.options[i].selected = true;
                    break;
                  }
                }
              }
        }
      };
//      alert(url);
      xhttp.open("GET", url, true);
      xhttp.send();
    }
    function onloadpage(){
        getOpenPayments();
    }
  </script>
</head>

<body onload="onloadpage()">

      <main id="main">
        <section id="blog" class="blog">
          <div class="container px-4 px-lg-5">
              <div class="container mt-5">
                <h2><a href="<%=rootUpdate%>user.menu.sec.jsp" tabindex="1" >Home Renovation Nation</a></h2>
                <%
                ProductLineItemDao plDao = new ProductLineItemDao();
                OrderCustomerDao ocDao = new OrderCustomerDao();
                Order order = dao.getOrderByOrderId(orderId, username);
                String action = request.getParameter("action");
                if (action != null && action.trim().length() > 0) {
                  PaymentPostDao ppDao = new PaymentPostDao();
                  if(action.equals("add")){

                    long currentTimeMillis = System.currentTimeMillis();
                    Timestamp currentTime = new Timestamp(currentTimeMillis);
                    String paymentAmountStr = request.getParameter("paymentAmount");
                    if (paymentAmountStr != null && paymentAmountStr.trim().length() > 0) {
                      BigDecimal paymentAmount = new BigDecimal("0");
                      if (request.getParameter("paymentAmount") != null && !request.getParameter("paymentAmount").isEmpty()) {

                        int ocId = 0;
                        if (request.getParameter("ocId") != null && !request.getParameter("ocId").isEmpty()) {
                          ocId = Integer.parseInt(request.getParameter("ocId"));
                        }

                        paymentAmount = new BigDecimal(request.getParameter("paymentAmount"));

                        int pId = 0;
                        if (request.getParameter("pId") != null && !request.getParameter("pId").isEmpty()) {
                          if(request.getParameter("pId").equals("ap")){
                                PaymentDao payDao = new PaymentDao();
                                Payment payment = new Payment(0, ocDao.getCustomersById(ocId).getCustomer().getId(), new Date(), new Date(), new Date(), paymentAmount, "Quick Pay", true, false, new Date(), new Date(), username, 0, paymentAmount);
                                String uuid = java.util.UUID.randomUUID().toString();
                                payment.setPayment_uuid(uuid);
                                payDao.insertPayment(payment);
                                pId= (payDao.getPayment_by_uuid(uuid, username)).getPaymentId();
                          }else{
                                pId = Integer.parseInt(request.getParameter("pId"));
                          }
                        }
                        PaymentPost pp = new  PaymentPost(1, pId, new Date(), new Date(), new Date(), paymentAmount, new Date(), new Date(), username, 3, username, ocId);
                        pp.setOrder_Id(orderId);
                        ppDao.insertPaymentPost(pp);
                      }
                    }
                  }
                  if(action.equals("remove")){

                  }
                }
               List<ProductLineItem> pliList = plDao.getProductLineItemsByInvoiceId(order.getOrderId());
               BigDecimal invTotal  = new BigDecimal("0");
               for (ProductLineItem plItem : pliList) {
                      invTotal = invTotal.add(plItem.getTotal());
               }
		        PaymentPostDao ppDao = new PaymentPostDao();
		        BigDecimal totalPaid = ppDao.getTotalPaymentAmount(order.getOrderId());
	            if(totalPaid ==null) totalPaid = new BigDecimal("0");

                OrderRebateDAO orDao = new OrderRebateDAO();
                List<OrderRebate> orList = orDao.getOrderRebatesByUsernameAndOrderId(username, order.getOrderId());
                BigDecimal orTotal  = new BigDecimal("0");
                for (OrderRebate orItem : orList) {
                      orTotal = orTotal.add(orItem.getRebate().getAmount());
                }
                OrderDiscountDAO odDao = new OrderDiscountDAO();
                List<OrderDiscount> odList = odDao.getOrderDiscountsByUsernameAndOrderId(username, order.getOrderId());
                BigDecimal odTotal  = new BigDecimal("0");
                for (OrderDiscount odItem : odList) {
                      odTotal = odTotal.add(odItem.getDiscount().getAmount());

                }

                %>
                <HR>
                <div class="form-group">
                  Order:
                    <a href="<%=rootUpdate%>order.edit.sec.jsp/?orderId=<%= order.getOrderId() %>" ><%= order.getOrderId() %> - <%= order.getOrderName() %></a><br>
                </div>
                <HR>
             <h3>Payments</h3>
             <HR>
               <%

                    List<OrderCustomer> ocList = ocDao.getCustomersByOrderId(order.getOrderId());
               %>
               <form action="<%=rootUpdate%>order.edit.payments.sec.jsp/" method="POST">
                    <input type="hidden" id="orderId" name="orderId" value="<%= order.getOrderId() %>" />
             <div class="form-group">
              <label for="ocId">Customers:</label>
               <select class="form-group" id="ocId" name="ocId" onchange="getOpenPayments()">
                  <% for (OrderCustomer ocItem : ocList) { %>
                    <option value="<%= ocItem.getId() %>"
                        <%if(request.getParameter("ocId")!=null && !request.getParameter("ocId").isEmpty()){%>
                          <%if(ocItem.getId() == Integer.parseInt(request.getParameter("ocId"))) {%>
                              selected
                          <%}%>
                        <%}%>
                    ><%= ocItem.getCustomer().getFirstName() %></option>
                  <% } %>
               </select>
            </div>
            <HR>
              <input type="hidden" id="action" name="action" value="add">
              <input type="hidden" id="orderId" name="orderId" value="<%= order.getOrderId() %>">
              <input type="hidden" id="pIdReq" name="pIdReq" value="<%= request.getParameter("pId") %>">

              <div class="container" id="pR" name="pR" >
                  <div class="form-group">
                   <label for="pId">Available Payments:</label>
                    <select class="form-group" id="pId" name="pId" >
                            <option >Select Customer</option>
                    </select>
                 </div>
              </div>
              <HR>
              <div class="form-group">
                <label for="paymentAmount">Invoice Total</label>
                <%=invTotal%>
              </div>
              <HR>
              <div class="form-group">
                <label for="paymentAmount">Paid Amount</label>
                <%=totalPaid%>
              </div>
              <HR>
              <div class="form-group">
                <label for="paymentAmount">Rebate Amount</label>
                <%=orTotal%>
              </div>
              <HR>
              <div class="form-group">
                <label for="paymentAmount">Discount Amount</label>
                <%=odTotal%>
              </div>

              <HR>
              <div class="form-group">
                <label for="paymentAmount">Post Amount</label>
                <input type="number" class="form-control" id="paymentAmount" name="paymentAmount" placeholder="Enter payment amount" value="<%=invTotal.subtract(totalPaid).subtract(orTotal).subtract(odTotal)%>">
              </div>
              <HR>
              <div class="form-group">
                <button type="submit"  class="btn btn-primary">Post Payment To Invoice</button>
              </div>
            </form>
            <HR>
            </div>
            </div>

            </section><!-- End Blog Section -->

            </main><!-- End #main -->

</body>

</html>
