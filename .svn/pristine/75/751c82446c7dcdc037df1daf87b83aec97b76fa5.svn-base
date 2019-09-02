package com.jhnu.cas.login;

import java.io.IOException;
import java.lang.reflect.Method;
import java.security.GeneralSecurityException;
import java.sql.SQLException;
import java.util.Date;
import java.util.UUID;

import javax.security.auth.login.FailedLoginException;
import javax.servlet.http.HttpServletRequest;

import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.jasig.cas.adaptors.jdbc.AbstractJdbcUsernamePasswordAuthenticationHandler;
import org.jasig.cas.authentication.HandlerResult;
import org.jasig.cas.authentication.PreventedException;
import org.jasig.cas.authentication.UsernamePasswordCredential;
import org.jasig.cas.authentication.principal.SimplePrincipal;
import org.springframework.jdbc.CannotGetJdbcConnectionException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.util.StringUtils;

import com.jhnu.cas.entity.LoginResultBean;
import com.jhnu.util.common.ContextHolderUtils;
import com.jhnu.util.common.DateUtils;
import com.jhnu.util.common.HttpRequestDeviceUtils;
import com.jhnu.util.common.IpMacUtil;
import com.jhnu.util.common.PropertiesUtils;

public class DefaultDatabaseAuthenticationHandler extends AbstractJdbcUsernamePasswordAuthenticationHandler {


	@Override
    protected HandlerResult authenticateUsernamePasswordInternal(UsernamePasswordCredential credential)
            throws GeneralSecurityException, PreventedException {
    	HttpServletRequest request=ContextHolderUtils.getRequest();
    	String autoType=request.getParameter("autoType");
    	final String username = credential.getUsername();
        final String password = credential.getPassword();
    	if("null".equals(autoType) || !StringUtils.hasText(autoType)){
    		autoType="default";
    	}
    	LoginResultBean lrb = new LoginResultBean();
    	try {
    		String classPath=PropertiesUtils.getProperties("/sso_me.properties", autoType);
			Class<?> c= Class.forName(classPath);
			// 简单的 oAuth 认证（不是oAuth） 20170608
			if(autoType.equals("oauthsimple")){
		    	final String appid = request.getParameter("appid");
		        final String redirect_uri = request.getParameter("redirect_uri");
				Method m= c.getMethod("checkLogin",new Class[] { String.class,String.class,String.class,String.class,JdbcTemplate.class,HttpServletRequest.class });
				lrb =(LoginResultBean)m.invoke(c.getClass(), username, password, appid, redirect_uri, getJdbcTemplate(), request);
			}else{
				Method m= c.getMethod("checkLogin",new Class[] { String.class,String.class,JdbcTemplate.class,HttpServletRequest.class });
				lrb =(LoginResultBean)m.invoke(c.getClass(),username, password,  getJdbcTemplate(), request);
			}
		} catch (Exception e) {
			e.printStackTrace();
			if(e.getCause()!=null&&e.getCause().getClass()==CannotGetJdbcConnectionException.class){
				request.setAttribute("errormsg", "数据库连接异常，请联系管理员");
				throw new FailedLoginException();
			}else if(e.getCause()!=null&&e.getCause().getCause()!=null&&e.getCause().getCause().getClass()==SQLException.class){
				request.setAttribute("errormsg", "数据库查询异常，请联系管理员");
				throw new FailedLoginException();
			}else{
				request.setAttribute("errormsg", "出现异常，请联系管理员");
				throw new FailedLoginException();
			}
		} 
    	if(!lrb.getIsTrue()){
			request.setAttribute("errormsg", lrb.getErrorMas());
			throw new FailedLoginException();
		}
    	credential.setUsername(lrb.getUsername());
    	
    	try{
	    	final String SQL = "insert into T_SYS_USER_LOGIN_LOG values(?,?,?,?,?,?)";
	        String id=UUID.randomUUID().toString().replace("-", "0");
	        getJdbcTemplate().update(SQL, new Object[]{id,lrb.getUsername(),DateUtils.SSS.format(new Date()),
	        		autoType,HttpRequestDeviceUtils.getLoginType(request),IpMacUtil.getIp()});
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    	// 简单oAuth回调http请求  20170608
    	if(autoType.equals("oauthsimple")){
    		HttpClient client = new DefaultHttpClient();  
	    	final String appid = request.getParameter("appid");
    		String redirect_uri = request.getParameter("redirect_uri");
    		if(redirect_uri.endsWith("/")){
    			redirect_uri = redirect_uri.substring(0, redirect_uri.length()-1);
    		}
    		HttpGet httpGet = new HttpGet(redirect_uri+"?state=1&oppenid="+lrb.getUsername());
    		try {
				client.execute(httpGet);
			} catch (ClientProtocolException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				logger.info("oAuth已授权成功；appid="+appid+",redirect_uri="+redirect_uri);
			}
    	}
    	return createHandlerResult(credential, new SimplePrincipal(lrb.getUsername()), null);
    }
	
}
