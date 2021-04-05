package com.exam.controller;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.exam.model1.message.MessageDAO;
import com.exam.model1.message.MessageTO;
import com.exam.model1.lantrip.LanTripDAO;
import com.exam.model1.lantrip.LanTripTO;
import com.exam.model1.lantripReply.LanTripReplyDAO;
import com.exam.model1.lantripReply.LanTripReplyTO;
import com.exam.model1.user.UserDAO;
import com.exam.model1.user.UserTO;


@Controller
public class ProfileController {
	
	@Autowired
	private UserDAO userDao;
	
	@Autowired
	private MessageDAO messageDao;
	@Autowired
	private LanTripDAO lantripDao;
	@Autowired
	private LanTripReplyDAO l_replyDao;

   //private String uploadPath = "C:\\Git_Local\\Want\\src\\main\\webapp\\upload\\profile";
   //private String uploadPath = "C:\\KICKIC\\git repo\\Want\\Want\\src\\main\\webapp\\upload\\profile";
   private String uploadPath ="/Users/hyukjun/git/Want/Want/src/main/webapp/upload/profile";
	
	// 내 프로필
	@RequestMapping(value = "/profile.do")
	public String profile(HttpServletRequest request, HttpSession session) {
		try {
			request.setCharacterEncoding("utf-8");
			
			//======= 유저 정보가져오기 =======
			//세션에 저장된 nick값을 to에 저장
			UserTO uto = new UserTO();
			String nick = (String)session.getAttribute( "nick" );
			uto.setNick(nick);
			
			//저장된 nick값을 userDao함수 매개변수로 넘겨줌
			//userDao에서 myProfile함수를 실행시켜서 유저 정보를 다시 uto에 저장
			uto = userDao.myProfile(uto);
			
			
			
			//======= 랜선여행 글list 가져오기 =======
			LanTripTO lto = new LanTripTO();
			
			String pageNum = request.getParameter( "pageNum" );
			
			int recordNum = 9;	//가져올 글의 개수
			
			int currentPage = 1;	//현재 페이지번호
			if( pageNum != null ) {
				currentPage = Integer.parseInt( pageNum );
			}			
			int startRowNum = 0 + ( currentPage - 1 ) * recordNum;
			int endRowNum = currentPage * recordNum;
			
			lto.setWriter(nick);
			lto.setStartRowNum(startRowNum);
			lto.setEndRowNum(endRowNum);
			
			//전체 글의 개수를 이용해서 전페 페이지수 구하기
			int totalRow = 0;
			totalRow = lantripDao.profileLanTripCount( lto );
			
			int totalPageCount = (int)Math.ceil( totalRow / (double)recordNum );

			//랜선여행 글리스트 결과를 리턴받는다.
			ArrayList<LanTripTO> list = lantripDao.lantrip_MyProfileList(lto);
		
			
			//jsp로 uto값을 넘겨줌
			request.setAttribute( "uto", uto );
			request.setAttribute( "totalPageCount", totalPageCount );
			//jsp로 to가 담긴 arrayList넘겨준다.
			request.setAttribute( "pageNum", pageNum );
			request.setAttribute( "list", list );	

		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "profile/profile";
	}
	
	//랜선여행리스트 불러오기
	@RequestMapping(value = "/profile_lanTrip_ajax_page.do")
	public String profile_lanTrip_ajax_page(HttpServletRequest request, HttpSession session) {
		try {
			request.setCharacterEncoding("utf-8");
			
			
			//세션에 저장된 nick값과 페이지 가져올 글수를 정하는 
			//startRowNum과 endRowNum을 to에 저장
			LanTripTO lto = new LanTripTO();
			
			String writer = (String)session.getAttribute( "nick" );
			String pageNum = request.getParameter( "pageNum" );
			
			int recordNum = 9;	//가져올 글의 개수
			
			int currentPage = 1;	//현재 페이지번호
			if( pageNum != null ) {
				currentPage = Integer.parseInt( pageNum );
			}			
			int startRowNum = 0 + ( currentPage - 1 ) * recordNum;
			int endRowNum = currentPage * recordNum;
			
			lto.setWriter(writer);
			lto.setStartRowNum(startRowNum);
			lto.setEndRowNum(endRowNum);
			
			//전체 글의 개수를 이용해서 전페 페이지수 구하기
			int totalRow = 0;
			totalRow = lantripDao.profileLanTripCount( lto );
			
			int totalPageCount = (int)Math.ceil( totalRow / (double)recordNum );
			System.out.println( "전체 페이지 수는 ? : " + totalPageCount );
			
			//랜선여행 글리스트 결과를 리턴받는다.
			ArrayList<LanTripTO> list = lantripDao.lantrip_MyProfileList(lto);
			System.out.println( "글목록 가져오니 ? : " + list );
			
			//jsp로 to가 담긴 arrayList넘겨준다.
			request.setAttribute( "totalPageCount", totalPageCount );
			request.setAttribute( "pageNum", pageNum );
			request.setAttribute( "list", list );
			

		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "profile/profile_lanTrip_ajax_page";
	}
	
	//랜선여행하기 댓글리스트
	@RequestMapping(value = "/lantrip_replyList.do")
	public String lantrip_replyList(HttpServletRequest request, HttpSession session) {

		LanTripReplyTO to = new LanTripReplyTO();
		
		// 가져올 댓글 리스트의 게시물번호를 세팅
		to.setBno( request.getParameter( "no" ) );

		ArrayList<LanTripReplyTO> replyList = new ArrayList();

		replyList = l_replyDao.lantripReplyList(to);
			
		request.setAttribute( "rlist", replyList );
		
		return "profile/profile_lantripReply_ajax_page";
	}
	
	
	
	// 남이 보는 내 프로필
	@RequestMapping(value = "/other_profile.do")
	public String other_profile(HttpServletRequest request) {
		
		UserTO to = new UserTO();
		
		to.setNick(request.getParameter("other_nick"));
		to = userDao.OtherProfile(to);
		
		System.out.println(to);
		
		request.setAttribute("to", to);
		
		return "profile/other_profile";
	}
	
	// 메세지 목록 가져오기
	@RequestMapping(value = "/message_content_list_inprofile.do")
	public String message_content_list_inprofile(HttpServletRequest request, HttpSession session) {

		//int room = Integer.parseInt(request.getParameter("room"));
		String other_nick = request.getParameter("other_nick");

		MessageTO to = new MessageTO();
		to.setRecv_nick(other_nick);
		to.setNick((String) session.getAttribute("nick"));

		// 메세지 내용을 가져온다.
		ArrayList<MessageTO> clist = messageDao.roomContentList(to);

		request.setAttribute("clist", clist);
		
		System.out.println(clist);

		return "message/message_content_list";
	}

	// 메세지 리스트에서 메세지 보내기
	@ResponseBody
	@RequestMapping(value = "/message_send_inlist_inprofile.do")
	public int message_send_inlist_inprofile(@RequestParam String other_nick, @RequestParam String content, HttpSession session) {
		System.out.println("컨트롤러 들어옴");
		System.out.println("other_nick: " + other_nick);
		System.out.println("content: " + content);
		
		MessageTO to = new MessageTO();
		to.setSend_nick((String) session.getAttribute("nick"));
		to.setRecv_nick(other_nick);
		to.setContent(content);

		int flag = messageDao.messageSendInlist(to);

		return flag;
	}
	

}
