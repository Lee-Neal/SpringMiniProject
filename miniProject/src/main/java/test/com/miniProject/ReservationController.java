package test.com.miniProject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;
import test.com.miniProject.reservation.model.ReservationVO;
import test.com.miniProject.reservation.service.ReservationService;

/**
 * Handles requests for the application home page.
 */
@Slf4j
@Controller
public class ReservationController {
	
	@Autowired
	ReservationService rservice;
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "reservation.do", method = RequestMethod.GET)
	public String reservation() {
		log.info("reservation.do...");

		return "reservation/reservation";
		
	}
	
	@RequestMapping(value = "r_insertOK.do", method = RequestMethod.POST)
	public String reservation_insertOK(ReservationVO vo) {
		log.info("reservation_insertOK.do...");
		log.info("{}",vo);
		
		String movie_date = vo.getMovie_date().replace("T", " ");
		vo.setMovie_date(movie_date);
		
		int result =rservice.insertOK(vo);
		log.info("result:{}",result);

		if(result==1) {
			return "redirect:reservation.do";
		}else {
			return "redirect:reservation.do";
		}
		
	}
	
	@RequestMapping(value = "r_updateOK.do", method = RequestMethod.GET)
	public String reservation_updateOK(ReservationVO vo) {
		log.info("reservation_updateOK.do...");
		log.info("{}",vo);
		
		String movie_date = vo.getMovie_date().replace("T", " ");
		vo.setMovie_date(movie_date);
		
		int result =rservice.updateOK(vo);
		log.info("result:{}",result);

		if(result==1) {
			return "redirect:reservation.do";
		}else {
			return "redirect:reservation.do";
		}
		
	}
	
	@RequestMapping(value = "r_deleteOK.do", method = RequestMethod.GET)
	public String reservation_deleteOK(ReservationVO vo) {
		log.info("reservation_deleteOK.do...");
		log.info("{}",vo);
		
		int result =rservice.deleteOK(vo);
		log.info("result:{}",result);

		if(result==1) {
			return "redirect:reservation.do";
		}else {
			return "redirect:reservation.do";
		}
		
	}

}
