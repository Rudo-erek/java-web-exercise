package csai.action;

import java.io.PrintWriter;
import javax.servlet.http.HttpServletResponse;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class ListAction extends ActionSupport {
	private static final long serialVersionUID=2L;
	public String menuList;

	@Override
	public String execute() {
		
		return SUCCESS;
	}

	public void getMenuList() {
		// ActionContext actionContext=ActionContext.getContext();
		// HttpServletRequest response=(HttpServletResponse) actionContext.get(ServletActionContext.HTTP_RESPONSE);
		// Map response=(Map)ActionContext.getContext().get("response");
		String json="{\"menuList\":\"zhixingl\"}";

			// response.getWriter().write(json);
			// response.getWriter().flush();
			// response.getWriter().close();
			ActionContext.getContext().get("response").getWriter().write(json);
			ActionContext.getContext().get("response").getWriter().flush();
			ActionContext.getContext().get("response").getWriter().close();

		return;
	}
}
