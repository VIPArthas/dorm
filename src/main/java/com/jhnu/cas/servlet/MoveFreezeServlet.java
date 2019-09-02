package com.jhnu.cas.servlet;

import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.StringUtils;

import com.jhnu.cas.entity.LoginResultBean;
import com.jhnu.util.catche.MacForPassCache;

public class MoveFreezeServlet extends HttpServlet {

	private static final long serialVersionUID = 2846819435342971388L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String user=request.getParameter("user");
		String ip=request.getParameter("ip");
		String outString="";
		if(StringUtils.hasLength(user)&&StringUtils.hasLength(ip)){
			LoginResultBean lrb=MacForPassCache.moveFreeze(ip, user);
			outString=lrb.getErrorMas();
		}else{
			outString="参数异常";
		}
		OutputStream ouputStream = response.getOutputStream();;
		response.setHeader("Content-type", "text/html;charset=UTF-8");
		ouputStream.write(outString.getBytes( "UTF-8"));
		ouputStream.flush();   
	    ouputStream.close(); 
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
