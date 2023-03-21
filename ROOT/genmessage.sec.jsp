<%@ page language="java" import="com.tfnlab.mysql.Entity,com.tfnlab.mysql.EntityDao,com.tfnlab.mysql.Order,com.tfnlab.mysql.OrderDao,com.tfnlab.mysql.User,com.tfnlab.mysql.TemplateDao,com.tfnlab.mysql.Template,java.util.UUID,java.lang.Thread,org.apache.commons.io.IOUtils,org.apache.commons.io.output.*,java.nio.charset.Charset,java.io.*,java.util.*,java.awt.image.BufferedImage,javax.imageio.ImageIO,java.io.OutputStream,java.io.FileInputStream,java.io.File"%>
<%@ include file="auth.jsp" %>
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



  UUID uuid = UUID.randomUUID();
  String strRes = "";
  Template tmp = new Template();
		tmp = tmp.createTestTemplate();
  //  tmp.setId(uuid);
  TemplateDao tD = new TemplateDao();

  if(username!=null && username.length() >1 ){
    String messageName = "";
    int orderId = 0;
    if (request.getParameter("orderId") != null && !request.getParameter("orderId").isEmpty()) {
      orderId = Integer.parseInt(request.getParameter("orderId"));
    }
    int customerId = 0;
    if (request.getParameter("customerId") != null && !request.getParameter("customerId").isEmpty()) {
      customerId = Integer.parseInt(request.getParameter("customerId"));
    }
    if(orderId >0){
      OrderDao dao = new OrderDao();
      Order order = dao.getOrderByOrderId(orderId, username);
      messageName = order.getOrderName();
    }
    if(customerId>0){
      Entity entity = new Entity();
      EntityDao ed = new EntityDao();
        entity = ed.getEntityById(customerId, username);
        messageName = entity.getFirstName();
    }
//    String agm =   request.getParameter("comType") + " message for my "+ usernameOBJ.getBusiness_name() + " company, the person sending the message is named  " + usernameOBJ.getFirstName() + " " + usernameOBJ.getLastName() + ", The project or person name is " + messageName;
    String agm =   request.getParameter("comType") + " message from my business named '"+ usernameOBJ.getBusiness_name() + "', this business is a '" + usernameOBJ.getBusiness_type() + "'type of business, this message is from  person named '" + usernameOBJ.getFirstName() + " " + usernameOBJ.getLastName() + "', the message is for a customer named '" + messageName + "'";
    if(orderId >0){
        agm =   request.getParameter("comType") + " message from my business named '"+ usernameOBJ.getBusiness_name() + "', this business is a '" + usernameOBJ.getBusiness_type() + "'type of business, this message is from  person named '" + usernameOBJ.getFirstName() + " " + usernameOBJ.getLastName() + "', the message is for a Order named '" + messageName + "' and order id " +  orderId;
    }
    if(orderId==0 && customerId ==0){

      String postType = "Linkedin";
      String twitter = request.getParameter("twitter");
      if(twitter!=null && twitter.length() >1 ){
        if(twitter.equals("true")){
          postType = "Twitter";
        }
      }
      agm =   request.getParameter("comType") +  " " + postType +" message from my business named '" + usernameOBJ.getBusiness_name() + "', this message is from  person named '" + usernameOBJ.getFirstName() + " " + usernameOBJ.getLastName();

      String moreInfo = request.getParameter("moreInfo");
      if(moreInfo!=null && moreInfo.length() >1 ){
        agm =   " my business name is '"+ usernameOBJ.getBusiness_name() + "' and my name is '" + usernameOBJ.getFirstName() + " " + usernameOBJ.getLastName() + " write " + postType + " post about " + request.getParameter("comType") + "  " + request.getParameter("moreInfo") ;
        //agm =   request.getParameter("comType") + "  " + request.getParameter("moreInfo") + " post from my business named '"+ usernameOBJ.getBusiness_name() + "', this message is from  '" + usernameOBJ.getFirstName() + " " + usernameOBJ.getLastName();
      }
    }
    Process pweb3 = new ProcessBuilder("python3", "/var/lib/tomcat9/webapps/py/hrn.py", agm).start();
    String stderr = IOUtils.toString(pweb3.getErrorStream(), Charset.defaultCharset());
    String stdout = IOUtils.toString(pweb3.getInputStream(), Charset.defaultCharset());
    strRes = stdout + stderr;
//    tmp.tmp.setMessage(null)
    tmp.setMessage(strRes);
    tmp.setSubject(request.getParameter("comType"));
    tmp.setUsername(username);
    tmp.setActive(false);
    tmp.setPublic(false);
    tD.addTemplate(tmp);
  }
 %><%= strRes %>
