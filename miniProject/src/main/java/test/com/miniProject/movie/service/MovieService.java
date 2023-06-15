package test.com.miniProject.movie.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import test.com.miniProject.movie.model.MovieDAO;
import test.com.miniProject.movie.model.MovieVO;

@Service
@Slf4j
public class MovieService {

	@Autowired
	MovieDAO dao;

	public MovieService() {
		log.info("MovieService()...");
	}

	public MovieVO selectone(MovieVO vo) {
		return dao.selectone(vo);
	}

	public List<MovieVO> selectAll() {
		return dao.selectAll();
	}

	public List<MovieVO> searchList(String searchKey, String searchWord) {
		return dao.searchList(searchKey, searchWord);
	}
}
