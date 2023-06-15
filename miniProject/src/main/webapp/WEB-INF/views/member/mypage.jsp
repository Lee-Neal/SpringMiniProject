<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.myPage {
	width: 800px;
	height: 600px;
	margin: 0px 0px 0px 30px;
	display: flex;
	border: 1px solid gray;
}

.myPage__leftTab {
	width: 200px;
	height: 540px;
	margin: 30px;
	border: 1px solid gray;
}

.profileImage {
	width: 100px;
	height: 100px;
	border: 1px solid gray;
	margin: 20px auto;
}

.profileImage--update {
	width: 150px;
	height: 50px;
	line-height: 50px;
	margin: 0 auto;
	text-align: center;
}

.member--delete {
	margin: 200px auto 30px auto;
	text-align: center;
}

.myPage__rightTab {
	width: 510px;
	height: 540px;
	margin: 30px;
}

.infoWrap {
	width: 450px;
	height: 400px;
	margin: 30px;
	display: flex;
	flex-wrap: wrap;
}

.infoKey {
	width: 100px;
	height: 50px;
	line-height: 50px;
}

.infoVal {
	width: 300px;
	height: 50px;
	line-height: 50px;
}

.myPage__info__update {
	text-align: center;
	margin: 0 auto;
}

button {
	height: 40px;
	line-height: 40px;
}

.info__updatebtn, .member--deletebtn, .myPage__info__update {
	width: 100px;
}

input {
	height: 40px;
	line-height: 40px;
}

.myPage__infoVal__id>input {
	border: none;
}
</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
$.ajax({
	url : "json_m_selectOne.do?id=${user_id}",
	method : 'GET',
	dataType : 'json',
	success : function(vo) {
		console.log('ajax...success:', vo);
		let msg = '';
		msg+=`
		<div class="myPage__infoWrap infoWrap">
			<div class="myPage__infoKey infoKey">아이디</div>
			<div class="myPage__infoVal infoVal">\${vo.id}</div>
			<div class="myPage__infoKey infoKey">비밀번호</div>
			<div class="myPage__infoVal infoVal">\${vo.pw}</div>
			<div class="myPage__infoKey infoKey">닉네임</div>
			<div class="myPage__infoVal infoVal">\${vo.name}</div>
			<div class="myPage__infoKey infoKey">휴대폰</div>
			<div class="myPage__infoVal infoVal">\${vo.tel}</div>
			<div class="myPage__infoKey infoKey">이메일</div>
			<div class="myPage__infoVal infoVal">\${vo.mail}</div>
		</div>
		<div class="myPage__info__update">
			<button class="myPage__info__updatebtn info__updatebtn" onclick="m_update()">수정</button>
		</div>
		
		`;
		$(".myPage__rightTab").html(msg);
	},
	error : function(xhr, status, error) {
		
		console.log('xhr.status:', xhr.status);
	}
});

function m_update() {
	$.ajax({
		url : "json_m_selectOne.do?id=${user_id}",
		method : 'GET',
		dataType : 'json',
		success : function(vo) {
			console.log('ajax...success:', vo);
			let update_msg = '';
			update_msg+=`
			<form action="m_updateOK.do" method=POST >
			<div class="myPage__infoWrap infoWrap">
				<div class="myPage__infoKey infoKey">아이디</div>
				<div class="myPage__infoVal__id infoVal">
					<input name="id" type="text" value="\${vo.id}" readonly></div>
				<div class="myPage__infoKey infoKey">비밀번호</div>
				<div class="myPage__infoVal infoVal">
					<input name="pw" type="text" value="\${vo.pw}">
				</div>
				<div class="myPage__infoKey infoKey">닉네임</div>
				<div class="myPage__infoVal infoVal">
					<input name="name" type="text" value="\${vo.name}">
				</div>
				<div class="myPage__infoKey infoKey">휴대폰</div>
				<div class="myPage__infoVal infoVal">
					<input name="tel" type="text" value="\${vo.tel}">
				</div>
				<div class="myPage__infoKey infoKey">이메일</div>
				<div class="myPage__infoVal infoVal">
					<input name="mail" type="text" value="\${vo.mail}">
				</div>
			</div>
			<div class="myPage__info__update">
				<input class="myPage__info__updatebtn info__updatebtn" type=submit value="적용">
			</div>
			</form>
			`;
	
			$(".myPage__rightTab").html(update_msg);
		},
			error : function(xhr, status, error) {
			console.log('xhr.status:', xhr.status);
		}
	});
}


function profileUpdate() {
	$.ajax({
		url : "json_m_selectOne.do?id=${user_id}",
		method : 'GET',
		dataType : 'json',
		success : function(vo) {
		console.log('ajax...success:', vo);
	    let profileupdate_msg = '';
	    profileupdate_msg+=`
    	<form action="profileUpdateOK.do" method="post" enctype="multipart/form-data">
	    	<input name="id" type="text" value="\${vo.id}" hidden>
	    	<input name="num" type="text" value="\${vo.num}" hidden>
	    	<input name="tel" type="text" value="\${vo.tel}" hidden>
	    	<input name="mail" type="text" value="\${vo.mail}" hidden>
	    	<input type="file" name="multipartFile">
	    	<input type="submit" value="수정">
	    </form>
   		`;
	
    	$(".profileImage--update").html(profileupdate_msg);
		}
	})
}
</script>
</head>
<body>
	<jsp:include page="../top_menu.jsp"></jsp:include>
	<h1>마이페이지</h1>
	<div class="myPage block">
		<div class="myPage__leftTab">
			<div class="myPage__profileImage profileImage">
				<img src="resources/member_profile/${user_id}.jpg"
					onerror="this.onerror=null;this.src='resources/member_profile/defaultImg.jpg';"
					width="100px" height="100px">
			</div>
			<div class="myPage__profileImage--update profileImage--update">
				<button onclick="profileUpdate()"
					class="myPage__profileImage--updatebtn profileImage--updatebtn">프로필
					이미지 변경</button>
			</div>
			<div class="myPage__member--delete member--delete">
				<button class="myPage__member--deletebtn member--deletebtn"
				onclick="location.href='m_deleteOK.do?num=${vo.num}'">회원탈퇴</button>
			</div>
		</div>
		<div class="myPage__rightTab"></div>
	</div>
</body>
</html>