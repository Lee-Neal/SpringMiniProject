package test.com.miniProject.member.model;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import test.com.miniProject.movie.model.MovieVO;

//Component로 어노테이션 걸어두면, 리로드시 자동으로 객체 생성을 하기 때문에 출력이 됨.
//@Component
@Repository
public class MemberDAOimpl implements MemberDAO {
	private static final Logger logger = LoggerFactory.getLogger(MemberDAOimpl.class);// sysout 대신임.

	@Autowired
	SqlSession sqlSession;
	
	public MemberDAOimpl() {
		logger.info("MemberDAOimpl()...");
	}

	@Override
	public int insert(MemberVO vo) {
		logger.info("insert()..." + vo);
		int flag = sqlSession.insert("M_INSERT",vo);

		return flag;
	}

	@Override
	public int update(MemberVO vo) {
		logger.info("update()..." + vo);
		int flag = sqlSession.update("M_UPDATE",vo);

		return flag;
	}

	@Override
	public int delete(MemberVO vo) {
		logger.info("delete()..." + vo);
		int flag = sqlSession.delete("M_DELETE",vo);

		return flag;
	}

	@Override
	public MemberVO idCheck(MemberVO vo) {
		logger.info("idCheck()..." + vo);

		MemberVO vo2 = sqlSession.selectOne("ID_CHECK",vo);

		return vo2;
	}

	@Override
	public MemberVO login(MemberVO vo) {
		logger.info("login..." + vo);

		MemberVO vo2= sqlSession.selectOne("LOGIN", vo);;

		return vo2;
	}

	@Override
	public MemberVO selectOne(MemberVO vo) {
		System.out.println("selectone_impl()..." + vo);
		MemberVO vo2 = sqlSession.selectOne("M_SELECT_ONE", vo);
		System.out.println("selectone_impl()...vo2:" + vo2);

		return vo2;
	}

	@Override
	public int logout(MemberVO vo) {
		logger.info("logout..." + vo);

		int flag = sqlSession.selectOne("LOGOUT", vo);;

		return flag;
	}

}
