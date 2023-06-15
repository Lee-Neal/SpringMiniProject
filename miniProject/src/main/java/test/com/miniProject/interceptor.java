package test.com.miniProject;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class interceptor extends HandlerInterceptorAdapter {

	@Autowired
	HttpSession session;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		log.info("preHandle()...");

		String sPath=request.getServletPath();
		log.info("preHandle-ServletPath...{}",sPath);
		
		String user_id = (String) session.getAttribute("user_id");
		log.info("preHandle()-session...{}",user_id);
		
		if(sPath.equals("/comment_insertOK.do")||sPath.equals("/reservation.do")||sPath.equals("/mypage.do")
				||sPath.equals("/comment_updateOK.do")||sPath.equals("/comment_deleteOK.do")
				
				) {
			
			if(user_id==null) {
			response.sendRedirect("login.do");
			return false;
			}
		}
		
		return true;
	}

//	@Override
//	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
//			ModelAndView modelAndView) throws Exception {
//		log.info("postHandle()...");
//
//	}

}
