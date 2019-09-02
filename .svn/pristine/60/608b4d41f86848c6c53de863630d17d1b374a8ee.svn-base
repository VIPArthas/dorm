package com.jhnu.util.login;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.jdbc.core.JdbcTemplate;

import com.jhnu.cas.entity.LoginResultBean;
import com.jhnu.cas.entity.User;
import com.jhnu.util.catche.MacForPassCache;
import com.jhnu.util.common.IpMacUtil;
import com.jhnu.util.common.PasswordHelperUtil;
import com.jhnu.util.common.PropertiesUtils;

/**
 * 简单的oAuth认证（不是oAuth）
 * 
 * @author xuebl
 * @date 2017年6月6日 下午6:07:12
 */
public class OAuthSimpleUtil {


	public static LoginResultBean checkLogin(String username,String password, String appid, String redirect_uri,
			JdbcTemplate jdbcTemplate,HttpServletRequest resquest){
		LoginResultBean jrb = new LoginResultBean(username);
		// 验证 appid和redirect_uri
		if(appid == null || redirect_uri == null || "".equals(appid) || "".equals(redirect_uri)){
			jrb.setErrorMas("appid或redirect_uri为空");
			jrb.setTrue(false);
			return jrb;
		}
		String redirect_uri2 = PropertiesUtils.getProperties("/oAuthSimple.properties", appid);
		if(!redirect_uri.equals(redirect_uri2)){
			jrb.setErrorMas("redirect_uri不合法");
			jrb.setTrue(false);
			return jrb;
		}
		LoginResultBean lrb = CommonLoginUtil.checkUserName(username,jdbcTemplate);
		if(!lrb.getIsTrue()){
			return lrb;
		}
		
		User user=(User)lrb.getObject();
		lrb=checkPassword(user,password);
		if(!lrb.getIsTrue()){
			return lrb;
		}
		
    	lrb=CommonLoginUtil.checkIsTrue(user);
    	if(!lrb.getIsTrue()){
    		return lrb;
		}
		
		return lrb;
	}
	
	private static LoginResultBean checkPassword(User user,String password){
		String errormsg="";
		String username=user.getUsername();
		LoginResultBean jrb=new LoginResultBean();
		String ip=IpMacUtil.getIp();
		if(MacForPassCache.isFreeze(ip, username)){
			Map<String,Long> usermap=MacForPassCache.getFreezeInfo(ip, username);
			errormsg="暂处于冻结状态！请于"+usermap.get("secs")+"分钟后再次登陆！如忘记密码，请联系管理员";
			jrb.setTrue(false);
		}else if(!user.getPassword().equals(getSaltPassword(username+user.getSalt(), password))){
			MacForPassCache.setFreeze(ip, username);
			Map<String,Long> usermap=MacForPassCache.getFreezeInfo(ip, username);
			errormsg="密码错误！错误次数"+usermap.get("cs")+",请核对后修改！";
			jrb.setTrue(false);
		}else{
			MacForPassCache.moveFreeze(ip, username);
		}
		jrb.setErrorMas(errormsg);
		return jrb;
	}
	
	private static String getSaltPassword(String UserNameSalt,String password) {
		return PasswordHelperUtil.simpleEncryptPassword(UserNameSalt,password);
	}
	
}
