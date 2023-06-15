package test.com.miniProject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;
import test.com.miniProject.comment.model.CommentVO;
import test.com.miniProject.comment.service.CommentService;

/**
 * Handles requests for the application home page.
 */
@Slf4j
@Controller
public class CommentController {
	@Autowired
	CommentService service;
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "comment_insertOK.do", method = RequestMethod.GET)
	public String comment_insertOK(CommentVO vo) {
		log.info("comment_insertOK.do...");
		log.info("{}",vo);
		
		int result =service.insertOK(vo);
		log.info("result:{}",result);

		if(result==1) {
			return "redirect:movieInfo.do?mnum="+vo.getMnum();
		}else {
			return "redirect:movieInfo.do?mnum="+vo.getMnum();
		}
		
	}
	
	@RequestMapping(value = "comment_updateOK.do", method = RequestMethod.GET)
	public String comment_updateOK(CommentVO vo) {
		log.info("comment_updateOK.do...");
		log.info("{}",vo);
		
		int result =service.updateOK(vo);
		log.info("result:{}",result);

		if(result==1) {
			return "redirect:movieInfo.do?mnum="+vo.getMnum();
		}else {
			return "redirect:movieInfo.do?mnum="+vo.getMnum();
		}
		
	}
	
	@RequestMapping(value = "comment_deleteOK.do", method = RequestMethod.GET)
	public String comment_deleteOK(CommentVO vo) {
		log.info("comment_deleteOK.do...");
		log.info("{}",vo);
		
		int result =service.deleteOK(vo);
		log.info("result:{}",result);

		if(result==1) {
			return "redirect:movieInfo.do?mnum="+vo.getMnum();
		}else {
			return "redirect:movieInfo.do?mnum="+vo.getMnum();
		}
		
	}

}
