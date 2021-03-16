<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%-- <%@ page import="com.exam.board02.model1.BoardTO" %>
<%@ page import="com.exam.board02.model1.BoardDAO" %>

<%@page import="java.util.ArrayList"%>

<%
	request.setCharacterEncoding( "utf-8" );
	String cpage = request.getParameter( "cpage" );
	String  = request.getParameter( "cpage" );
	
	BoardTO to = (BoardTO)request.getAttribute("to");
	
	String no = to.getNo();
	String subject = to.getSubject();
	String content = to.getContent().replaceAll("\n","<br />");
	String writer = to.getWriter();
	String wdate = to.getWdate();
	String hit = to.getHit();
	String location = to.getLocation();
	String video = to.getVideo();
	String reply = to.getReply();
	
	ArrayList<CommentTO> lists = (ArrayList)request.getAttribute( "lists" );
	StringBuffer sbHtml = new StringBuffer();
	
	for( CommentTO commentTo : lists ) {
		sbHtml.append( "<table>" );
		sbHtml.append( "	<tr>" );
		sbHtml.append( "	<td class='coment_re' width='20%'>" );
		sbHtml.append( "		<strong>"+ commentTo.getWriter() +"</strong> ("+ commentTo.getWdate() +")" );
		sbHtml.append( "		<div class='coment_re_txt'>" );
		sbHtml.append( "			"+ commentTo.getContent() +"" );
		sbHtml.append( "		</div>" );
		sbHtml.append( "	</td>" );
		sbHtml.append( "</tr>" );
		sbHtml.append( "</table>" );
	}
%>
 --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, intial-scale=1.0">
<title>Insert title here</title>
	
<jsp:include page="../include/index.jsp"></jsp:include>

<!-- CSS File -->
<link href="./resources/css/lanTrip_list.css" rel="stylesheet">
<link href="./resources/css/navbar.css" rel="stylesheet">
<style type="text/css">

.video {
	display : block;
   	text-align: center;   	
   	margin-top : 50px;   		
}

</style>
</head>
<body>
	<!-- 메뉴바 
		 현재페이지 뭔지 param.thisPage에 넣어서 navbar.jsp에  던짐 -->
	<jsp:include page="../include/navbar.jsp">
		<jsp:param value="lanTrip_list" name="thisPage" />
	</jsp:include>
	
	<br /><br /><br />	
	
	<section id="info" class="container" style="margin-top:100px;">
		<table class="table table-hover" id='board_list'>
			<thead>
				<tr>
					<td class="text-center d-none d-md-table-cell">1</td>
					<td class="text-center d-none d-md-table-cell">이탈리아</td>
					<td class="text-center">함께하는 랜선여행 포지타노편</td>
					<td class="text-center d-none d-md-table-cell">박혁준</td>
					<td class="text-center d-none d-md-table-cell">2021.03.14</td>
					<td class="text-center d-none d-md-table-cell">조회수</td>
				</tr>
			</thead>
		</table>
	</section>
	<section id="player" class="container">
		<div class="video">
			<video src="./upload/lanTrip/positano.mp4" width="600px" controls></video>
		</div>
	</section>
	<section id="content" class="container">
		<div class="form-group" style="border: 1px; color: solid; margin-top:20px;">
			<textarea id="board_content" name="board_content" class="form-control" rows="10" style="resize: none" disabled="disabled">본문입니다</textarea>
		</div>
	</section>
	<section id="comment" class="container" style="margin-top:10px;">
	    <form id="commentForm" name="commentForm" method="post">
	    <br/><br />
	        <div>
	            <div>
	                <span><strong>Comments</strong></span> 
	                <span id="cCnt"></span>
	            </div>
	            <div>
	                <table class="table">                    
	                    <tr>
	                        <td>
	                            <textarea style="width: 1100px" rows="3" cols="30" id="comment" name="comment" placeholder="댓글을 입력하세요"></textarea>
	                            <br />
	                            <div>
	                                <a href='#' onClick="fn_comment('${result.code }')" class="btn pull-right btn-success">등록</a>
	                            </div>
	                        </td>
	                    </tr>
	                </table>
	            </div>
	        </div>
	    </form>
	    <%-- <div class="btn_area">
			<div class="align_left">
				<input type="button" value="목록" class="btn_list btn_txt02" style="cursor: pointer;" onclick="location.href='list.do'" />
			</div>
			<div class="align_right">
				<input type="button" value="수정" class="btn_list btn_txt02" style="cursor: pointer;" onclick="location.href='modify.do?seq=<%=request.getParameter("seq") %>'" />
				<input type="button" value="삭제" class="btn_list btn_txt02" style="cursor: pointer;" onclick="location.href='delete.do?seq=<%=request.getParameter("seq") %>'" />
				<input type="button" value="쓰기" class="btn_write btn_txt01" style="cursor: pointer;" onclick="location.href='write.do'" />
			</div>
		</div> --%>
	</section>
	
</body>
</html>