<%@ page import="com.tfnlab.mysql.User"%>
<%@ page import="com.tfnlab.mysql.UserDao" %>
<%@ page import="com.tfnlab.mysql.Entity" %>
<%@ page import="com.tfnlab.business.MotherfuckerDao" %>
<%@ page import="com.tfnlab.business.MFOrder" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="com.tfnlab.mysql.Technician" %>
<%@ page import="com.tfnlab.mysql.TechnicianDao" %>
<%@ page import="com.tfnlab.mysql.OrderTechniciansDAO" %>
<%@ page import="com.tfnlab.mysql.Event" %>
<%@ page import="com.tfnlab.mysql.EventDao" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%@ page import="com.tfnlab.mysql.Quote" %>
<%@ page import="com.tfnlab.mysql.QuoteDAO" %>
<%@ page import="com.tfnlab.mysql.Contact" %>
<%@ page import="com.tfnlab.mysql.ContactDAO" %>
<%@ page import="com.tfnlab.mysql.OrderTechnicians" %>
<%@ page import="com.tfnlab.mysql.ProductLineItem" %>
<%@ page import="com.tfnlab.mysql.OrderCustomer" %>
<%@ page import="java.util.Enumeration" %><%
        String apiAction = request.getParameter("apiAction");
        SimpleDateFormat longFormat = new SimpleDateFormat("MMMM dd, yyyy hh:mm a");
        if (apiAction != null && apiAction.trim().length() > 0) {
           try{
              if(apiAction.equals("signin")){
                      MotherfuckerDao mferDao = new MotherfuckerDao();
                      String customerId = request.getParameter("customerId");
                      String api_key = request.getParameter("api_key");
                      String username = request.getParameter("username");
                      String password = request.getParameter("password");
                      Entity entity = mferDao.signinMotherFucker(customerId, api_key, username, password);
                      %>

                      First Name: <%= entity.getFirstName() %><br>
                      Last Name: <%= entity.getLastName() %><br>
                      Address: <%= entity.getAddress() %><br>
                      Phone: <%= entity.getPhone() %><br>
                      Email: <%= entity.getEmail() %><br>
                      <HR>
                      <a href="orders.jsp" >Get Orders</a>

                      <%
              }
              if(apiAction.equals("signupemployee")){
                      MotherfuckerDao mferDao = new MotherfuckerDao();
                      String customerId = request.getParameter("customerId");
                      String api_key = request.getParameter("api_key");
                      String username = request.getParameter("username");
                      String password = request.getParameter("password");
                      Technician technician = new Technician();
                        long currentTimeMillis = System.currentTimeMillis();
                        Timestamp currentTime = new Timestamp(currentTimeMillis);
                        Timestamp createdAt = currentTime;
                        Timestamp updatedAt = currentTime;
                        technician.setDateCreated(new java.util.Date(createdAt.getTime()));
                        technician.setDateLastModified(new java.util.Date(updatedAt.getTime()));

                      technician.setTechnicianName(request.getParameter("firstName") + " " + request.getParameter("lastName"));
                      technician.setTechnicianEmail(request.getParameter("email"));
                      technician.setTechnicianPhone(request.getParameter("phone"));
                      technician.setT_u(request.getParameter("username"));
                      technician.setT_p(request.getParameter("password"));

                      technician = mferDao.signupMotherFuckerTechnician(customerId, api_key, technician);
                      %>
                          <a href="signin.employee.jsp" >Login</a>
                      <%
              }
              if(apiAction.equals("signinemployee")){
                      MotherfuckerDao mferDao = new MotherfuckerDao();
                      String customerId = request.getParameter("customerId");
                      String api_key = request.getParameter("api_key");
                      String username = request.getParameter("username");
                      String password = request.getParameter("password");
                      Technician technician = mferDao.signinMotherFuckerTechnician(customerId, api_key, username, password);
                      %>
                        <%=technician.getTechnicianName()%>
                        <a href="orders.employee.jsp" >Get Orders</a>
                      <%
              }
              if(apiAction.equals("signup")){
                      MotherfuckerDao mferDao = new MotherfuckerDao();
                      String customerId = request.getParameter("customerId");
                      String api_key = request.getParameter("api_key");
                      Entity entity = new Entity();
                      entity = entity.generateSampleEntity();

//                      entity.setId(Integer.parseInt(request.getParameter("id")));
                      entity.setUsername(customerId);
                      entity.setFirstName(request.getParameter("firstName"));
                      entity.setLastName(request.getParameter("lastName"));
                      entity.setEmail(request.getParameter("email"));
                      entity.setPhone(request.getParameter("phone"));
                      entity.setAddress(request.getParameter("address"));
                      entity.setCity(request.getParameter("city"));
                      entity.setState(request.getParameter("state"));
                      entity.setZipcode(request.getParameter("zipcode"));
                      entity.setCountry(request.getParameter("country"));
                      entity.setUsername_entity(request.getParameter("username"));
                      entity.setPassword(request.getParameter("password"));
                      entity.setLocation_pointlat("0");
                      entity.setLocation_pointlng("0");

                      entity = mferDao.signupMotherFucker(customerId, api_key, entity);
                      if(entity!=null){
                      %>
                        <a href="signin.jsp" >Login</a>
                      <%
                      }else{
                        %>Unable to Sign Up<%
                      }

              }
              if(apiAction.equals("getOrders")){
                  MotherfuckerDao mferDao = new MotherfuckerDao();
                  String customerId = request.getParameter("customerId");
                  String api_key = request.getParameter("api_key");
                  String username = request.getParameter("username");
                  String password = request.getParameter("password");
                  int orderId = 0;
                  if (request.getParameter("orderId") != null && !request.getParameter("orderId").isEmpty() && !request.getParameter("orderId").equals("null")) {
                    orderId = Integer.parseInt(request.getParameter("orderId"));
                  }

                  Entity entity = mferDao.signinMotherFucker(customerId, api_key, username, password);
                  if(orderId > 0){
                      mferDao.updateOrder(customerId, api_key, username, password, orderId, "Approved");
                  }
                          %>

                          First Name: <%= entity.getFirstName() %><br>
                          Last Name: <%= entity.getLastName() %><br>
                          Address: <%= entity.getAddress() %><br>
                          Phone: <%= entity.getPhone() %><br>
                          Email: <%= entity.getEmail() %><br>
                          <HR>
                          <a href="orders.jsp" >Get Orders</a>
                          <HR>
                          <%

                  List<OrderCustomer> ocList= mferDao.getOrders(customerId, api_key, username, password);

                      for (OrderCustomer ocItem : ocList) {
                        %>
                         Order ID:
                         <a href="order.jsp?orderId=<%= ocItem.getOrder().getOrderId() %>" > <%= ocItem.getOrder().getOrderId() %></a><br>
                         Name: <%= ocItem.getOrder().getOrderName() %><br>
                         Description: <%= ocItem.getOrder().getOrderDescription() %><br>
                         <%=longFormat.format(ocItem.getOrder().getShipDate())%><BR>
                         <hr>
                         <%
                      }
                      if (ocList.isEmpty()) {
                        %>
                        <p>Sorry, we could not find any projects matching your criteria.</p>
                        <p>You may want to try modifying your search parameters or creating a new project.</p>
                        <p><a href="order.new.jsp" class="btn btn-primary" >Create a new project</a></p>
                        <%
                      }


              }
              if(apiAction.equals("addSub")){
                MotherfuckerDao mferDao = new MotherfuckerDao();
                String customerId = request.getParameter("customerId");
                String api_key = request.getParameter("api_key");
                String subemail = request.getParameter("email");
                mferDao.subscribeWeb(customerId, api_key, subemail);
                %>
                  '<%=subemail%>'
                <%
              }
              if(apiAction.equals("addContact")){
                MotherfuckerDao mferDao = new MotherfuckerDao();
                String customerId = request.getParameter("customerId");
                String api_key = request.getParameter("api_key");

                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String subject = request.getParameter("subject");
                String message = request.getParameter("message");

                // Create a new Contact object
                Contact contact = new Contact();
                contact.setUsername(customerId);
                contact.setName(name);
                contact.setEmail(email);
                contact.setSubject(subject);
                contact.setMessage(message);

                mferDao.contactWeb(customerId, api_key, contact);
                %>
                  '<%=email%>'
                <%
              }
              if(apiAction.equals("addQuote")){
                MotherfuckerDao mferDao = new MotherfuckerDao();
                String customerId = request.getParameter("customerId");
                String api_key = request.getParameter("api_key");

                String email = request.getParameter("email");
                String phoneNumber = request.getParameter("phone_number");
                String requestDate = request.getParameter("request_date");
                String productName = request.getParameter("product_name");
                String quantityParam = request.getParameter("quantity");
                int quantity = 0; // Default value in case the parameter is null or cannot be parsed

                if (quantityParam != null && !quantityParam.isEmpty()) {
                    try {
                        quantity = Integer.parseInt(quantityParam);
                    } catch (NumberFormatException e) {
                        // Handle the exception if the parameter cannot be parsed as an integer
                        // You can log the error or perform any necessary error handling here
                    }
                }
                String additionalNotes = request.getParameter("additional_notes");
                String installationAddress = request.getParameter("installation_address");
                String roofType = request.getParameter("roof_type");
                int avgMonthlyEnergyUsage = Integer.parseInt(request.getParameter("avg_monthly_energy_usage"));
                String additionalMessage = request.getParameter("additional_message");
                Quote quote = new Quote();
                quote.setCustomerName(customerName);
                quote.setEmail(email);
                quote.setPhoneNumber(phoneNumber);
                quote.setRequestDate(java.sql.Date.valueOf(requestDate));
                quote.setProductName(productName);
                quote.setQuantity(quantity);
                quote.setAdditionalNotes(additionalNotes);
                quote.setInstallationAddress(installationAddress);
                quote.setRoofType(roofType);
                quote.setAvgMonthlyEnergyUsage(avgMonthlyEnergyUsage);
                quote.setAdditionalMessage(additionalMessage);
                quote.setUsername(customerId);


//                mferDao.contactWeb(customerId, api_key, contact);
                %>
                  '<%=email%>'
                <%
              }
              if(apiAction.equals("getOrder")){
                MotherfuckerDao mferDao = new MotherfuckerDao();
                String customerId = request.getParameter("customerId");
                String api_key = request.getParameter("api_key");
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                int orderId = 0;
                if (request.getParameter("orderId") != null && !request.getParameter("orderId").isEmpty()) {
                  orderId = Integer.parseInt(request.getParameter("orderId"));
                }

                Entity entity = mferDao.signinMotherFucker(customerId, api_key, username, password);
                        %>
                        First Name: <%= entity.getFirstName() %><br>
                        Last Name: <%= entity.getLastName() %><br>
                        Address: <%= entity.getAddress() %><br>
                        Phone: <%= entity.getPhone() %><br>
                        Email: <%= entity.getEmail() %><br>
                        <HR>
                        <a href="orders.jsp" >Get Orders</a>
                        <HR>
                        <a href="orders.jsp?orderId=<%=orderId%>" >Update Order Status</a>
                        <HR>
                        <%
                            MFOrder mfo =  mferDao.getOrder(customerId, api_key, username, password, orderId);
                            List<ProductLineItem> pliList = mfo.getPlItems();
                            BigDecimal invTotal  = new BigDecimal("0");
                            for (ProductLineItem plItem : pliList) {
                                   invTotal = invTotal.add(plItem.getTotal());
                           %>
                               Tech Name: <%= plItem.getName() %><br>
                               Tech Description: <%= plItem.getDescription() %><br>
                               Tech Units: <%= plItem.getQuantity() %><br>
                               Tech Price: <%= plItem.getPrice() %><br>
                               Tech Price: <%= plItem.getTotal() %><br>
                               <hr>

                        <%
                            }
                        %>
                        <HR>
                              <%
                                  List<OrderTechnicians> lI = mfo.getOtItems();
                                EventDao evd = new EventDao();
                                TechnicianDao technicianDao = new TechnicianDao();

                                HashMap<Integer, Event> eMap = new HashMap<>();
                                HashMap<Integer, Technician> tMap = new HashMap<>();
                                if(lI.size()>0){
                                    eMap = evd.getEventsByUsernameMap(customerId);
                                    tMap = technicianDao.getTechniciansByUsernameMap(customerId);
                                }
                              %>
                        <%
                            for (OrderTechnicians technician : lI) {
                        %>
                               <!--
                                ID: <%= technician.getId() %><br>
                               Tech ID: <%= technician.getTechnicianId() %><br>
                               -->
                               Starts: <%=longFormat.format(eMap.get(Integer.valueOf(technician.getEventId())).getStartTime())%><BR>
                               <%=tMap.get(Integer.valueOf(technician.getTechnicianId())).getTechnicianName() %> <BR>
                               <%=eMap.get(Integer.valueOf(technician.getEventId())).getTitle() %>
                               <hr>

                        <%
                            }
                        %>
                        <%


              }
          }catch(Exception ex){
                %>
                We apologize for the inconvenience. A system error has occurred and our team is investigating. Thank you for your patience.
                more info : <%=ex.getMessage()%><%
          }
        }
%>
