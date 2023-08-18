<%@ page language="java" %>
<%@ page import="java.lang.Thread, java.nio.charset.Charset, java.io.*, java.util.*, java.awt.image.BufferedImage, javax.imageio.ImageIO"%>
<%@ page import="com.tfnlab.mysql.Entity, com.tfnlab.mysql.Order, com.tfnlab.mysql.OrderDao, com.tfnlab.mysql.User, com.tfnlab.mysql.UserDao, com.tfnlab.mysql.OrderCustomer, com.tfnlab.mysql.OrderCustomerDao, com.tfnlab.mysql.PaymentPostDao, com.tfnlab.api.con.APIConfig, com.tfnlab.mysql.Technician, com.tfnlab.mysql.TechnicianDao, com.tfnlab.mysql.OrderTechniciansDAO, com.tfnlab.mysql.Event, com.tfnlab.mysql.EventDao, com.tfnlab.mysql.Quote, com.tfnlab.mysql.QuoteDAO, com.tfnlab.mysql.Contact, com.tfnlab.mysql.ContactDAO, com.tfnlab.mysql.OrderTechnicians, com.tfnlab.mysql.ProductLineItem"%>
<%@ page import="com.tfnlab.business.CreateInvoice, com.tfnlab.business.MotherfuckerDao, com.tfnlab.business.MFOrder"%>
<%@ page import="com.itextpdf.kernel.pdf.PdfDocument, com.itextpdf.kernel.pdf.PdfWriter, com.itextpdf.layout.Document, com.itextpdf.layout.element.Paragraph"%>
<%@ page import="org.apache.commons.io.IOUtils,java.io.FileOutputStream, java.util.UUID, java.util.Map, java.util.List, java.util.HashMap, java.math.BigDecimal, java.sql.Timestamp, java.text.SimpleDateFormat"%><%
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

                name = name.replaceAll("[^a-zA-Z0-9.,\\s]", "");
                email = email.replaceAll("[^a-zA-Z0-9.,\\s@]", "");
                subject = subject.replaceAll("[^a-zA-Z0-9.,\\s]", "");
                message = message.replaceAll("[^a-zA-Z0-9.,\\s]", "");

                // Create a new Contact object
                Contact contact = new Contact();
                contact.setUsername(customerId);
                contact.setName(name);
                contact.setEmail(email);
                contact.setSubject(subject);
                contact.setMessage(message);

                mferDao.contactWeb(customerId, api_key, contact);
                %>
                  Thank you <%=name%>
                <%
              }

              if(apiAction.equals("addQuote")){
                MotherfuckerDao mferDao = new MotherfuckerDao();
                String customerId = request.getParameter("customerId");
                String api_key = request.getParameter("api_key");

                String customerName = request.getParameter("customer_name");
                String email = request.getParameter("email");
                String phoneNumber = request.getParameter("phone_number");
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
                String energyUsageParam = request.getParameter("energy_usage");
                int avgMonthlyEnergyUsage = 0;

                if (energyUsageParam != null) {
                    avgMonthlyEnergyUsage = Integer.parseInt(energyUsageParam);
                } else {
                    // Handle the case when the parameter is null
                    // Assign a default value or display an error message
                }

                String additionalMessage = request.getParameter("additional_message");
                Quote quote = new Quote();
                quote.setCustomerName(customerName);
                quote.setEmail(email);
                quote.setPhoneNumber(phoneNumber);
                quote.setProductName(productName);
                quote.setQuantity(quantity);
                quote.setAdditionalNotes(additionalNotes);
                quote.setInstallationAddress(installationAddress);
                quote.setRoofType(roofType);
                quote.setAvgMonthlyEnergyUsage(avgMonthlyEnergyUsage);
                quote.setAdditionalMessage(additionalMessage);
                quote.setUsername(customerId);

                mferDao.quoteWeb(customerId, api_key, quote);

                int startIndex = additionalMessage.indexOf("client_request_key=");
                String clientRequestKey = "NONE";

                if (startIndex != -1) {
                    startIndex += "client_request_key=".length();
                    int endIndex = additionalMessage.indexOf(",", startIndex);
                    if (endIndex == -1) {
                        endIndex = additionalMessage.length();
                    }

                    clientRequestKey = additionalMessage.substring(startIndex, endIndex).trim();
                }
                APIConfig conf = new APIConfig();
                String filepath = conf.getPdfloc();
                String[] fileTypes = { ".jpg", ".png", ".pdf", ".jpeg", ".jpg" };
                boolean hasFile = false;
                for (String fileType : fileTypes) {
                    String logofilepath = filepath + "serverupload." + clientRequestKey + "." + fileType;
                    System.out.println("File type: " + logofilepath);
                    File file = new File(logofilepath);
                    if (file.exists()) {
                        System.out.println("File exists: " + logofilepath);
                        hasFile = true;
                    } else {
                        System.out.println("File does not exist: " + logofilepath);
                    }
                }


                UUID uuid = UUID.randomUUID();
                String rm = "";
                UserDao uDao = new UserDao();
                User usernameOBJ = uDao.getUserByUsername(customerId);
                String toEmail = usernameOBJ.getPush_notification_email();
                String[] emailArray = toEmail.split(",");
                String subject = "Quote Request";
                String emailContent = "Customer Name: " + customerName + " <BR> Email: " + email + " <BR> Phone: " + phoneNumber + " <BR> Message: " + additionalMessage + " <BR> Address: " + installationAddress + " <BR> PARSED KEY HAS FILE: " + hasFile;
                //uDao.
                // Get the content from the query parameter
                          APIConfig ac = new APIConfig();
                          for (String recipient : emailArray) {
                            try{
                                  File file = new File(ac.getPdfloc() + uuid.toString() + ".txt");
                                  FileWriter fw = new FileWriter(file);
                                  BufferedWriter bw = new BufferedWriter(fw);
                                  bw.write(recipient.trim() + "<CONTENT>" + subject + "<CONTENT>" + emailContent + "<CONTENT>" + usernameOBJ.getSendgrid_email());
                                  bw.close();

                                  Process pweb3 = new ProcessBuilder("python3", "/var/lib/tomcat9/webapps/py/sendmail.py", uuid.toString(), usernameOBJ.getSendgrid_key()).start();
                                  String stderr = IOUtils.toString(pweb3.getErrorStream(), Charset.defaultCharset());
                                  String stdout = IOUtils.toString(pweb3.getInputStream(), Charset.defaultCharset());
                                  rm = stdout + stderr + " TEST ";
                              }catch(IOException ex){
                                  rm = ex.getMessage();
                              }
                          }
                %>
                  '<%=email%> | <%=rm%>'
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
