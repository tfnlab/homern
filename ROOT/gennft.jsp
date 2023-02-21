<%@ page language="java" import="java.util.UUID,java.lang.Thread,org.apache.commons.io.IOUtils,org.apache.commons.io.output.*,java.nio.charset.Charset,java.io.*,java.util.*,java.awt.image.BufferedImage,javax.imageio.ImageIO,java.io.OutputStream,java.io.FileInputStream,java.io.File"%>

Avatar Finished

<%
  UUID uuid = UUID.randomUUID();
  Process pweb3 = new ProcessBuilder("python3", "/var/lib/tomcat9/webapps/py/acc.py", request.getParameter("walletid")).start();
  String stderr = IOUtils.toString(pweb3.getErrorStream(), Charset.defaultCharset());
  String stdout = IOUtils.toString(pweb3.getInputStream(), Charset.defaultCharset());

 %>

 <hr>
 <%= "UUID " + uuid + " " + stdout + " " +  request.getParameter("walletid")%>
 <hr>
 <a class="btn btn-primary" href="#" onclick="callCopy()" name="copy" id="copy" >Copy</a>
