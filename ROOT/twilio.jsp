<%@ page language="java" import="java.util.UUID,java.io.File,java.io.FileWriter,java.io.BufferedWriter,com.tfnlab.api.con.APIConfig,java.io.FileOutputStream,com.tfnlab.mysql.User,com.tfnlab.mysql.UserDao,java.lang.Thread,org.apache.commons.io.IOUtils,org.apache.commons.io.output.*,java.nio.charset.Charset,java.io.*,java.util.*,java.awt.image.BufferedImage,javax.imageio.ImageIO,java.io.OutputStream,java.io.FileInputStream,java.io.File"%><?xml version="1.0" encoding="UTF-8"?>
<Response><%

UserDao dao = new UserDao();
String username = request.getParameter("username");
User user = dao.getUserByUsername(username);
String digits = request.getParameter("Digits");
UUID uuid = UUID.randomUUID();
String rm = "";
APIConfig ac = new APIConfig();
if(digits==null){
    try{
          File file = new File(ac.getPdfloc() + uuid.toString() + ".txt");
          FileWriter fw = new FileWriter(file);
          BufferedWriter bw = new BufferedWriter(fw);
          bw.write(user.getTwilio_voice_forward_phone()+ "<CONTENT>" + request.getParameter("From") + "<CONTENT>call for " + request.getParameter("username") +  " From " + request.getParameter("From"));
          bw.close();

          Process pweb3 = new ProcessBuilder("python3", "/var/lib/tomcat9/webapps/py/smssend.py", uuid.toString(), uuid.toString()).start();
          String stderr = IOUtils.toString(pweb3.getErrorStream(), Charset.defaultCharset());
          String stdout = IOUtils.toString(pweb3.getInputStream(), Charset.defaultCharset());
          rm = stdout + stderr + " TEST ";
    }catch(IOException ex){
          rm = ex.getMessage();
    }
%>
    <Gather action="twilio.jsp?username=<%=request.getParameter("username")%>" numDigits="1" timeout="60">
        <Say><%=user.getTwilio_voice_message()%></Say>
    </Gather>
    <Say>Sorry, I didn't receive any input. Goodbye!</Say>
<%} %>
<%if(digits!=null){%>
    <%if(digits.equals("1")){%>
      <Say>You pressed 1, forwarding to sales</Say>
      <Dial>
        <Number><%=user.getTwilio_voice_forward_phone()%></Number>
      </Dial>
    <%}%>
    <%if(digits.equals("2")){%>
      <Say>You pressed 2, forwarding to support</Say>
      <Dial>
        <Number><%=user.getTwilio_voice_forward_phone()%></Number>
      </Dial>
    <%}%>
    <%if(!digits.equals("2") && !digits.equals("1")){%>
      <Say>Invalid option. Goodbye</Say>
    <%}%>
<%}%>
</Response>
