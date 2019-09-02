package com.jhnu.util.getSql;

import java.util.List;
import java.util.Map;

import com.jhnu.util.common.BaseDao;

public class ViewDao {
	public BaseDao getBaseDao() {
		return baseDao;
	}
	
	public void setBaseDao(BaseDao baseDao) {
		this.baseDao = baseDao;
	}
	private BaseDao baseDao;
	public List<Map<String,Object>> getSys(String userName){
		List<Map<String,Object>> groups=getUserGroups(userName);
		return groups;
	}
	
	public List<Map<String,Object>> getGroups() {
		String sql="select id,name_ name,(select tp.url_ from t_sys_resources tp where t.pid = tp.id) ||url_ url_,shiro_tag shiroTag,istrue from t_sys_resources t where resource_type_code='06' and isshow=1 ";
		return baseDao.getJdbcTemplate().queryForList(sql+" order by order_");
	}
	public List<Map<String,Object>> getUserGroups(String userName) {
		 String sql = "select b.name_ from "+
					   "( select '' name_ ,'1' s  from dual ) a  left join  "+
					   "(select r.name_ ,'1' s  "+
					   "from t_sys_user u, t_sys_role r, t_sys_user_role ur "+
					   "where u.username = ? "+
					   "and u.id = ur.user_id "+
					   "and r.id = ur.role_id "+
					   "and r.istrue = 1 "+ 
					   "and r.ismain=1 ) b on a.s=b.s ";
	      String roolRole = baseDao.getJdbcTemplate().queryForObject(sql, String.class, userName);
	      String where = " where u.username = '"+userName+"' ";
		if("admin".equalsIgnoreCase(roolRole)){
			return getGroups();
		}
		sql = "select id,name_ name,(select tp.url_ from t_sys_resources tp where t.pid = tp.id) ||url_ url_,shiro_tag shiroTag,istrue"
				+ " from t_sys_resources t where resource_type_code='06'";
		sql += " and id in ("
					+ "select case when t.shiro_tag like 'frame%' then t.id||'' else t.sysgroup_ end from t_sys_resources t where t.id in "
					+ "(select rp.resource_id "
						+ " from t_sys_user u, t_sys_role r, t_sys_user_role ur, t_sys_role_perm rp "
						+ where
						+ " and u.id = ur.user_id "
						+ " and r.id = ur.role_id "
						+ " and r.id = rp.role_id "
					+ " union all "
						+ " select up.resource_id "
						+ " from t_sys_user u, t_sys_user_perm up "
						+ where
						+ " and u.id = up.user_id)"
				+ ")";
		return baseDao.getJdbcTemplate().queryForList(sql+" order by order_");
	}
	public Map<String, Object> getUserInfo(String userid) {
		
		String sqlString = "select * from t_sys_user t where t.username = '"+userid+"'";
		List<Map<String, Object>> list = baseDao.getJdbcTemplate().queryForList(sqlString);
		
		Map<String, Object> map = !list.isEmpty() && list.size() >0 ? list.get(0) : null;
		return map;
	}

	public void updateUser(String username,String validatacode,String registerdate) {
		
	    String sql = "update t_sys_user set validatacode='"+validatacode+"',registerdate='"+registerdate+"' where username='"+username+"'";
	    baseDao.getJdbcTemplate().update(sql);
	}
	 public int updatePwd(String username,String salt,String newpwd) {
		  String sql = "update t_sys_user set salt = '"+salt+"',password='"+newpwd+"' where username='"+username+"'";
		   return baseDao.getJdbcTemplate().update(sql);
	}
}
