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
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="javax.servlet.http.Part" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.FileItem" %>
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
        <h2>Lead</h2>
        <HR>
        <HR>
          <a href="<%=rootUpdate%>lead.list.sec.jsp/" tabindex="2"><i class="fas fa-list"></i> Leads</a>
          <%
          boolean isMultipart = ServletFileUpload.isMultipartContent(request);
          String ocrDescription = new String();
          LeadDAO leadDAO = new LeadDAO();
          if (isMultipart) {

              UUID uuid = UUID.randomUUID();
              APIConfig conf = new APIConfig();
              String filename = "lead.bulk." + username + "." + uuid + ".csv";
              String filepath = conf.getPdfloc();
              DiskFileItemFactory factory = new DiskFileItemFactory();
              factory.setSizeThreshold(1024 * 1024); // Set the size threshold for storing files in memory
              factory.setRepository(new File(filepath)); // Set the repository location for temporarily storing files
              ServletFileUpload upload = new ServletFileUpload(factory);
              List<FileItem> items = upload.parseRequest(request);
              for (FileItem item : items) {
                if (!item.isFormField()) { // Check if the item is an uploaded file
                  InputStream fileContent = item.getInputStream(); // Get an InputStream for reading the file contents
                  FileOutputStream fos = new FileOutputStream(filepath   + filename);
                  byte[] buffer = new byte[1024];
                  int length;
                  while ((length = fileContent.read(buffer)) > 0) {
                    fos.write(buffer, 0, length);
                  }
                  fos.close();
                  fileContent.close();
                }
              }


              try {
                BufferedReader reader = new BufferedReader(new FileReader(filepath   + filename));
                String line;
                int lineNumber = 0;
                while ((line = reader.readLine()) != null) {

                    String[] customers = line.split(",");
                    if(lineNumber==0){
                      for(int k=0;k<customers.length;k++){
                        %> ___ <%=k + " - " + customers[k]%> ____ <%
                      }
                    }
                    %><%=lineNumber%><%
                    if(customers.length>21){
                      GeocodingExample geocodingExample = new GeocodingExample();
                      String[] results = geocodingExample.search(customers[17] + ", " + customers[19]);
                  %>
                  <%=customers[0]%>
                  <%=customers[1]%>
                  <%=customers[3]%>
                  <%=customers[5]%>
                  <BR>
                  NOTES
                  <%=customers[10]%>
                  <%=customers[11]%>
                  <BR>
                  A <%=customers[17]%>
                  A2 <%=customers[18]%>
                  C <%=customers[19]%>
                  S <%=customers[20]%>
                  Z <%=customers[21]%>
                  <BR>
                  lat <%=results[0]%>
                  lng <%=results[1]%>
                  <%
                          if(lineNumber!=0){
                              try{
                                long currentTimeMillis = System.currentTimeMillis();
                                Timestamp currentTime = new Timestamp(currentTimeMillis);
                                Lead lead = new Lead();

              //                      entity.setId(Integer.parseInt(request.getParameter("id")));
                                lead.setUsername(username);
                                lead.setName(customers[3]);

                                // parse createdDate as a Date object
              //                      entity.setCreatedDate(new SimpleDateFormat("yyyy-MM-dd").parse(request
                                // parse createdDate as a Date object
                                //entity.setCreatedDate(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("createdDate")));
                                //entity.setLastModifiedBy(request.getParameter("lastModifiedBy"));
                                // parse lastModifiedDate as a Timestamp object
                                //entity.setLastModifiedDate(new Timestamp(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(request.getParameter("lastModifiedDate")).getTime()));
                                leadDAO.insertLead(lead);
                              } catch (Exception e) {
                                e.printStackTrace();
                                %><%=e.getMessage()%><%
                              }
                          }

                    }
                    lineNumber += 1;
                    %>
                    <HR>
                    <%
                }
                reader.close();
              } catch (Exception e) {
                e.printStackTrace();
                %><%=e.getMessage()%><%
              }

            }
            %>

            <form method="post" action="<%=rootUpdate%>lead.new.bulk.sec.jsp/" enctype="multipart/form-data">
              <input type="file" name="file" />
              <input type="submit" value="Upload" />
            </form>
            <HR>
            </div>
          </div>
        </div>
      </div>
    </section><!-- End Blog Section -->
  </main>
</body>
</html>
