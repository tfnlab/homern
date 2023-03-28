<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.tfnlab.mysql.User"%>
<%@ page import="com.tfnlab.mysql.UserDao" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.tfnlab.mysql.Order" %>
<%@ page import="com.tfnlab.mysql.OrderDao" %>
<%@ page import="com.tfnlab.mysql.Entity" %>
<%@ page import="com.tfnlab.mysql.EntityDao" %>
<%@ page import="java.util.List" %>
<%@ page import="com.tfnlab.util.Translate" %>
<%@ include file="auth.sec.jsp" %>
<%
          User usernameOBJ = (User)session.getAttribute("usernameOBJ");
          String username = (String) session.getAttribute("username");
          String rootUpdate = "";
          if(rip.equals("144.202.119.205")){
              UserDao uDao = new UserDao();
              username = request.getParameter("username");
              usernameOBJ = uDao.getUserByUsername(request.getParameter("username"));
              rootUpdate = "../";
          }
%>
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
  <script>
    function callTFNLab() {
      var xhttp = new XMLHttpRequest();
      xhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
          document.getElementById("status").innerHTML = this.responseText;
          const el = document.createElement('textarea');
          el.value =  this.responseText;
          el.setAttribute('readonly', '');
          el.style.position = 'absolute';
          el.style.left = '-9999px';
          document.body.appendChild(el);
          el.select();
          document.execCommand('copy');
          document.body.removeChild(el);

        }
      };
      var urlString = "gennft.jsp?walletid=" + document.getElementById("walletid").value
      document.getElementById("start").style.display="none";
      document.getElementById("status").innerHTML = "Started Avatar Generation, give it a minute. <img src=\"assets/img/wait.gif\" />";
      xhttp.open("GET", urlString, true);
      xhttp.send();
    }

    function callCopy() {
      const el = document.createElement('textarea');
      el.value =  document.getElementById("status").innerHTML;
      el.setAttribute('readonly', '');
      el.style.position = 'absolute';
      el.style.left = '-9999px';
      document.body.appendChild(el);
      el.select();
      document.execCommand('copy');
      document.body.removeChild(el);
    }
  </script>
</head>

<body>


  <!-- Modal -->
  <div class="modal fade" id="customerModal" tabindex="-1" role="dialog" aria-labelledby="customerModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="customerModalLabel">Customer Details</h5>
        </div>
        <div class="modal-body" id="customerModalBody">
          <!-- Customer details will be inserted here -->
        </div>
        <div class="modal-footer">
          <a href="#" class="btn btn-secondary" role="button" id="customerDetailButton">Detail</a>
        </div>
      </div>
    </div>
  </div>

  <main id="main">
    <section id="blog" class="blog">
      <div class="container px-4 px-lg-5">
          <div class="container mt-5">
            <h2><a href="<%=rootUpdate%>user.menu.sec.jsp" tabindex="1" >Home Renovation Nation</a></h2>
            <HR>
              <a href="<%=rootUpdate%>customer.new.sec.jsp/"  tabindex="2"><i class="fas fa-plus"></i> Customer</a>
              <HR>
              <%
                 String searchKey = request.getParameter("searchKey");
                EntityDao cDao = new EntityDao();
                List<Entity> es = null;

                if (searchKey != null && searchKey.trim().length() > 0) {
                    es = cDao.searchSearchKeyByUsername(username, searchKey);
                }else{
                    searchKey = "";
                    es = cDao.getEntitiesByUsername(username);
                }
                %>
                <form action="<%=rootUpdate%>customer.list.jsp/" method="post">
                  <div class="form-group mt-3">
                    <div class="row">
                      <div class="col">
                    <input type="text" class="form-control" id="searchKey" name="searchKey" value="<%= searchKey %>" tabindex="3" >
                      </div>
                      <div class="col">
                    <input type="checkbox" class="form-check-input" name="showMap" id="showMap" value="true"
                      <%
                        String showMap = request.getParameter("showMap");
                        if (showMap != null) {
                          %>checked<%
                        }
                      %>
                      tabindex="4"
                      >
                    <label class="form-check-label" for="availability">Map</label>
                      </div>
                    </div>
                  </div>

                  <HR>
                  <button type="submit" class="btn btn-primary" tabindex="5">Search</button>
                </form>
                <%if(request.getParameter("showMap")!=null){%>
                  <HR>
                  <div id="map" style="width: 100%; height: 400px;"></div>
                  <HR>
                  <!-- Include the Google Maps JavaScript API -->
                  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBicfOJqKecv8AunaLFvEC0bRBWMVUtQus"></script>
                  <script>
                    // Create a map
                    var map = new google.maps.Map(document.getElementById('map'), {
                      mapTypeId: 'roadmap',
                      center: {lat: <%=usernameOBJ.getAddresslat().trim()%>, lng: <%=usernameOBJ.getAddresslng()%>}
                    });

                    map.setOptions({
                      center: {lat: <%=usernameOBJ.getAddresslat()%>, lng: <%=usernameOBJ.getAddresslng()%>},
                      zoom: 8
                    });

                    // Update the map options to make the map responsive.
                    window.addEventListener('resize', function() {
                      map.setOptions({
                        center: {lat: <%=usernameOBJ.getAddresslat()%>, lng: <%=usernameOBJ.getAddresslng()%>},
                        zoom: 8
                      });
                    });

                    <%// Create a marker
                    int ke = 0;
                    for (Entity entity : es) { %>
                    var marker<%=ke%> = new google.maps.Marker({
                      position: {lat: <%=entity.getLocation_pointlat()%>, lng: <%=entity.getLocation_pointlng()%>},
                      map: map,
                      label: '<%=entity.getFirstName()%> <%=entity.getLastName()%>',
                      title: '<%=entity.getAddress()%>'
                    });
                    marker<%=ke%>.addListener('click', function() {
                      // Update the modal body with the customer details
                      document.getElementById('customerModalBody').innerHTML = '<p><%=entity.getFirstName()%> <%=entity.getLastName()%></p><p><%=entity.getAddress()%></p>';
                      // Update the detail button with the customer ID
                      document.getElementById('customerDetailButton').href = 'customer.edit.jsp?customerId=<%=entity.getId()%>';
                      // Show the modal
                      $('#customerModal').modal('show');

                      //alert('<%=entity.getFirstName()%> <%=entity.getLastName()%>, <%=entity.getAddress()%> <a href="customer.edit.jsp?customerId=" >Detail</a>');
                    });
                    <%
                        ke+=1;
                    } %>
                  </script>

                <%}%>
                <HR>
              <% for (Entity entity : es) { %>
                  <%try{%>
                  First Name: <%= entity.getFirstName() %><br>
                  <%if(!entity.getLastName().isEmpty()){%>
                    Last Name: <%= entity.getLastName() %><br>
                  <%}%>
                  <%if(!entity.getAddress().isEmpty()){%>
                  Address: <%= entity.getAddress() %><br>
                  <%}%>
                  <%if(entity.getAddress2()!=null && !entity.getAddress2().isEmpty()){%>
                    Address2: <%= entity.getAddress2() %><br>
                  <%}%>
                  <%if(!entity.getPhone().isEmpty()){%>
                  Phone: <%= entity.getPhone() %><br>
                  <%}%>
                  Email: <%= entity.getEmail() %><br>
                  Customer ID: <a href="<%=rootUpdate%>customer.edit.sec.jsp/?customerId=<%= entity.getId() %>" ><%= entity.getId() %></a><br>
                  <%}catch(Exception ex){%>
                        <%=ex.getMessage()%>
                  <%}%>
                <hr>
              <% } %>


                                                              </div>
                                                          </div>

                                                        </section><!-- End Blog Section -->

                                                      </main><!-- End #main -->

                                                        <button type="button"  id="viewCustomerButton" data-toggle="modal" data-target="#customerModal" style="display: none;"/>
                                                          View Customer Details
                                                        </button>

</body>

</html>
