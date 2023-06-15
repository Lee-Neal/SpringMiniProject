package test.com.miniProject.comment.model;

import java.util.List;

public interface CommentDAO {

	public int insertOK(CommentVO vo);

	public int updateOK(CommentVO vo);

	public int deleteOK(CommentVO vo);

	public List<CommentVO> selectAll(CommentVO vo);

}
