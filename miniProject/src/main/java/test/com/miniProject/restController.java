package test.com.miniProject;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import test.com.miniProject.comment.model.CommentVO;
import test.com.miniProject.comment.service.CommentService;
import test.com.miniProject.member.model.MemberVO;
import test.com.miniProject.member.service.MemberSerivce;
import test.com.miniProject.movie.model.MovieVO;
import test.com.miniProject.movie.service.MovieService;
import test.com.miniProject.reservation.model.ReservationVO;
import test.com.miniProject.reservation.service.ReservationService;

/**
 * Handles requests for the application home page.
 */
@Controller
@Slf4j
public class restController {

	@Autowired
	HttpSession session;
	
	@Autowired
	private MemberSerivce service;
	
	@Autowired
	private MovieService mservice;
	
	@Autowired
	private CommentService cservice;
	
	@Autowired
	private ReservationService rservice;

	@RequestMapping(value = "/json_m_selectOne.do", method = RequestMethod.GET,produces = "application/json;charset=UTF-8")
	@ResponseBody
	public MemberVO m_selectOne(MemberVO vo) {
		log.info("m_selectOne()...");

		MemberVO vo2 = service.selectOne(vo);

		return vo2;
	}
	
	@RequestMapping(value = "/Json_movie_selcetOne.do", method = RequestMethod.GET,produces = "application/json;charset=UTF-8")
	@ResponseBody
	public MovieVO movie_selcetOne(MovieVO vo) {
		log.info("movie_selcetOne.do");
		log.info("movie_selcetOne in :{}", vo);

		// selectOne
		MovieVO vo2 = mservice.selectone(vo);
		log.info("movie_selcetOne out :{}", vo2);

		return vo2;
	}

	@RequestMapping(value = "/Json_movie_selectAll.do", method = RequestMethod.GET,produces = "application/json;charset=UTF-8")
	@ResponseBody
	public List<MovieVO> movie_selectAll() {
		log.info("movie_selectAll.do");
		// selectAll,searchList
		List<MovieVO> vos = mservice.selectAll();
		log.info("vos.size():{}", vos.size());
		return vos;
	}
	@RequestMapping(value = "/json_reservation_selectone.do", method = RequestMethod.GET,produces = "application/json;charset=UTF-8")
	@ResponseBody
	public List<ReservationVO> json_reservation_selectone(ReservationVO vo) {
		log.info("reservation_selectone.do");
		log.info("reservation_selectone in :{}", vo);
		
		// selectOne
		List<ReservationVO> vos = rservice.selectone(vo);
		log.info("reservation_selectone out :{}", vos);
		
		return vos;
	}
	
	@RequestMapping(value = "/json_comment_selectAll.do", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public List<CommentVO> comment_selectAll(CommentVO vo) {
	    log.info("/comment_selectAll.do");
	    log.info("mnum: {}", vo.getMnum()); // 로그에 mnum 값이 출력되는지 확인
	    
	    List<CommentVO> vos = cservice.selectAll(vo);

	    // ObjectMapper를 사용하여 JSON 데이터의 출력 형식을 설정
	    ObjectMapper mapper = new ObjectMapper();
	    mapper.setDateFormat(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"));
	    String json = "";
	    try {
			json = mapper.writeValueAsString(vos);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	    log.info("json: {}", json);
	    return vos;
	}
	
	@RequestMapping(value = "/Json_movie_searchList.do", method = RequestMethod.GET,produces ="application/json;charset=UTF-8")
	@ResponseBody
	public List<MovieVO> movie_searchList(String searchKey, String searchWord) {
		log.info("/json_searchList.do");
		log.info("searchKey..{}",searchKey);
		log.info("searchWord..{}",searchWord);
		
		// selectAll,searchList
		List<MovieVO> vos = mservice.searchList(searchKey,searchWord);
		log.info("vos.size():{}", vos.size());
		
		return vos;
	}

	@RequestMapping(value = "/json_result.do", method = RequestMethod.GET,produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Map<String, String> json_result() {
		log.info("json_result()...");

		Map<String, String> map = new HashMap<String, String>();
		map.put("result", "OK");

		return map;
	}

	@RequestMapping(value = "/json_idCheck.do", method = RequestMethod.GET,produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Map<String, String> json_idCheck(MemberVO vo) {
		log.info("json_idCheck()...");
		log.info("{}", vo);

		MemberVO vo2 = service.idCheck(vo);
		log.info("{}", vo2);

		String msg="OK";
		if (vo2 != null) {
			msg = "Not OK";
		} 
		Map<String, String> map = new HashMap<String, String>();
		map.put("result", msg);

		return map;
	}
	
	@RequestMapping(value = "/json_c_insertOK.do", method = RequestMethod.GET,produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Map<String, String> c_insertOK(CommentVO vo) {
		log.info("c_insertOK()...");
		log.info("{}", vo);

		int result = cservice.insertOK(vo);
		log.info("result:{}", result);

		String msg= result ==1? "1" :"0";
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("result", msg);

		return map;
	}
}
