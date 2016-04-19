package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ClinicLogoutServlet")
public class ClinicLogoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out=response.getWriter();  
        
        RequestDispatcher rd = request.getRequestDispatcher("Cliniclogin.jsp");
        rd.include(request, response);  
          
        HttpSession session=request.getSession();  
        session.invalidate();  
          
       
        String msg="You are successfully logged out";
        response.sendRedirect("Cliniclogin.jsp?msg="+msg);
          
        out.close();  
	}

}