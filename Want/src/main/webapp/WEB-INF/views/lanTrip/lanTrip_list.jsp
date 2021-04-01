<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ page import="com.exam.model1.lantrip.LanTripTO"%>
<%@ page import="com.exam.model1.lantrip.LanTripListTO"%>
<%@ page import="java.util.ArrayList"%>

<%
	LanTripListTO listTO = (LanTripListTO) request.getAttribute("listTO");
	String nick = (String)session.getAttribute( "nick" );	

	int cpage = listTO.getCpage();
	int recordPerPage = listTO.getRecordPerPage();
	int totalRecord = listTO.getTotalRecord();
	int totalPage = listTO.getTotalPage();
	int blockPerPage = listTO.getBlockPerPage();
	int startBlock = listTO.getStartBlock();
	int endBlock = listTO.getEndBlock();
	
	ArrayList<LanTripTO> boardLists = listTO.getBoardLists();
	
	StringBuffer sbHtml = new StringBuffer();
	
	int rowCount = 0;
	for (LanTripTO to : boardLists) {
		String no = to.getNo();
		String subject = to.getSubject();
		String writer = to.getWriter();
		String video = "./upload/lanTrip/" + to.getVideo();
		String wdate = to.getWdate();
		String location = to.getLocation();
		String reply = to.getReply();
		String hit = to.getHit();
	
		if (rowCount % 4 == 0) {
			sbHtml.append("<div class='row'>");
		}
	
		sbHtml.append( "<div class='col-lg-3 col-md-6'> ");
		sbHtml.append( "	<div class='card'>");
		sbHtml.append( "		<a href='./lanTrip_view.do?no=" + no + "'><video src='" + video + "' class='card-img-top' controls></video></a>");
		sbHtml.append( "			<div class='card-body'>");
		sbHtml.append( "				<h3 class='card-title'>" + writer + "</h3>");
		sbHtml.append( "				<p class='card-text'>" + subject + "</p>");
		sbHtml.append( "			</div>");
		sbHtml.append( "			<div class='lan-heart'>");
		 // 로그인 상태아닐 때 하트 클릭안됨
	      if( nick == null ) {
	         sbHtml.append( "         <svg class='heart3' xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-suit-heart' viewBox='0 0 16 16'>" );
	         sbHtml.append( "              <path d='M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z' />" );
	         sbHtml.append( "         </svg>" );
	      } else {       //로그인 상태에서 빈 하트일때 
	         if( to.getHno() == null ) {
	        	sbHtml.append( "            <a idx='"+to.getNo()+"' href='javascript:' class='heart-click heart_icon"+to.getNo()+"'>" );
	            sbHtml.append( "           		<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-suit-heart' viewBox='0 0 16 16'>" );
	            sbHtml.append( "                 	<path d='M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z' />" );
	            sbHtml.append( "            	</svg>" );
	            sbHtml.append( "            </a>" );
	         } else {   //로그인 상태에서 꽉찬 하트일때 
	        	sbHtml.append( "            <a idx='"+to.getNo()+"' href='javascript:' class='heart-click heart_icon"+to.getNo()+"'>" );
	            sbHtml.append( "            	<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-suit-heart-fill' viewBox='0 0 16 16'>" );
	            sbHtml.append( "                 	<path d='M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z'/>" );
	            sbHtml.append( "            	</svg>" );
	            sbHtml.append( "            </a>" );
	         }
	      }
	      sbHtml.append( "      	<span id='m_heart"+ to.getNo() +"'> "+ to.getHeart() +"</span>&nbsp;" );
	      sbHtml.append( "            <svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-chat-dots' viewBox='0 0 16 16'>" );
	      sbHtml.append( "               <path d='M5 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2z' />" );
	      sbHtml.append( "               <path d='M2.165 15.803l.02-.004c1.83-.363 2.948-.842 3.468-1.105A9.06 9.06 0 0 0 8 15c4.418 0 8-3.134 8-7s-3.582-7-8-7-8 3.134-8 7c0 1.76.743 3.37 1.97 4.6a10.437 10.437 0 0 1-.524 2.318l-.003.011a10.722 10.722 0 0 1-.244.637c-.079.186.074.394.273.362a21.673 21.673 0 0 0 .693-.125zm.8-3.108a1 1 0 0 0-.287-.801C1.618 10.83 1 9.468 1 8c0-3.192 3.004-6 7-6s7 2.808 7 6c0 3.193-3.004 6-7 6a8.06 8.06 0 0 1-2.088-.272 1 1 0 0 0-.711.074c-.387.196-1.24.57-2.634.893a10.97 10.97 0 0 0 .398-2z' />" );
	      sbHtml.append( "            </svg>" );
	      sbHtml.append( "            "+ to.getReply() +"&nbsp;" );
	      sbHtml.append( "            <svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-eye' viewBox='0 0 16 16'>" );
	      sbHtml.append( "               <path d='M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z' />" );
	      sbHtml.append( "               <path d='M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z' />" );
	      sbHtml.append( "            </svg>" );
	      sbHtml.append( "            "+ to.getHit()+ "" );
		sbHtml.append( "			</div>");
		sbHtml.append( "	</div>");
		sbHtml.append( "</div>");
		
	
		if (rowCount % 4 == 3) {
			sbHtml.append("</div>");
			sbHtml.append("<br /><br />");
		}
	
		rowCount++;
	}

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<jsp:include page="../include/index.jsp"></jsp:include>

<!-- CSS File -->
<link href="./resources/css/lanTrip_list.css?uhu" rel="stylesheet">
<link href="./resources/css/navbar.css" rel="stylesheet">

<script type="text/javascript">
$(document).ready( function() {
   
	// 로그인 한 상태에서 하트를 클릭했을 때 (로그인한 상태인 하트의 <a></a> class명: heart-click)
	$(".heart-click").click(function() {
		// 게시물 번호(no)를 idx로 전달받아 저장합니다.
		let no = $(this).attr('idx');
		
		// 빈하트를 눌렀을때
		if($(this).children('svg').attr('class') == "bi bi-suit-heart"){
			console.log("빈하트 클릭" + no);
			
			$.ajax({
				url : 'lanTrip_saveHeart.do',
				type : 'get',
				data : {
					no : no,
				},
				success : function(lto) {
					
					let heart = lto.heart;
					
					// 페이지 하트수 갱신
					$('#m_heart'+no).text(heart);
					
					console.log("하트추가 성공");
				},
				error : function() {
					alert('서버 에러');
				}
			});
			
			// 꽉찬하트로 바꾸기
			$(this).html("<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-suit-heart-fill' viewBox='0 0 16 16'><path d='M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z'/></svg>");
			$('.heart_icon'+no).html("<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-suit-heart-fill' viewBox='0 0 16 16'><path d='M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z'/></svg>");
			
		// 꽉찬 하트를 눌렀을 때
		}else if($(this).children('svg').attr('class') == "bi bi-suit-heart-fill"){
			console.log("꽉찬하트 클릭" + no);
			
			$.ajax({
				url : 'lanTrip_removeHeart.do',
				type : 'get',
				data : {
					no : no,
				},
				success : function(lto) {
					
					let heart = lto.heart;
					// 페이지 하트수 갱신
					$('#m_heart'+no).text(heart);
					
					console.log("하트삭제 성공");
				},
				error : function() {
					alert('서버 에러');
				}
			});
			// 빈하트로 바꾸기
			$(this).html('<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart" viewBox="0 0 16 16"><path d="M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z" /></svg>');
			$('.heart_icon'+no).html('<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart" viewBox="0 0 16 16"><path d="M8 6.236l-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z" /></svg>');
		}
	});
   
   
})

	/* $('#carousel-container').on('slid.bs.carousel', function () { // function called when the slide is showed
  	$('.carousel-item video').removeAttr('autoplay'); // To stop all videos
  	$('.carousel-item.active video').attr('autoplay', 'autoplay'); // To play the current video
	}); */
	
	

</script>

</head>
<body>
	<!-- 메뉴바 
		 현재페이지 뭔지 param.thisPage에 넣어서 navbar.jsp에  던짐 -->
	<jsp:include page="../include/navbar_lantrip.jsp">
		<jsp:param value="lanTrip_list" name="thisPage" />
	</jsp:include>

	<br />
	<br />
	<br />

	<section id="carousel-container" class="carousel-container" >
		<div class="row row-carousel">
			<div class="section-title col-md-4">
				<h2>Best5</h2>
				<p>인기게시물을 확인하세요!</p>
			</div>
			<div id="carouselExampleIndicators" class="carousel slide col-md-8" data-bs-ride="carousel">
				<div class="carousel-indicators">
				    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
				    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
				    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
				    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="3" aria-label="Slide 4"></button>
				    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="4" aria-label="Slide 5"></button>
				 </div>
				<div class="carousel-inner">
					<c:forEach var="tmp" items="${bestList }">
						<c:choose>
							<c:when test="${tmp eq bestList[0] }">
								<div class="carousel-item active">
									<%-- <video class="d-block w-100 carousel-img" src="./upload/lanTrip/${tmp.video }"
										alt="..." /> --%>
									<video id="video" class="" src="./upload/lanTrip/${tmp.video }" muted autoplay loop playsinline />
								</div>
							</c:when>
							<c:otherwise>
								<div class="carousel-item">
									<video id="video" class="" src="./upload/lanTrip/${tmp.video }" muted autoplay loop playsinline />
<%-- 									<video class="d-block w-100 carousel-img" src="./upload/lanTrip/${tmp.video }"/> --%>
								</div>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</div>
	
	
				<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators"  data-bs-slide="prev">
				    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
				    <span class="visually-hidden">Previous</span>
				  </button>
				  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators"  data-bs-slide="next">
				    <span class="carousel-control-next-icon" aria-hidden="true"></span>
				    <span class="visually-hidden">Next</span>
				  </button>
			</div>
		</div>
	</section>
	<!-- best5 캐러샐 끝 -->

	<%-- card --%>
	<section id="card">
		<div class="card-container">

			<%--<div class="row"> --%>
			<%=sbHtml%>
		</div>
	</section>
	
</body>
</html>