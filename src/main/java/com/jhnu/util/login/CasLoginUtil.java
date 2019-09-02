package com.jhnu.util.login;

import javax.servlet.http.HttpServletRequest;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.util.StringUtils;

import com.jhnu.cas.entity.LoginResultBean;
import com.jhnu.cas.entity.User;
import com.jhnu.util.common.HttpUtil;
import com.jhnu.util.common.PropertiesUtils;

/**
 * 认证其他CAS
 * @author Administrator
 *
 */
public class CasLoginUtil {
	
	public static LoginResultBean checkLogin(String username,String password,JdbcTemplate jdbcTemplate,HttpServletRequest request){
		String cas_url=PropertiesUtils.getProperties("/sso_me.properties", "cas_url");
		String path = request.getContextPath(); 
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
		String url = cas_url+"/serviceValidate?ticket="+password+"&service="+basePath+"/casSsoLogin";
//		String service = request.getParameter("service");
//		url += (service==null||"".equals(service) ? "" : "?service="+service);
		username=HttpUtil.getNowUser(url);
		System.out.println("***************  username:"+username+";url:"+url);
		
		LoginResultBean lrb = CommonLoginUtil.checkUserName(username,jdbcTemplate);
		
		if(!lrb.getIsTrue()){
			return lrb;
		}
		
		User user=(User)lrb.getObject();
		
		if(!StringUtils.hasLength(username)){
			lrb.setTrue(false);
			lrb.setErrorMas("CAS单点登录认证失败");
			return lrb;
		}
		
    	lrb=CommonLoginUtil.checkIsTrue(user);
    	if(!lrb.getIsTrue()){
    		return lrb;
		}
    	
    	return lrb;
		
	}
	
}
