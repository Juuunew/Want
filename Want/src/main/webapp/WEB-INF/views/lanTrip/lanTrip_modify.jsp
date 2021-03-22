<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ page import="com.exam.model1.lantrip.LanTripTO" %>
<%@ page import="com.exam.model1.lantrip.LanTripDAO" %>
<%@ page import="java.util.ArrayList"%>

<%
	request.setCharacterEncoding( "utf-8" );
	String cpage = request.getParameter( "cpage" );
	
	LanTripTO to = (LanTripTO)request.getAttribute("to");
	
	String no = to.getNo();
	String subject = to.getSubject();
	String content = to.getContent().replaceAll("\n","<br />");
	String writer = to.getWriter();
	String wdate = to.getWdate();
	String hit = to.getHit();
	String location = to.getLocation();
	String video = to.getVideo();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, intial-scale=1.0">
<title>Insert title here</title>
	
<jsp:include page="../include/index.jsp"></jsp:include>

<!-- Summernote -->
<script src="./summernote/summernote-lite.js"></script>
<script src="./summernote/lang/summernote-ko-KR.js"></script>

<!-- Summernote CSS File -->
<link rel="stylesheet" href="./summernote/summernote-lite.css">

<!-- CSS File -->
<link href="./resources/css/picture_write.css" rel="stylesheet">
<link href="./resources/css/navbar.css" rel="stylesheet">
<style type="text/css">

.video {
	display : block;
   	text-align: center;   	
   	margin-top : 50px;   		
}

</style>

<script type="text/javascript">
	window.onload = function() {
		
		// '등록하기' 버튼 클릭시 모두 입력되었는지 검사
		document.getElementById('submit1').onclick = function() {
			if (document.mfrm.subject.value.trim() == "") {
				alert('제목을 입력하셔야 합니다.');
				return false;
			}

			if (document.mfrm.location.value.trim() == "(선택 안함)") {
				alert('위치를 입력하셔야 합니다.');
				return false;
			}


			// 파일 업로드 확인 메세지
			if (document.mfrm.video.value.trim() == "") {
				alert('파일을 입력하셔야 합니다.');
				return false;
			} else {
				const extension = document.mfrm.video.value.split('.').pop();
				if (extension != 'png' && extension != 'jpg'
						&& extension != 'gif' && extension != 'mp4'&& extension != 'PNG'&& extension != 'JPG'&& extension != 'GIF'&& extension != 'MP4'&& extension != 'MOV'&& extension != 'mov') {
					alert('이미지나 동영상 파일을 입력하셔야 합니다.');
					return false;
				}
			}
			
			// 웹 에디터(썸머노트) 입력확인
			if (document.mfrm.content.value.trim() == "") {
				alert('내용을 입력하셔야 합니다.');
				return false;
			} 
			
			document.mfrm.submit();
			
			
		};
		
		// 파일을 선택하면 파일명이 뜨도록 함
		var file_input_container = $('.js-input-file');
		if (file_input_container[0]) {
			file_input_container.each(function() {

				var that = $(this);

				var fileInput = that.find(".input-file");
				var info = that.find(".input-file__info");

				fileInput.on("change", function() {

					var fileName;
					fileName = $(this).val();

					if (fileName.substring(3, 11) == 'fakepath') {
						fileName = fileName.substring(12);
					}

					if (fileName == "") {
						info.text("No file chosen");
					} else {
						info.text(fileName);
					}

				})

			});
		}
		
		// Summernote 설정
		var toolbar = [
		    // 글꼴 설정
		    ['fontname', ['fontname']],
		    // 글자 크기 설정
		    ['fontsize', ['fontsize']],
		    // 굵기, 기울임꼴, 밑줄,취소 선, 서식지우기
		    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
		    // 글자색
		    ['color', ['forecolor','color']],
		    // 표만들기
		    ['table', ['table']],
		    // 글머리 기호, 번호매기기, 문단정렬
		    ['para', ['ul', 'ol', 'paragraph']],
		    // 줄간격
		    ['height', ['height']],
		    // 그림첨부, 링크만들기, 동영상첨부
		    //['insert',['picture','link','video']],
		    //['insert',['link']],
		    // 코드보기, 확대해서보기, 도움말
		    ['view', ['codeview','fullscreen', 'help']]
		  ];
		
		let setting = {
				height: 300,                 // 에디터 높이
				  minHeight: null,             // 최소 높이
				  maxHeight: null,             // 최대 높이
				  focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
				  lang: "ko-KR",					// 한글 설정
				  placeholder: '최대 2048자까지 쓸 수 있습니다'	//placeholder 설정
		}
		$('.summernote').summernote(setting);
		
	};
	

</script>

</head>
<body>
	<!-- 메뉴바 
		 현재페이지 뭔지 param.thisPage에 넣어서 navbar.jsp에  던짐 -->
	<jsp:include page="../include/navbar.jsp">
		<jsp:param value="lanTrip_list" name="thisPage" />
	</jsp:include>
	
	<br /><br /><br />	
	
	<form action="lanTrip_modify_ok.do?cpage=<%=cpage %>" method="post" name="mfrm" enctype="multipart/form-data">
	<input type="hidden" name="no" value=<%=no %> />
	<div class="page-wrapper bg-light p-t-100 p-b-50">
		<div class="wrapper wrapper--w900">
			<div class="card card-6">

				<div class="card-heading">
					<h2 class="title">랜선여행을 떠나요!</h2>
				</div>
				<div class="card-body">
					<form action="./lanTrip_write_ok.do" method="post" name="wfrm" enctype="multipart/form-data">
						
						<c:choose>
							<c:when test="${empty sessionScope.id }">
								<input type="hidden" name="writer" value="${kakaoid}" />
							</c:when>
							<c:otherwise>
								<input type="hidden" name="writer" value="${id}" />
							</c:otherwise>
						</c:choose>
						
						<div class="form-row">
							<div class="name">제목</div>
							<div class="value">
								<input class="input--style-6" type="text" name="subject" value=<%=subject %>>
							</div>
						</div>
						<div class="form-row">
							<div class="name">위치</div>
							<div class="value">
								<label for="location">국가</label> 
								<select id="location" name="location" class="form-select" value="<%=location %>">
									<option>(선택 안함)</option>
									<option>영국</option>
									<option>프랑스</option>
									<option>독일</option>
									<option>이탈리아</option>
									<option>스위스</option>
									<option>그리스</option>
									<option>스페인</option>
									<option>포르투갈</option>
									<option>체코</option>
									<option>헝가리</option>
									<option>오스트리아</option>
									<option>스웨덴</option>
									<option>핀란드</option>
									<option>폴란드</option>
								</select>
							</div>
						</div>
						<div class="form-row">
							<div class="name">파일 업로드</div>
							<div class="value">
								<div class="input-group js-input-file">
									<input class="input-file" type="file" name="video" id="file">
									<label class="label--file" for="file">파일 선택</label> <span
										class="input-file__info">No file chosen</span>
								</div>
								<div class="label--desc">여행 사진 or 동영상을 업로드하세요. 최대파일 크기는
									00MB입니다.</div>
							</div>
						</div>
						
						<div class="form-row">
							<div class="name">내용</div>
							<div class="value">
								<div class="summernote-group">
									<textarea class="summernote" name="content" id="content"><%=content %></textarea>
								</div>
							</div>
						</div>
					</form>
				</div>
				<div class="card-footer">
					<button class="btn btn--radius-2 btn--blue-2" type="submit"
						id="submit1" >등록하기</button>
				</div>
			</div>
		</div>
	</div>
	</form>
	 <div class="btn_area">
			<div class="align_left">
				<input type="button" value="목록" class="btn_list btn_txt02" style="cursor: pointer;" onclick="location.href='lanTrip_list.do'" />
			</div>
			<div class="align_right">
				<input type="button" value="삭제" class="btn_list btn_txt02" style="cursor: pointer;" onclick="location.href='lanTrip_delete_ok.do?no=<%=request.getParameter("no") %>'" />
				<input type="button" value="쓰기" class="btn_write btn_txt01" style="cursor: pointer;" onclick="location.href='lanTrip_write.do'" />
			
			
	</div>	
</body>
</html>