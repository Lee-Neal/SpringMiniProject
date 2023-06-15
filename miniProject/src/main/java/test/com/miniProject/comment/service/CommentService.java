package test.com.miniProject.comment.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import test.com.miniProject.comment.model.CommentDAO;
import test.com.miniProject.comment.model.CommentVO;

//@Component
@Service
@Slf4j
public class CommentService {

	@Autowired
	CommentDAO dao;

	public CommentService() {
		log.info("CommentService()...");
	}

	public int insertOK(CommentVO vo) {
		return dao.insertOK(vo);
	}

	public int updateOK(CommentVO vo) {
		return dao.updateOK(vo);
	}

	public int deleteOK(CommentVO vo) {
		return dao.deleteOK(vo);
	}
	
	public List<CommentVO> selectAll(CommentVO vo) {
		return dao.selectAll(vo);
	}
	
}
