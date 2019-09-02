package com.jhnu.cas.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.constraints.Null;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.collections.MapUtils;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.jhnu.util.common.SpringContextUtil;
import com.jhnu.util.getSql.ViewDao;

/**
 * Servlet implementation class CheckLink
 */
public class CheckUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckUser() {
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
		String  uname = request.getParameter("username");
		String  idcard = request.getParameter("idcard");
		ViewDao view = (ViewDao) SpringContextUtil.getBean("view");
		Map<String, Object> map = view.getUserInfo(uname);
		PrintWriter out = response.getWriter();  
		JSONArray jArray  = new JSONArray(); 
		if (map != null) {
			String idno = MapUtils.getString(map, "id_no");
			if(uname.equals("admin")){
				jArray.add(0, "true");//管理员无需验证身份号
			}else {
				
				if (idno == null || "".equals(idno)) {
					jArray.add(0, "noidcard");
				}else {
					if (idcard.equals(idno)) {//身份证号相同
						jArray.add(0, "true");
					}else {
						jArray.add(0, "false");
					}
				}
			}
		}else {
			jArray.add(0, "nouser");
		}
		out.write(jArray.toString());
		
	}

}
