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
<%@ page import="com.tfnlab.mysql.Lead" %>
<%@ page import="com.tfnlab.mysql.LeadDAO" %>
<%@ page import="com.tfnlab.mysql.UserProfile,com.tfnlab.mysql.UserProfileDao" %>
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
        <h2>Leads</h2>
        <HR>
            <a href="<%=rootUpdate%>lead.new.sec.jsp/" class="btn btn-primary" tabindex="2"><i class="fas fa-plus"></i></a>
            <a href="<%=rootUpdate%>lead.new.bulk.sec.jsp/" class="btn btn-primary" tabindex="2"><i class="fas fa-cubes"></i></a>
            <a href="<%=rootUpdate%>lead.list.sec.jsp/" class="btn btn-primary" tabindex="3"><i class="fas fa-list"></i></a>
            <a href="<%=rootUpdate%>lead.list.table.sec.jsp/" class="btn btn-success" tabindex="4"><i class="fas fa-table"></i></a>
            <a href="<%=rootUpdate%>lead.list.dash.sec.jsp/" class="btn btn-primary" tabindex="5"><i class="fas fa-tachometer-alt"></i></a>
            <a href="<%=rootUpdate%>lead.list.csv.sec.jsp/?csv=true" class="btn btn-primary" tabindex="6"><i class="fas fa-download"></i></a>
            <a href="<%=rootUpdate%>lead.new.bulk.sec.jsp/?csv=true" class="btn btn-primary" tabindex="7"><i class="fas fa-upload"></i></a>

        <HR>
          <div class="container mt-5">
            <div class="container">
                <%

                UserProfile userProfile = new UserProfile();
                UserProfileDao userProfileDao = new UserProfileDao();
                userProfile = userProfileDao.getUserProfileByUsernameAndEmail(username, useremail);

                if (userProfile == null) {
                  userProfile = new UserProfile();
                  userProfile.setFirstName("");
                  userProfile.setLastName("");
                  userProfile.setEmail("");
                  userProfile.setPhone("");
                  userProfile.setSettings("display=table;");
                  userProfile.setUsername(username);
                  userProfile.setUseremail(useremail);
                  userProfile.setDateCreated(new java.util.Date());
                  userProfileDao.createUserProfile(userProfile);
                }else{
                  if(!userProfile.getSettings().contains("display=table;")){
                    userProfile.setSettings(userProfile.getSettings().replace("display=panel;", "display=table;"));
                    userProfileDao.updateUserProfile(userProfile);
                    %>TEST DONE<%
                  }
                }

                List<Lead> leads = null;
                try {
                    LeadDAO leadDAO = new LeadDAO();
                    if(request.getParameter("lead_source")!=null) leads = leadDAO.getLeadsByUsernameandLeadSource(username, request.getParameter("lead_source"));
                    else if(request.getParameter("lead_status")!=null) leads = leadDAO.getLeadsByUsernameandLeadStatus(username, request.getParameter("lead_status"));
                    else if(request.getParameter("pipelinestatus")!=null) leads = leadDAO.getLeadsByUsernameandPipelinestatus(username, request.getParameter("pipelinestatus"));
                    else if(request.getParameter("user_responsible")!=null) leads = leadDAO.getLeadsByUsernameandUser_Responsible(username, request.getParameter("user_responsible"));

                    else leads = leadDAO.getLeadsByUsername(username);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                %>

                <div class="row">

                  <div class="table-responsive">
                  <table>
                    <thead>
                      <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Address</th>
                        <th>Phone</th>
                        <th>Email</th>
                        <th>Lead Status</th>
                        <th>Pipeline</th>
                        <th>External</th>
                        <th>Responsible</th>
                        <!-- Add more header cells for other lead properties -->
                      </tr>
                    </thead>
                    <tbody>
                      <% for (Lead lead : leads) { %>
                      <tr>
                        <td>
                          <a href="<%=rootUpdate%>lead.edit.sec.jsp/?lead_id=<%= lead.getRecordId() %>" tabindex="2">
                            <%= lead.getRecordId() %>
                          </a>
                        </td>
                        <td><%= lead.getName() %> <%= lead.getLname() %></td>
                        <td>
                          <% String address = lead.getAddress(); %>
                          <% if (address != null && !address.isEmpty()) { %>
                            <a href="https://www.google.com/maps/search/?api=1&query=<%= address %>" target="_blank" title="<%=address%>">
                              <%
                            if (address.length() > 20) {
                                String truncatedAddress = address.substring(0, 10) + "..." + address.substring(address.length() - 8);
                                out.println(truncatedAddress);
                            } else {
                                out.println(address);
                            }
                            %>

                            </a>
                          <% } else { %>
                            N/A
                          <% } %>
                        </td>
                        <td>
                          <% String phoneNumber = lead.getPhone(); %>
                          <% if (phoneNumber != null && !phoneNumber.isEmpty()) { %>
                            <a href="tel:<%= phoneNumber %>" title="<%=phoneNumber%>">
                            <%
                            String strippedNumber = phoneNumber.replaceAll("[^0-9]", "");

                            // Remove leading '1' if present
                            if (strippedNumber.startsWith("1")) {
                                strippedNumber = strippedNumber.substring(1);
                            }

                            // Format the phone number
                            if (strippedNumber.length() > 9) {
                              StringBuilder formattedNumber = new StringBuilder();
                              formattedNumber.append("(");
                              formattedNumber.append(strippedNumber.substring(0, 3));
                              formattedNumber.append(") ");
                              formattedNumber.append(strippedNumber.substring(3, 6));
                              formattedNumber.append("-");
                              formattedNumber.append(strippedNumber.substring(6));
                              out.println(formattedNumber);
                            } else {
                                out.println("Invalid");
                            }
                            %>
                            </a>
                          <% } else { %>
                            N/A
                          <% } %>
                        </td>

                        <td>
                        <% String emailAddress = lead.getEmailAddress(); %>
                        <% if (emailAddress != null && !emailAddress.isEmpty()) { %>
                          <a href="mailto:<%= emailAddress %>"><%= emailAddress.split("@")[0] %></a>
                        <% } else { %>
                          N/A
                        <% } %>
                        </td>
                        <td><%= lead.getLeadStatus() %></td>
                        <td><%= lead.getPipelinestatus() %></td>
                        <td><%= lead.getExternal_id() %></td>
                        <td>
                          <% String emailAddressu = lead.getUserResponsible(); %>
                          <% if (emailAddressu != null && !emailAddressu.isEmpty()) { %>
                            <a href="mailto:<%= emailAddressu %>"><%= emailAddressu.split("@")[0] %></a>
                          <% } else { %>
                            N/A
                          <% } %>
                        </td>
                        <!-- Add more table cells for other lead properties -->
                      </tr>
                      <% } %>
                    </tbody>
                  </table>
                  <script>
                  // Get the table element
                  var table = document.querySelector('table');

                  // Get all the header cells
                  var headerCells = table.querySelectorAll('th');

                  // Add click event listener to each header cell
                  headerCells.forEach(function(cell, index) {
                    cell.addEventListener('click', function() {
                      sortTable(index);
                    });
                  });

                  // Function to sort the table based on the given column index
                  function sortTable(columnIndex) {
                    var tableBody = table.querySelector('tbody');
                    var rows = Array.from(tableBody.querySelectorAll('tr'));

                    rows.sort(function(a, b) {
                      var aValue = a.children[columnIndex].textContent.trim();
                      var bValue = b.children[columnIndex].textContent.trim();
                      return aValue.localeCompare(bValue);
                    });

                    // Clear the table body
                    while (tableBody.firstChild) {
                      tableBody.removeChild(tableBody.firstChild);
                    }

                    // Append the sorted rows to the table body
                    rows.forEach(function(row) {
                      tableBody.appendChild(row);
                    });
                  }

                  </script>
                </div>
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
