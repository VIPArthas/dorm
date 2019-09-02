package com.jhnu.cas.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.MapUtils;
import org.apache.shiro.crypto.RandomNumberGenerator;
import org.apache.shiro.crypto.SecureRandomNumberGenerator;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.util.ByteSource;

import com.alibaba.fastjson.JSONArray;
import com.jhnu.cas.entity.User;
import com.jhnu.util.common.SpringContextUtil;
import com.jhnu.util.getSql.ViewDao;

/**
 * Servlet implementation class CheckLink
 */
public class ChangePwd extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private RandomNumberGenerator randomNumberGenerator = new SecureRandomNumberGenerator();
 
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChangePwd() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 request.setCharacterEncoding("UTF-8");
		 response.setContentType("text/html;charset=utf-8");
		String  uname = request.getParameter("username");//账户
		String  newpwd = request.getParameter("newpwd");//新密码
		ViewDao view = (ViewDao) SpringContextUtil.getBean("view");
		//密码加密
		String salt = randomNumberGenerator.nextBytes().toHex();
		String credentialsSalt = uname+salt;
		String newPassword = new SimpleHash(
                "md5",
                newpwd,
                ByteSource.Util.bytes(credentialsSalt),
                2).toHex();
		int flag = view.updatePwd(uname, salt, newPassword);
		PrintWriter out = response.getWriter();  
		if (flag > 0 ) {
			out.write("true");
		}else {
			out.write("false");
		}
		
	}
	 
}
