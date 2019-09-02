package com.jhnu.cas.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.collections.MapUtils;

import com.jhnu.util.common.SpringContextUtil;
import com.jhnu.util.getSql.ViewDao;

/**
 * Servlet implementation class CheckLink
 */
public class CheckLink extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckLink() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 request.setCharacterEncoding("UTF-8");
		 response.setContentType("text/html;charset=utf-8");
		String path = request.getContextPath();  
	    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";  
		String  uname = request.getParameter("userName");
		String  sid = request.getParameter("sid");
		 String msg = ""; 
		 PrintWriter out = response.getWriter();  
		 if(uname == null || sid ==null || sid.equals("") || uname.equals("")){  
	           msg="链接不完整,请重新生成";  
	           request.setAttribute("msg", msg);
	           request.getRequestDispatcher("/errormsg.jsp").forward(request,response);
	      }else {
			
	    	  ViewDao view = (ViewDao) SpringContextUtil.getBean("view");
	    	  Map<String, Object> map = view.getUserInfo(uname);
	    	  if(MapUtils.getString(map, "username") == null){  
	    		  msg = "链接错误,无法找到匹配用户,请重新申请找回密码.";  
	    		  request.setAttribute("msg", msg);
	    		  request.getRequestDispatcher("/errormsg.jsp").forward(request,response);
	    	  }else if(MapUtils.getString(map, "username") != null){
	    		  Timestamp outDate = Timestamp.valueOf(MapUtils.getString(map, "registerdate"));
	    		  if(outDate.getTime() <= System.currentTimeMillis()){
	    			  msg = "链接已经过期,请重新申请找回密码."; 
	    			  request.setAttribute("msg", msg);
		    		  request.getRequestDispatcher("/errormsg.jsp").forward(request,response);
	    		  }else {
	    			  String key = MapUtils.getString(map, "username")+"$"+outDate.getTime()/1000*1000+"$"+MapUtils.getString(map, "validatacode");
	    			  String digitalSignature = DigestUtils.md5Hex(key); 
	    			  if(!digitalSignature.equals(sid)) { 
	    				  msg = "链接不正确,是否已经过期了?重新申请吧";
	    				  request.setAttribute("msg", msg);
			    		  request.getRequestDispatcher("/errormsg.jsp").forward(request,response);
	    			  }else {//验证成功
	    				  request.getRequestDispatcher("/retrievePwd.jsp?flag='0'").forward(request,response);
					}
	    		  }
	    	  }
				
		} 
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
