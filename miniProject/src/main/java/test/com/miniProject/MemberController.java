package test.com.miniProject;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;
import test.com.miniProject.member.model.MemberVO;
import test.com.miniProject.member.service.MemberSerivce;


/**
 * Handles requests for the application home page.
 */
@Slf4j
@Controller
public class MemberController {
	@Autowired
	MemberSerivce service;
	
	@Autowired
	HttpSession session;
	
	@Autowired
	ServletContext sContext;
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/signup.do", method = RequestMethod.GET)
	public String signup() {
		log.info("signup.do...");
		
		return "member/signup";
	}
	
	@RequestMapping(value = "/mypage.do", method = RequestMethod.GET)
	public ModelAndView mypage(MemberVO vo) {
	    log.info("mypage.do...");
	    
	    vo.setId((String)session.getAttribute("user_id"));
	    MemberVO vo2 = service.selectOne(vo);

	    ModelAndView modelAndView = new ModelAndView();
	    modelAndView.setViewName("member/mypage");
	    modelAndView.addObject("vo", vo2);
	    log.info("mypage.do... output{}",vo2);
	    
	    return modelAndView;
	}

	
	@RequestMapping(value = "/login.do", method = RequestMethod.GET)
	public String login() {
		log.info("login.do...");
		
		return "member/login";
	}
	
	@RequestMapping(value = "/m_insertOK.do", method = RequestMethod.POST)
	public String m_insertOK(MemberVO vo) {
		log.info("m_insertOK.do...");
		log.info("{}",vo);
		
		int result =service.insertOK(vo);
		log.info("result:{}",result);

		if(result==1) {
			return "redirect:home.do";
		}else {
			return "redirect:m_insert.do";
		}
		
	}
	
	@RequestMapping(value = "/m_updateOK.do", method = RequestMethod.POST)
	public String m_updateOK(MemberVO vo) {
		log.info("m_updateOK.do...");
		log.info("{}",vo);
		
		int result =service.update(vo);
		log.info("result:{}",result);

		if(result==1) {
			return "redirect:mypage.do";
		}else {
			return "redirect:mypage.do";
		}
		
	}
	
	@RequestMapping(value = "/m_deleteOK.do", method = RequestMethod.GET)
	public String m_deleteOK(MemberVO vo) {
		log.info("m_deleteOK.do...");
		log.info("{}",vo);
		
		int result =service.delete(vo);
		log.info("result:{}",result);

		if(result==1) {
			return "redirect:logout.do";
		}else {
			return "redirect:mypage.do";
		}
		
	}
	@RequestMapping(value = "/loginOK.do", method = RequestMethod.POST)
	public String loginOK(MemberVO vo) {
		log.info("loginOK.do...{}",vo);
		
		MemberVO vo2=service.login(vo);
		if(vo2!=null) {
			session.setAttribute("user_id", vo.getId());
			session.setMaxInactiveInterval(5*60);
			return "redirect:home.do";
		}else {
			return "redirect:login.do";
		}
		
	}
	
	@RequestMapping(value = "/logout.do", method = RequestMethod.GET)
	public String logout() {
		log.info("logout.do...");
		session.invalidate();
		
		return "home";
	}

	// fileupload >> enctype으로 form-data를 multipart로 전송하겠다 >> 무조건 POST방식.
	@RequestMapping(value = "/profileUpdateOK.do", method = RequestMethod.POST)
	public String profileUpdateOK(MemberVO vo) throws IllegalStateException, IOException {
		log.info("profileUpdateOK()...{}",vo);
		
		String getOriginalFilename = vo.getMultipartFile().getOriginalFilename();
		int fileNameLength = vo.getMultipartFile().getOriginalFilename().length();
		log.info("getOriginalFilename:{}",getOriginalFilename);
		log.info("fileNameLength:{}",fileNameLength);
		
		if(getOriginalFilename.length()==0) {
		}else {
			//웹 어플리케이션이 갖는 실제 경로: 이미지를 업로드할 대상 경로를 찾아서 파일저장.
		    String realPath = sContext.getRealPath("resources/member_profile");
		    log.info("realPath : {}",realPath);

		    // 파일 확장자 추출
		    String extension = FilenameUtils.getExtension(vo.getMultipartFile().getOriginalFilename());

		    File f = new File(realPath + "\\" + vo.getId() + ".jpg");
		    log.info("f : {}",f);
		    vo.getMultipartFile().transferTo(f);

		    // 이미지 파일 쓰기
		    BufferedImage image = ImageIO.read(f);
		    ImageIO.write(image, extension, f);

		}

	    return "redirect:mypage.do";
	}
	
}
