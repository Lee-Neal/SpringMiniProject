package test.com.miniProject.comment.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;

//Component로 어노테이션 걸어두면, 리로드시 자동으로 객체 생성을 하기 때문에 출력이 됨.
//@Component
@Repository
@Slf4j
public class CommentDAOimpl implements CommentDAO {

	@Autowired
	SqlSession sqlSession;

	public CommentDAOimpl() {
		log.info("CommentDAOimpl()...");
	}

	@Override
	public int insertOK(CommentVO vo) {
		log.info("insert()..." + vo);
		int flag = sqlSession.insert("C_INSERT", vo);

		return flag;
	}

	@Override
	public int updateOK(CommentVO vo) {
		log.info("update()..." + vo);
		int flag = sqlSession.update("C_UPDATE", vo);

		return flag;
	}

	@Override
	public int deleteOK(CommentVO vo) {
		log.info("delete()..." + vo);
		int flag = sqlSession.delete("C_DELETE", vo);

		return flag;
	}

	@Override
	public List<CommentVO> selectAll(CommentVO vo) {
		log.info("selectAll()...{}",vo);
		List<CommentVO> vos = sqlSession.selectList("C_SELECTALL",vo);

		return vos;

	}// end selectAll

}
