package csai.action;

import csai.action.DBConn;
import csai.POJO.LeaveType;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Map;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class GetToDoListAction extends ActionSupport{
	private static final long serialVersionUID=3L;
	public String action;
	public String to_do_Id;
	
	public void setTo_do_Id(String to_do_Id) {
		this.to_do_Id=to_do_Id;
	}
	
	public String getTo_do_Id() {
		return to_do_Id;
	}
	
	public void setAction(String action) {
		this.action=action;
	}
	
	public String getAction() {
		return action;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public String execute() throws Exception{
		
		if("agree".equals(action)) {
			ActionContext.getContext().getSession().put("Result","3");
			Connection conn_agree=DBConn.createDBConn();
			
			Date currentTime=new Date();
			SimpleDateFormat dateFormate=new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
			String operationTime=dateFormate.format(currentTime);
			
			String sql_agree="update to_do_list set done=1, done_time=?, done_person=? where to_do_Id=?";
			PreparedStatement state_agree=conn_agree.prepareStatement(sql_agree);
			state_agree.setString(1, operationTime);
			state_agree.setString(2, (String) ActionContext.getContext().getSession().get("adminusername"));
			state_agree.setInt(3, Integer.parseInt(to_do_Id));
			state_agree.executeUpdate();
			DBConn.closeConn(conn_agree);
			
		}
		
		Connection conn=DBConn.createDBConn();
		String sql="select * from to_do_list where done=?";
		
		PreparedStatement state=conn.prepareStatement(sql);
		if("already_agree".equals(action)) {
			state.setInt(1, 1);
		} else {
			state.setInt(1, 0);
		}
		ResultSet rs=state.executeQuery();
		
		ArrayList<LeaveType> LeaveArray=new ArrayList<LeaveType>();
		PreparedStatement state1;
		ResultSet rs_list;
		int toDoNum=0;
		
		while(rs.next()) {
			sql="select * from leave_list where numberId=?";
			state1=conn.prepareStatement(sql);
			state1.setInt(1, rs.getInt("to_do_Id"));
			rs_list=state1.executeQuery();
			if(rs_list.next()) {
				LeaveType leave=new LeaveType();
				if("already_agree".equals(action)){
					leave.done_time=rs.getString("done_time");
					leave.done_time=(leave.done_time).substring(0, leave.done_time.length()-2);
					leave.done_person=rs.getString("done_person");
				}
				leave.to_do_Id=Integer.toString(rs.getInt("to_do_Id"));
				leave.userID=rs_list.getString("userId");
				leave.userName=rs_list.getString("userName");
				leave.beginDate=rs_list.getString("beginDate");
				leave.endDate=rs_list.getString("endDate");
				leave.writeTime=rs_list.getString("time");
				leave.writeTime=(leave.writeTime).substring(0, leave.writeTime.length()-2);
				LeaveArray.add(leave);
				toDoNum++;
			}
		}
		ActionContext.getContext().getSession().put("toDoNum",toDoNum);
		ActionContext.getContext().getSession().put("Result","0");
		Map<String,ArrayList<LeaveType>> request=(Map<String,ArrayList<LeaveType>>) ActionContext.getContext().get("request");
		request.put("LeaveArray", LeaveArray);
		ActionContext.getContext().getSession().put("Result","1");
		DBConn.closeConn(conn);
		return SUCCESS;
	}
}
