package test.com.miniProject.movie.model;

import java.util.List;

public interface MovieDAO {

	public MovieVO selectone(MovieVO vo);

	public List<MovieVO> selectAll();

	public List<MovieVO> searchList(String searchKey, String searchWord);

}
