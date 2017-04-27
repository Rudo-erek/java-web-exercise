package csai.action;

import csai.action.DBConn;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class WriteLeaveTimeAction extends ActionSupport {
	private static final long serialVersionUID=3L;
	public String userID;
	public String userName;
	public String beginDate;
	public String endDate;
	public String writeTime;

	@Override
	public String execute() {
		Date currentTime=new Date();
		SimpleDateFormat dateFormate=new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		writeTime=dateFormate.format(currentTime);
		if(userID!=null && userName!=null && beginDate!=null && endDate!=null) {
			try {
				Connection conn=DBConn.createDBConn();
				String sql = "insert into leave_list(userId,userName,beginDate,endDate,time) values(?,?,?,?,?)";
				PreparedStatement state=conn.prepareStatement(sql);
				state.setString(1, userID);
				state.setString(2, userName);
				state.setString(3, beginDate);
				state.setString(4, endDate);
				state.setString(5, writeTime);
				state.executeUpdate();
				
				sql="select numberId from leave_list where userId=? and time=?";
				state=conn.prepareStatement(sql);
				state.setString(1, userID);
				state.setString(2, writeTime);
				ResultSet rs=state.executeQuery();
				if(rs.next()) {
					sql="insert into to_do_list(to_do_Id,done) values(?,?)";
					state=conn.prepareStatement(sql);
					state.setInt(1, rs.getInt("numberId"));
					state.setInt(2, 0);
					state.executeUpdate();
				}
				
				ActionContext.getContext().getSession().put("writeResult","1");
				DBConn.closeConn(conn);
				return SUCCESS;
			} catch(Exception e) {
				ActionContext.getContext().getSession().put("writeResult","0");
				return INPUT;
			}
		} else {
			ActionContext.getContext().getSession().put("writeResult","2");
			return INPUT;
		}

	}
}
