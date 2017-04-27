package csai.action;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import csai.action.DBConn;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class LeftListAction extends ActionSupport{
	private static final long serialVersionUID=2L;

	@Override
	public String execute() {
		ActionContext actionContext=ActionContext.getContext();
		HttpServletRequest request=(HttpServletRequest) actionContext.get(ServletActionContext.HTTP_REQUEST);
		String userName=request.getParameter("userName");
		if(userName!=null && userName.length()!=0) {
//			try {
//				table=new String(table.getBytes("utf-8"),"utf-8");
//			} catch (UnsupportedEncodingException e1) {
//				// TODO Auto-generated catch block
//				e1.printStackTrace();
//			}
		}
		else return SUCCESS;
		try {
			Connection conn=DBConn.createDBConn();
			String sql="select * from user_role where userName=?";
			PreparedStatement state=conn.prepareStatement(sql);
			state.setString(1, userName);
			ResultSet rs=state.executeQuery();
			if(rs.next()) {
				if(rs.getString("user_auth").equals("0")) {
					String sql_menu="select * from menu_left_list";
					PreparedStatement state_menu=conn.prepareStatement(sql_menu);
					ResultSet rs_menu=state_menu.executeQuery();
					getMenuList(rs_menu);
				} else {
					String sql_menu="select * from menu_left_list where menuType=?";
					PreparedStatement state_menu=conn.prepareStatement(sql_menu);		
					state_menu.setString(1, rs.getString("user_auth"));
					ResultSet rs_menu=state_menu.executeQuery();
					getMenuList(rs_menu);
				}
			}
			DBConn.closeConn(conn);
		} catch(Exception e){
			e.printStackTrace();
		}
		return SUCCESS;
	}

	public void getMenuList(ResultSet rs) throws IOException, SQLException {
		ActionContext actionContext=ActionContext.getContext();
		HttpServletResponse response=(HttpServletResponse) actionContext.get(ServletActionContext.HTTP_RESPONSE);
		
		String json0="{";
		String _json[]=new String[50];
		int i=0;
		while(rs.next()) {
			_json[i]="\""+i+"\":\""+rs.getString("menuName")+"\"";
			i++;
		}
		for(int j=0; j<i-1; j++) {
			json0+=_json[j]+",";
		}
		json0+=_json[i-1];
		json0+="}";

		try{
			 ((HttpServletResponse) response).setContentType("text/html;charset=utf-8");
			 ((HttpServletResponse) response).getWriter().write(json0);
			 ((HttpServletResponse) response).getWriter().flush();
			 ((HttpServletResponse) response).getWriter().close();

		} catch(NullPointerException e){
			e.printStackTrace();
		}

		return;
	}
}
