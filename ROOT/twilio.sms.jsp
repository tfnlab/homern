<%@ page language="java" import="com.tfnlab.mysql.LeadCorrespondence,com.tfnlab.mysql.LeadCorrespondenceDAO,com.tfnlab.mysql.Lead, com.tfnlab.mysql.LeadDAO, java.util.UUID, java.io.File, java.io.FileWriter, java.io.BufferedWriter, com.tfnlab.api.con.APIConfig, java.io.FileOutputStream, com.tfnlab.mysql.User, com.tfnlab.mysql.UserDao, java.lang.Thread, org.apache.commons.io.IOUtils, org.apache.commons.io.output.*, java.nio.charset.Charset, java.io.*, java.util.*, java.awt.image.BufferedImage, javax.imageio.ImageIO, java.io.OutputStream, java.io.FileInputStream, java.io.File" %>
<%
UserDao dao = new UserDao();
String username = request.getParameter("username");
User user = dao.getUserByUsername(username);
UUID uuid = UUID.randomUUID();
String rm = "";
APIConfig ac = new APIConfig();
try {
    File file = new File(ac.getPdfloc() + uuid.toString() + ".txt");
    FileWriter fw = new FileWriter(file);
    BufferedWriter bw = new BufferedWriter(fw);
    bw.write(user.getTwilio_voice_forward_phone() + "<CONTENT>" + request.getParameter("From") + "<CONTENT>" + request.getParameter("SmsMessageSid") +  "<CONTENT>" +user.getTwilio_sms_phone() + "<CONTENT>" + user.getTwilio_api_sid() + "<CONTENT>" +user.getTwilio_api_key());
    bw.close();

      Process pweb3 = new ProcessBuilder("python3", "/var/lib/tomcat9/webapps/py/smsgetmymessage.py", uuid.toString(), uuid.toString()).start();
      String stderr = IOUtils.toString(pweb3.getErrorStream(), Charset.defaultCharset());
      String stdout = IOUtils.toString(pweb3.getInputStream(), Charset.defaultCharset());

      rm = stdout + stderr + " TEST ";
      LeadDAO lDao = new LeadDAO();
      Lead lead = lDao.getLeadbyPhone(username, request.getParameter("From") );
      if(lead!=null){
            LeadCorrespondenceDAO cdao = new LeadCorrespondenceDAO();
            // Create an instance of the LeadDAO class
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

            String correspondenceType = request.getParameter("leadStatus");
            String message = request.getParameter("orderCom");
            Date dateCreated = new Date();

            // Create a new LeadCorrespondence object with the form data
            LeadCorrespondence leadCorrespondence = new LeadCorrespondence();
            leadCorrespondence.setRecordId(lead.getRecordId());
            leadCorrespondence.setUsername(username);
            leadCorrespondence.setCorrespondenceType("SMS");
            leadCorrespondence.setMessage(rm);
            leadCorrespondence.setDateCreated(new Timestamp(dateCreated.getTime()));
            cdao.insertLeadCorrespondence(leadCorrespondence);
      }
} catch (IOException ex) {
    rm = ex.getMessage();
}
%>Thank You <%rm%>
