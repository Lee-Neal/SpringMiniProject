package test.com.miniProject.movie.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MovieDAOimpl implements MovieDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	public MovieDAOimpl() {
		System.out.println("MovieDAOimpl()...");
	}


	@Override
	public MovieVO selectone(MovieVO vo) {
		System.out.println("selectone()..." + vo);
		MovieVO vo2 = sqlSession.selectOne("MOVIE_SELECT_ONE", vo);
		

		return vo2;
	}

	@Override
	public List<MovieVO> selectAll() {
		System.out.println("selectAll()...");
		List<MovieVO> vos = sqlSession.selectList("MOVIE_SELECT_ALL");
		
		return vos;
	}

	@Override
	public List<MovieVO> searchList(String searchKey, String searchWord) {
		System.out.println("searchList()...searchKey" + searchKey);
		System.out.println("searchList()...searchWord" + searchWord);
		
		List<MovieVO> vos = null;
		
		if(searchKey.equals("DIRECTOR")) {
			vos = sqlSession.selectList("MOVIE_SEARCH_LIST_DIRECTOR", "%"+searchWord+"%");			
		}else if(searchKey.equals("TITLE")){
			vos = sqlSession.selectList("MOVIE_SEARCH_LIST_TITLE", "%"+searchWord+"%");			
		}
		System.out.println(vos);
		return vos;
	}

	}


