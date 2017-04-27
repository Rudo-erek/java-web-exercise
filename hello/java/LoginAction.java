package csai.action;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import csai.DBConn;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class LoginAction extends ActionSupport {
	private static final long serialVersionUID=1L;
	public String userID;
	public String userPassword;
	public String action;
	public String errormsg;

	@Override
	public String execute() {
		if("login".equals(action)) {
			try {
				Connection conn=DBConn.createDBConn();
				String sqlId="select * from user_role where userID=? and userPassword=?";
				PreparedStatement stateId=conn.prepareStatement(sqlId);
				stateId.setString(1,userID);
				stateId.setString(2,userPassword);
				ResultSet rsId=stateId.executeQuery();
				if(rsId.next()) {
					ActionContext.getContext().getSession().put("adminuserid",rsId.getString("userID"));
					ActionContext.getContext().getSession().put("adminusername",rsId.getString("userName"));
					ActionContext.getContext().getSession().put("adminuserpassword",rsId.getString("userPassword"));
					ActionContext.getContext().getSession().put("adminuserrole",rsId.getString("user_auth"));
					DBConn.closeConn(conn);
					return SUCCESS;
				} else {
					conn=DBConn.createDBConn();
					String sqlName="select * from user_role where username=? and userpassword=?";
					PreparedStatement stateName=conn.prepareStatement(sqlName);
					stateName.setString(1,userID);
					stateName.setString(2,userPassword);
					ResultSet rsName=stateName.executeQuery();
					if(rsName.next()) {
						ActionContext.getContext().getSession().put("adminuserid",rsName.getString("userID"));
						ActionContext.getContext().getSession().put("adminusername",rsName.getString("userName"));
						ActionContext.getContext().getSession().put("adminuserpassword",rsName.getString("userPassword"));
						ActionContext.getContext().getSession().put("adminuserrole",rsName.getString("user_auth"));
						DBConn.closeConn(conn);
						return SUCCESS;
					} else {
						errormsg="用户名或密码输入有误！";
					  }
				}
				DBConn.closeConn(conn);
			} catch(Exception e) {
				errormsg=new String("数据库连接有误");
			}
		}
		return INPUT;
	}
}
