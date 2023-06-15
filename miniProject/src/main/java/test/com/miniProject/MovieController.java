package test.com.miniProject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;

/**
 * Handles requests for the application home page.
 */
@Slf4j
@Controller
public class MovieController {
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "movie.do", method = RequestMethod.GET)
	public String movie() {
		log.info("movie.do...");

		return "movie/movie";
	}
	
	@RequestMapping(value = "movieInfo.do", method = RequestMethod.GET)
	public String movieInfo() {
		log.info("movieInfo.do...");

		return "movie/movieInfo";
	}

}
