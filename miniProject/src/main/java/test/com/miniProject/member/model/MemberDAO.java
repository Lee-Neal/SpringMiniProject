package test.com.miniProject.member.model;

public interface MemberDAO {

	public int insert(MemberVO vo);

	public int update(MemberVO vo);

	public int delete(MemberVO vo);
	
	public MemberVO selectOne(MemberVO vo);

	public MemberVO idCheck(MemberVO vo);

	public MemberVO login(MemberVO vo);
	
	public int logout(MemberVO vo);

}
