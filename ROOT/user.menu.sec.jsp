<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.tfnlab.mysql.User"%>
<%@ page import="com.tfnlab.mysql.UserDao" %>
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
            <h4><%=usernameOBJ.getBusiness_name()%> (<%=request.getParameter("hrnemail")%>)</h4>
            <HR>
            <style>
              .fa {
                font-size: 48px;
                margin-right: 10px;
              }
              a:hover {
                color: blue;
                text-decoration: underline;
              }
              .link-col {
                display: flex;
                flex-direction: column;
                align-items: center;
              }
              a {
                padding: 10px;
              }
            </style>
            <div class="row">

              <div class="col-3 ">
                  <a href="<%=rootUpdate%>user.menu.sec.jsp/" tabindex="1" ><i class="fa fa-home"></i></a>
                  <p><%= (new Translate()).translate("Home", usernameOBJ.getLanguage())%></p>
                </div>

                  <div class="col-3 ">
                  <a href="<%=rootUpdate%>dashboard.sec.jsp/" tabindex="2" ><i class="fa fa-tachometer-alt"></i></a>
                  <p><%= (new Translate()).translate("Dashboard", usernameOBJ.getLanguage())%></p>
                </div>

                  <div class="col-3 ">
                  <a href="<%=rootUpdate%>user.edit.sec.jsp/" tabindex="3" ><i class="fa fa-cog"></i></a>
                  <p><%= (new Translate()).translate("Settings", usernameOBJ.getLanguage())%></p>
                </div>

                  <div class="col-3 ">
                  <a href="<%=rootUpdate%>technician.list.sec.jsp/" tabindex="4" ><i class="fa fa-wrench"></i></a>
                  <p><%= (new Translate()).translate("Technicians", usernameOBJ.getLanguage())%></p>
                </div>
              </div>

              <div class="row">
                <div class="col-3 ">
                  <a href="<%=rootUpdate%>product.list.sec.jsp/" tabindex="5" ><i class="fa fa-box"></i></a>
                  <p><%= (new Translate()).translate("Products", usernameOBJ.getLanguage())%></p>
                </div>
                <div class="col-3 ">
                  <a href="<%=rootUpdate%>customer.list.sec.jsp/" tabindex="6" ><i class="fa fa-users"></i></a>
                  <p><%= (new Translate()).translate("Customers", usernameOBJ.getLanguage())%></p>
                </div>
                <div class="col-3 ">
                  <a href="<%=rootUpdate%>order.list.sec.jsp/" tabindex="7" ><i class="fa fa-shopping-cart"></i></a>
                  <p><%= (new Translate()).translate("Orders", usernameOBJ.getLanguage())%></p>
                </div>
                <div class="col-3 ">
                  <a href="<%=rootUpdate%>event.list.sec.jsp/" tabindex="8" ><i class="fa fa-calendar"></i></a>
                  <p><%= (new Translate()).translate("Events", usernameOBJ.getLanguage())%></p>
                </div>
              </div>
              <div class="row">
                <div class="col-3 ">
                  <a href="<%=rootUpdate%>discount.list.sec.jsp/" tabindex="9" ><i class="fa fa-gift"></i></a>
                  <p><%= (new Translate()).translate("Discounts", usernameOBJ.getLanguage())%></p>
                </div>
                <div class="col-3 ">
                  <a href="<%=rootUpdate%>rebate.list.sec.jsp/" tabindex="10" ><i class="fa fa-wallet"></i></a>
                  <p><%= (new Translate()).translate("Rebates", usernameOBJ.getLanguage())%></p>
                </div>
                <div class="col-3 ">
                  <a href="<%=rootUpdate%>inventory.list.sec.jsp/" tabindex="11" ><i class="fa fa-box-open"></i></a>
                  <p><%= (new Translate()).translate("Inventory", usernameOBJ.getLanguage())%></p>
                </div>
                <div class="col-3 ">
                  <a href="<%=rootUpdate%>timesheet.list.sec.jsp/" tabindex="12" ><i class="fa fa-clock"></i></a>
                  <p><%= (new Translate()).translate("Time Sheet", usernameOBJ.getLanguage())%></p>
                </div>
              </div>

              <div class="row">
                <div class="col-3 ">
                  <a href="expense.list.jsp" tabindex="13" ><i class="fa fa-plane"></i></a>
                  <p><%= (new Translate()).translate("Expenses", usernameOBJ.getLanguage())%></p>
                </div>
                <div class="col-3 ">
                  <a href="user.edit.social.jsp" tabindex="14" ><i class="fa fa-share-square"></i></a>
                  <p><%= (new Translate()).translate("Social Media", usernameOBJ.getLanguage())%></p>
                </div>
                <div class="col-3 ">
                  <a href="user.edit.referred_by.jsp" tabindex="15" ><i class="fa fa-people-arrows"></i></a>
                  <p><%= (new Translate()).translate("Referral", usernameOBJ.getLanguage())%></p>
                </div>
                <div class="col-3 ">
                  <a href="dmp.list.jsp" tabindex="16" ><i class="fa fa-database"></i></a>
                  <p><%= (new Translate()).translate("Data Management Platform", usernameOBJ.getLanguage())%></p>
                </div>
              </div>

              <div class="row">
                <div class="col-3 ">
                  <a href="#" tabindex="17" ><i class="fa fa-money-bill-alt"></i></a>
                  <p><%= (new Translate()).translate("Assets", usernameOBJ.getLanguage())%></p>
                </div>
                <div class="col-3 ">
                  <a href="#" tabindex="18" ><i class="fa fa-file-invoice-dollar"></i></a>
                  <p><%= (new Translate()).translate("Liabilities", usernameOBJ.getLanguage())%></p>
                </div>
                <div class="col-3 ">
                  <a href="#" tabindex="19" ><i class="fa fa-chart-pie"></i></a>
                  <p><%= (new Translate()).translate("Equity", usernameOBJ.getLanguage())%></p>
                </div>
                <div class="col-3 ">
                  <a href="#" tabindex="20" ><i class="fa fa-chart-line"></i></a>
                  <p><%= (new Translate()).translate("Forecasting", usernameOBJ.getLanguage())%></p>
                </div>
              </div>
              <div class="row">
                <div class="col-3 ">
                  <a href="vendor.list.jsp" tabindex="21" ><i class="fa fa-truck"></i></a>
                  <p><%= (new Translate()).translate("Vendors", usernameOBJ.getLanguage())%></p>
                </div>
                <div class="col-3 ">
                  <a href="<%=rootUpdate%>subscription.list.sec.jsp/" tabindex="22" ><i class="fa fa-newspaper"></i></a>
                  <p><%= (new Translate()).translate("Subscriptions", usernameOBJ.getLanguage())%></p>
                </div>
                <div class="col-3 ">
                  <a href="<%=rootUpdate%>contact.list.sec.jsp/" tabindex="23" ><i class="fa fa-address-book"></i></a>
                  <p><%= (new Translate()).translate("Contacts", usernameOBJ.getLanguage())%></p>
                </div>
                <div class="col-3 ">
                  <a href="<%=rootUpdate%>quote.list.sec.jsp/" tabindex="24" ><i class="fa fa-file-invoice-dollar"></i></a>
                  <p><%= (new Translate()).translate("Quotes", usernameOBJ.getLanguage())%></p>
                </div>
              </div>
              <div class="row">
                <div class="col-3 ">
                  <a href="<%=rootUpdate%>lead.list.sec.jsp/" tabindex="21" ><i class="fa fa-user-friends"></i></a>
                  <p><%= (new Translate()).translate("Leads", usernameOBJ.getLanguage())%></p>
                </div>
                <div class="col-3 ">
                  <a href="<%=rootUpdate%>subscription.list.sec.jsp/" tabindex="22" ><i class="fa fa-bullseye"></i></a>
                  <p><%= (new Translate()).translate("Opportunities", usernameOBJ.getLanguage())%></p>
                </div>
                <div class="col-3 ">
                  <a href="<%=rootUpdate%>contact.list.sec.jsp/" tabindex="23" ><i class="fa fa-tasks"></i></a>
                  <p><%= (new Translate()).translate("Projects", usernameOBJ.getLanguage())%></p>
                </div>
                <div class="col-3 ">
                  <a href="#" tabindex="24" ><i class="fas fa-user-secret"></i></a>
                  <p><%= (new Translate()).translate("Black Ops", usernameOBJ.getLanguage())%></p>
                </div>
              </div>
            </div>
        </div>

      </section><!-- End Blog Section -->

    </main><!-- End #main -->
</body>

</html>
