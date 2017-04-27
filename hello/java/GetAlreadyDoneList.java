package csai.action;

import csai.action.DBConn;
import csai.POJO.LeaveType;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Map;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class GetAlreadyDoneListAction extends ActionSupport{
	private static final long serialVersionUID=4L;
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
		
		Connection conn=DBConn.createDBConn();
		String sql="select * from to_do_list where done=? order by done_time";
		
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
			}
		}
//		ActionContext.getContext().getSession().put("Result","0");
		Map<String,ArrayList<LeaveType>> request=(Map<String,ArrayList<LeaveType>>) ActionContext.getContext().get("request");
		request.put("LeaveArray", LeaveArray);
		ActionContext.getContext().getSession().put("Result","1");
		DBConn.closeConn(conn);
		return SUCCESS;
	}
}
