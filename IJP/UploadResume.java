import jakarta.servlet.*;
import java.io.*;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.util.*;
import java.sql.*;
@MultipartConfig(
		  fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
		  maxFileSize = 1024 * 1024 * 10,      // 10 MB
		  maxRequestSize = 1024 * 1024 * 100   // 100 MB
		)
public class UploadResume extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public UploadResume() {  	
    }
  	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
  		HttpSession session=request.getSession();
		String MailId=(String)session.getAttribute("Email_of_user");
		if(session.getAttribute("Username_of_user")==null){
			response.sendRedirect("UserLogin.html");
		} 
		PrintWriter pr=response.getWriter();
		response.setContentType("text/html");
		Part filePart = request.getPart("resume");
		String req_skills=request.getParameter("skills");
		try{
			Class.forName("org.postgresql.Driver");
			Connection cn=DriverManager.getConnection("jdbc:postgresql://localhost:5432/ijp","postgres","Tej@s");
			cn.setAutoCommit(false);
			Statement st=cn.createStatement(); 
			InputStream inputStream=filePart.getInputStream();
			String sql="update users set skills=?,resume=? where mailid='"+MailId+"'"; 
			PreparedStatement ps=cn.prepareStatement(sql);
			ps.setString(1,req_skills);
			ps.setBlob(2,inputStream);
			int flag=ps.executeUpdate();
			if(flag>0){
				pr.print("<strong style='color:red;margin-left:8em;font-size:1.1em;'>Resume uploaded and skills updated successfully...</strong>");
			}
			else 
				pr.print("<strong style='color:red;margin-left:14em;font-size:1.1em;'>Unable to save !...</strong>");
			
		
			ResultSet rs=st.executeQuery("select resume from users where mailid='"+MailId+"'");
			while(rs.next()){
				Blob blob=rs.getBlob("resume");
				 inputStream = blob.getBinaryStream();
	             OutputStream outputStream = new FileOutputStream("D:\\Eclipse Workspace\\IJP\\src\\main\\webapp\\ResumeFile.pdf");

	             int bytesRead = -1;
	             byte[] buffer = new byte[80000];
	             while ((bytesRead = inputStream.read(buffer)) != -1) {
	                 outputStream.write(buffer, 0, bytesRead);
	             }
	             inputStream.close();
	             outputStream.close();
	         	 cn.commit();
			}
		}
		catch(Exception ee) {
			pr.print(ee);
		}
	}
}
