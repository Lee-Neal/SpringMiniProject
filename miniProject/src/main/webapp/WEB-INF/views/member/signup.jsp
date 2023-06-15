<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>멀티캠퍼스 - 백엔드 11기 - 미니 프로젝트 - 이종관</title>
<style>
.sign--wrap {
	width: 700px;
	padding: 50px;
}

.sign--div {
	display: flex;
	margin-left: 50px;
}

.sign--label {
	width: 100px;
	height: 50px;
	line-height: 50px;
}

.sign--putbox {
	width: 200px;
	hiehgt: 50px;
	line-height: 50px;
}

label {
	font-size: 20px;
}

input {
	height: 30px;
}

input:invalid {
	border: 1px solid red;
}

.sign--submit {
	width: 350px;
	margin-top: 50px;
	text-align: center;
}

.sign--idCheck {
	height: 50px;
	line-height: 50px;
}

#idcheck {
	margin-left:50px;
	width: 300px;
	height:20px;
}
</style>
<jsp:include page="../css.jsp"></jsp:include>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		console.log('onload....');

	});

	function idCheck() {
		console.log('idCheck()....');
		console.log('id:', $("#id").val());
		$.ajax({
			url : "json_idCheck.do",
			data : {
				id : $("#id").val()
			},
			method : 'GET',
			dataType : 'json',
			success : function(response) {
				console.log('ajax...success:', response);
				let msg = response.result === 'OK' ? '사용가능한 아이디입니다.'
						: '사용중인 아이디입니다.'
				$("#idcheck").html(msg);
			},
			error : function(xhr, status, error) {
				console.log('xhr.status:', xhr.status);
			}
		});
	}
	
	function checkPattern() {
	    let input = $("#id").val();
	    let regex = new RegExp('[^A-Za-z0-9]', 'gi');
	    if (input.match(regex)) {
	        $("#idcheck").html("ID는 영문, 숫자만 사용할 수 있습니다.");
	    } else {
	        $("#idcheck").html("");
	    }
	}
</script>
</head>
<body>
	<jsp:include page="../top_menu.jsp"></jsp:include>
	<div class="sign block">
		<div class="sign--wrap">
			<form action="m_insertOK.do" method="POST" accept-charset="utf-8">
				<div class="sign--div">
					<div class="sign--label">
						<label for="ID">아이디</label>
					</div>
					<div class="sign--putbox">
						<input type="text" name="id" id="id" pattern="[A-Za-z0-9]+"
							maxlength="20"  oninput="checkPattern()">
					</div>
					<div class="sign--idCheck">
						<button type="button" onclick="idCheck()">중복확인</button>
					</div>
				</div>
				<div id="idcheck"></div>
				<div class="sign--div">
					<div class="sign--label">
						<label for="PW">비밀번호</label>
					</div>
					<div class="sign--putbox">
						<input type="text" name="pw" id="pw">
					</div>
				</div>
				<div class="sign--div">
					<div class="sign--label">
						<label for="name">닉네임</label>
					</div>
					<div class="sign--putbox">
						<input type="text" name="name" id="name">
					</div>
				</div>
				<div class="sign--div">
					<div class="sign--label">
						<label for="tel">휴대폰</label>
					</div>
					<div class="sign--putbox">
						<input type="text" name="tel" id="tel">
					</div>
				</div>
				<div class="sign--div">
					<div class="sign--label">
						<label for="mail">이메일</label>
					</div>
					<div class="sign--putbox">
						<input type="text" name="mail" id="mail">
					</div>
				</div>
				<div class="sign--submit">
					<input type="submit" value="가입완료">
				</div>
			</form>
		</div>
	</div>
</body>
</html>