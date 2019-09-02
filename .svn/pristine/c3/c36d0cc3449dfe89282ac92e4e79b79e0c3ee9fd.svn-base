package com.jhnu.cas.servlet;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.Properties;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.digest.DigestUtils;

import com.jhnu.util.MailUtils;
import com.jhnu.util.common.SpringContextUtil;
import com.jhnu.util.getSql.ViewDao;

/**
 * Servlet implementation class FindPwd
 */
public class SendMail extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private static final String configFile = "/db.properties";

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
    
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		 response.setContentType("text/html;charset=utf-8");
		 request.setCharacterEncoding("UTF-8");
		 
		 Properties p = new Properties();
			InputStream inStream = this.getClass().getResourceAsStream(configFile);
			p.load(new InputStreamReader(inStream, "UTF-8"));
		String unameString = request.getParameter("username");
		String toemail = request.getParameter("email");//收信人
		String smtp ="smtp.163.com"; //"SMTP服务器";
		String from = p.getProperty("sys.fromEmail").trim();// "发信人";
		String subject ="数据挖掘分析系统"; //"邮件主题";
		String username= p.getProperty("sys.fromUser").trim();//"邮箱用户名";
		String password =  p.getProperty("sys.fromUserPass").trim();//"邮箱密码";
		ViewDao view = (ViewDao) SpringContextUtil.getBean("view");
		String secretKey = UUID.randomUUID().toString(); // 密钥
		Timestamp outDate = new Timestamp(System.currentTimeMillis() + 30 * 60 * 1000);// 30分钟后过期
        long date = outDate.getTime() / 1000 * 1000;// 忽略毫秒数  mySql 取出时间是忽略毫秒数的
        String key = unameString+"$"+date+"$"+secretKey;  
        String digitalSignature = DigestUtils.md5Hex(key);//数字签名 
        view.updateUser(unameString, secretKey, outDate+"");//保存数据
        String path = request.getContextPath();  
        String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";  
        String resetPassHref =  basePath+"resetpassword?sid="+digitalSignature+"&userName="+unameString+"";  
        //邮件内容
        String emailContent = "请勿回复本邮件.点击下面的链接,重设密码<br/><a href="+resetPassHref +" target='_BLANK'>点击我重新设置密码</a>" +  
                "<br/>如非本人操作，请勿点击！本邮件超过30分钟,链接将会自动失效，需要重新申请。<br/> 谢谢。"; 
        boolean isTrue = MailUtils.send(smtp, from, toemail, subject, emailContent, username, password);
        PrintWriter out = response.getWriter();  
        if (isTrue) {
        	out.write("true");
		}else {
			out.write("false");
		}
	}
	

}
