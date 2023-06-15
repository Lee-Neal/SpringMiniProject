package test.com.miniProject.member.service;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import test.com.miniProject.member.model.MemberDAO;
import test.com.miniProject.member.model.MemberVO;

//@Component
@Service
@Slf4j
public class MemberSerivce {

	@Autowired
	MemberDAO dao;
	
	@Autowired
	HttpSession session;
	public MemberSerivce() {
		log.info("MemberSerivce()...");
	}

	public int insertOK(MemberVO vo) {
		return dao.insert(vo);
	}

	public int update(MemberVO vo) {
		return dao.update(vo);
	}

	public int delete(MemberVO vo) {
		return dao.delete(vo);
	}

	public MemberVO login(MemberVO vo) {
		return dao.login(vo);
	}

	public int logout(MemberVO vo) {
		return dao.logout(vo);
	}

	public MemberVO idCheck(MemberVO vo) {
		return dao.idCheck(vo);
	}

	public MemberVO selectOne(MemberVO vo) {
		
		return dao.selectOne(vo);

	}
}
