<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ page import="com.exam.model1.LanTripTO"%>
<%@ page import="com.exam.model1.LanTripListTO"%>
<%@ page import="java.util.ArrayList"%>

<%
	LanTripListTO listTO = (LanTripListTO) request.getAttribute("listTO");

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
	int no = to.getNo();
	String subject = to.getSubject();
	String writer = to.getWriter();
	String video = "./upload/lanTrip/" + to.getVideo();
	String wdate = to.getWdate();
	String location = to.getLocation();
	int reply = to.getReply();
	int hit = to.getHit();

	sbHtml.append("<div class='col-3'> ");
	sbHtml.append("	<div class='card'>");
	sbHtml.append(
	"		<video src='https://codingyaar.com/wp-content/uploads/video-in-bootstrap-card.mp4' controls></video>");
	sbHtml.append("		<div class='card-body'>");
	sbHtml.append("		<h3 class='card-title'>" + writer + "</h3>");
	sbHtml.append("			<p class='card-text'>" + subject + "</p>");
	sbHtml.append("			<a href='./lanTrip_view.do' class='btn btn-primary'>Go Lan</a>");
	sbHtml.append("		</div>");
	sbHtml.append("	</div>");
	sbHtml.append("</div>");
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<jsp:include page="../include/index.jsp"></jsp:include>

<!-- CSS File -->
<link href="./resources/css/lanTrip_list.css" rel="stylesheet">
<link href="./resources/css/navbar.css" rel="stylesheet">



</head>
<body>
	<!-- 메뉴바 
		 현재페이지 뭔지 param.thisPage에 넣어서 navbar.jsp에  던짐 -->
	<jsp:include page="../include/navbar.jsp">
		<jsp:param value="lanTrip_list" name="thisPage" />
	</jsp:include>

	<br />
	<br />
	<br />

	<section>
		<div id="carouselExampleIndicators" class="carousel slide"
			data-bs-ride="carousel">
			<div class="carousel-indicators">
				<button type="button" data-bs-target="#carouselExampleIndicators"
					data-bs-slide-to="0" class="active" aria-current="true"
					aria-label="Slide 1"></button>
				<button type="button" data-bs-target="#carouselExampleIndicators"
					data-bs-slide-to="1" aria-label="Slide 2"></button>
				<button type="button" data-bs-target="#carouselExampleIndicators"
					data-bs-slide-to="2" aria-label="Slide 3"></button>
			</div>
			<div class="carousel-inner">
				<div class="carousel-item active">
					<img src="./upload/lanTrip/img1.jpg" class="d-block w-100" alt="...">
				</div>
				<div class="carousel-item">
					<img src="./upload/lanTrip/img3.jpg" class="d-block w-100" alt="...">
				</div>
				<div class="carousel-item">
					<img src="./upload/lanTrip/img4.jpg" class="d-block w-100" alt="...">
				</div>
			</div>
			<button class="carousel-control-prev" type="button"
				data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Previous</span>
			</button>
			<button class="carousel-control-next" type="button"
				data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Next</span>
			</button>
		</div>
	</section>

	<%-- card --%>
	<section id="card">
		<div class="card-container">
			<div class="row">
				<div class="col-3">
					<div class="card">
						<video
							src="https://codingyaar.com/wp-content/uploads/video-in-bootstrap-card.mp4"
							controls></video>
						<div class="card-body">
							<h3 class="card-title">김해선</h3>
							<p class="card-text">Some quick example text to build on the
								card title and make up the bulk of the card's content.</p>
							<a href="./lanTrip_view.do" class="btn btn-primary">Go Lan</a>
						</div>
					</div>
				</div>
				<div class="col-3">
					<div class="card">
						<video
							src="https://codingyaar.com/wp-content/uploads/video-in-bootstrap-card.mp4"
							controls></video>
						<div class="card-body">
							<h3 class="card-title">정현수</h3>
							<p class="card-text">Some quick example text to build on the
								card title and make up the bulk of the card's content.</p>
							<a href="./lanTrip_view.do" class="btn btn-primary">Go Lan</a>
						</div>
					</div>
				</div>
				<div class="col-3">
					<div class="card">
						<video
							src="https://codingyaar.com/wp-content/uploads/video-in-bootstrap-card.mp4"
							controls></video>
						<div class="card-body">
							<h3 class="card-title">이지훈</h3>
							<p class="card-text">Some quick example text to build on the
								card title and make up the bulk of the card's content.</p>
							<a href="./lanTrip_view.do" class="btn btn-primary">Go Lan</a>
						</div>
					</div>
				</div>
				<div class="col-3">
					<div class="card">
						<video
							src="https://codingyaar.com/wp-content/uploads/video-in-bootstrap-card.mp4"
							controls></video>
						<div class="card-body">
							<h3 class="card-title">박혁준</h3>
							<p class="card-text">Some quick example text to build on the
								card title and make up the bulk of the card's content.</p>
							<a href="./lanTrip_view.do" class="btn btn-primary">Go Lan</a>
						</div>
					</div>
				</div>
			</div>
			<br />
			<hr />
			<br />
			<div class="row">
				<div class="col-3">
					<div class="card">
						<video
							src="https://codingyaar.com/wp-content/uploads/video-in-bootstrap-card.mp4"
							controls></video>
						<div class="card-body">
							<h3 class="card-title">이형석</h3>
							<p class="card-text">Some quick example text to build on the
								card title and make up the bulk of the card's content.</p>
							<a href="./lanTrip_view.do" class="btn btn-primary">Go Lan</a>
						</div>
					</div>
				</div>
				<div class="col-3">
					<div class="card">
						<video
							src="https://codingyaar.com/wp-content/uploads/video-in-bootstrap-card.mp4"
							controls></video>
						<div class="card-body">
							<h3 class="card-title">이형진</h3>
							<p class="card-text">Some quick example text to build on the
								card title and make up the bulk of the card's content.</p>
							<a href="./lanTrip_view.do" class="btn btn-primary">Go Lan</a>
						</div>
					</div>
				</div>
				<div class="col-3">
					<div class="card">
						<video
							src="https://codingyaar.com/wp-content/uploads/video-in-bootstrap-card.mp4"
							controls></video>
						<div class="card-body">
							<h3 class="card-title">이승원</h3>
							<p class="card-text">Some quick example text to build on the
								card title and make up the bulk of the card's content.</p>
							<a href="./lanTrip_view.do" class="btn btn-primary">Go Lan</a>
						</div>
					</div>
				</div>
				<div class="col-3">
					<div class="card">
						<video
							src="https://codingyaar.com/wp-content/uploads/video-in-bootstrap-card.mp4"
							controls></video>
						<div class="card-body">
							<h3 class="card-title">윤동희</h3>
							<p class="card-text">Some quick example text to build on the
								card title and make up the bulk of the card's content.</p>
							<a href="./lanTrip_view.do" class="btn btn-primary">Go Lan</a>
						</div>
					</div>
				</div>

			</div>
		</div>
	</section>
	<button class="btn btn-primary btn-md" onclick="location.href='./lanTrip_write.do'" >등록하기</button>
</body>
</html>