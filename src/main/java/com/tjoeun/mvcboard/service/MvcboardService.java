package com.tjoeun.mvcboard.service;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import com.tjoeun.mvcboard.dao.MvcboardDAO;
import com.tjoeun.mvcboard.mybatis.freeSession;
import com.tjoeun.mvcboard.vo.MvcboardList;
import com.tjoeun.mvcboard.vo.MvcboardVO;

public class MvcboardService {
	
	private static MvcboardService instance = new MvcboardService();
	private MvcboardService() { }
	public static MvcboardService getInstance() {
		return instance;
	}
//	service 클래스에서 사용할 dao 클래스 객체를 얻어옴
	private MvcboardDAO dao = MvcboardDAO.getInstance();
	
//	컨트롤러에 insertOK.kbs이라는 요청이 들어오면 컨트롤러에서 호출하는 메소드로 테이블에 저장할
//	메인글 정보가 저장된 HttpServletRequest 인터페이스 객체를 넘겨받고 mapper를 얻어온 후
//	MvcboardDAO 클래스의 메인글을 저장하는 insert sql 명령을 실행하는 메소드를 호출하는 메소드
	public void insert(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("MvcboardService 클래스의 insert() 메소드");
		SqlSession mapper = freeSession.getSession();
		
		// insert.jsp에서 입력한 HttpServletRequest 인터페이스 객체에 저장돼서 넘어오는 데이터를
		// 받아서 MvcboardVO 클래스 객체에 저장
		MvcboardVO vo = new MvcboardVO();
		vo.setName(request.getParameter("name"));
		vo.setSubject(request.getParameter("subject"));
		vo.setContent(request.getParameter("content"));
		// System.out.println(vo);
		
		// MvcboardDAO 클래스의 insert.jsp에서 입력한 데이터를 테이블에 저장하는 insert sql 명령을
		// 실행하는 메소드를 호출함
		dao.insert(mapper, vo);
		
		mapper.commit();
		mapper.close();
	}
	
	// 컨트롤러에 list.kbs라는 요청이 들어오면 컨트롤러에서 호출하는 메소드로 mapper를 얻어온 후
	// MvcboardDAO 클래스의 브라우저에 출력할 1페이지 분량의 글 목록과 페이징 작업에 사용할
	// 8개의 변수가 저장된 클래스 객체를 만들어 request 영역에 저장하는 메소드
	public void selectList(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("MvcboardService 클래스의 selectList() 메소드");
		SqlSession mapper = freeSession.getSession();
		
		// list.kbs이 요청될 때 넘어오는 브라우저에 표시할 페이지 번호를 받음
		// 브라우저에 표시할 페이지 번호가 정상적으로 넘어왔다면 넘어온 페이지 번호로,
		// 정상적으로 넘어오지 않았다면 1로 브라우저에 표시할 페이지 번호를 설정함
		int currentPage = 1;
		try {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		} catch (NumberFormatException e) {
			
		}
		
		// 1페이지에 표시할 글의 개수를 정함
		int pageSize = 10;
		// 테이블에 저장된 전체 글의 개수를 얻어옴
		int totalCount = dao.selectCount(mapper);

		// 1페이지 분량의 글 목록과 페이징 작업에 사용되는 8개의 변수를
		// 초기화시키는 MvcboardList 클래스 객체를 만듬
		MvcboardList mvcboardList = new MvcboardList(pageSize, totalCount, currentPage);
		
		// 1페이지 분량의 글 목록을 얻어와 MvcboardList 클래스의 arrayList에 넣어줌
		HashMap<String, Integer> hmap = new HashMap<String, Integer>();
		hmap.put("startNo", mvcboardList.getStartNo());
		hmap.put("endNo", mvcboardList.getEndNo());
		mvcboardList.setList(dao.selectList(mapper, hmap));
		
		// MvcboardList 클래스 객체를 request 영역에 저장함
		request.setAttribute("mvcboardList", mvcboardList);
		mapper.close();
	}
	
//	컨트롤러에 increment.kbs라는 요청이 들어오면 컨트롤러에서 호출되는 메소드로
//	조회수를 증가시킨 글번호와 돌아갈 페이지 번호를 넘겨받고 mapper를 얻어온 후
//	MvcboardDAO 클래스의 조회수를 증가시키는 update sql 명령을 실행하는 메소드를 호출하는 메소드	
	public void increment(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("MvcboardService 클래스의 increment() 메소드");
		SqlSession mapper = freeSession.getSession();
		
		// request 객체로 넘어온 조회수를 증가시킬 글번호를 받음
		int idx = Integer.parseInt(request.getParameter("idx"));
		// 조회수를 증가시키는 메소드를 호출
		dao.increment(mapper, idx);
		
		mapper.commit();
		mapper.close();
	}
	
//	컨트롤러에 contentView.kbs라는 요청이 들어오면 컨트롤러에서 호출되는 메소드로
//	조회수를 증가시킨 글번호와 돌아갈 페이지 번호를 넘겨받고 mapper를 얻어온 후
//	MvcboardDAO 클래스의 조회수를 증가시킨 글 1건을 얻어오는 select sql 명령을 실행하고
//	조회수를 증가시킨 글 1건을 request 영역에 저장하는 메소드
	public void selectByIdx(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("MvcboardService 클래스의 selectByIdx() 메소드");
		SqlSession mapper = freeSession.getSession();
		
		// request 객체로 넘어오는 조회수를 증가시킨 글번호와 돌아갈 페이지 번호를 받음
		int idx = Integer.parseInt(request.getParameter("idx"));
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		// 조회수를 증가시킨 글 1건을 얻어와서 MvcboardVO 클래스 객체에 저장함
		MvcboardVO vo = dao.selectByIdx(mapper, idx);
		
		// System.out.println(vo);
		// 브라우저에 표시할 글이 저장된 객체, 돌아갈 페이지 번호,
		// 줄바꿈에 사용할 이스케이프 시퀀스를 request 영역에 저장함
		request.setAttribute("vo", vo);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("enter", "\r\n");
		
		mapper.close();
	}
	
//	컨트롤러에 update.kbs이라는 요청이 들어오면 컨트롤러에서 호출되는 메소드로 수정할 정보가
//	저장된 request 객체를 넘겨받고 mapper를 얻어온 후 MvcboardDAO 클래스의 글 1건을 수정하는
//	update sql 명령을 실행하는 메소드를 호출하는 메소드
	public void update(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("MvcboardService 클래스의 update() 메소드");
		SqlSession mapper = freeSession.getSession();
		
		// request 객체로 넘어온 수정할 데이터를 받아서 MvcboardVO 클래스 객체에 저장함
		MvcboardVO vo = new MvcboardVO();
		vo.setIdx(Integer.parseInt(request.getParameter("idx")));
		vo.setName(request.getParameter("name"));
		vo.setSubject(request.getParameter("subject"));
		vo.setContent(request.getParameter("content"));
		// System.out.println(vo);
		// 글 1건을 수정하는 메소드를 호출함
		dao.update(mapper, vo);
		mapper.commit();
		mapper.close();
	}
	
//	컨트롤러에 delete.kbs이라는 요청이 들어오면 컨트롤러에서 호출되는 메소드로 삭제할 정보가
//	저장된 request 객체를 넘겨받고 mapper를 얻어온 후 MvcboardDAO 클래스의 글 1건을 삭제하는
//	delete sql 명령을 실행하는 메소드를 호출하는 메소드	
	public void delete(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("MvcboardService 클래스의 delete() 메소드");
		SqlSession mapper = freeSession.getSession();
		
		// request 객체로 넘어온 삭제할 데이터를 받아서 MvcboardVO 클래스 객체에 저장함
		int idx = Integer.parseInt(request.getParameter("idx"));
		// 글 1건을 삭제하는 메소드를 호출함
		dao.delete(mapper, idx);
		mapper.commit();
		mapper.close();
		
	}
	
	//	컨트롤러에 replyInsert.kbs이라는 요청이 들어오면 컨트롤러에서 호출되는 메소드로
	//	답글 정보가 저장된 request 객체를 넘겨받고 mapper를 얻어온 후 MvcboardDAO 클래스의
	//	조건에 만족하는 seq를 1씩 증가하시키는 update sql 명령을 실행하고 답글을 저장하는
	//	insert sql 명령을 실행하는 메소드를 호출하는 메소드
	public void replyInsert(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("MvcboardService 클래스의 replyInsert() 메소드");
		SqlSession mapper = freeSession.getSession();
		
		// request 객체로 넘어오는 답글 정보를 받아서 MvcboardVO 클래스 객체에 저장함
		int idx = Integer.parseInt(request.getParameter("idx"));
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		int gup = Integer.parseInt(request.getParameter("gup"));
		int lev = Integer.parseInt(request.getParameter("lev"));
		int seq = Integer.parseInt(request.getParameter("seq"));
		String name = request.getParameter("name");
		String subject = request.getParameter("subject");
		String content = request.getParameter("content");
		// MvcboardVO 클래스 객체의 lev와 seq를 1씩 증가시킴
		MvcboardVO vo = new MvcboardVO();
		vo.setIdx(idx);
		vo.setGup(gup);
		vo.setLev(lev + 1);
		vo.setSeq(seq + 1);
		vo.setName(name);
		vo.setSubject(subject);
		vo.setContent(content);
		System.out.println(vo);
		// 같은 글 그룹(gup)에서 답글이 표시될 위치(seq) 이후의 모든 글이 출력될 위치를
		// 1씩 증가시키는 메소드를 호출함
		HashMap<String, Integer> hmap = new HashMap<String, Integer>();
		hmap.put("gup", vo.getGup());
		hmap.put("seq", vo.getSeq());
		dao.incrementSeq(mapper, hmap);
		// 답글을 저장하는 메소드를 호출함
		dao.replyInsert(mapper, vo);
		
		mapper.commit();
		mapper.close();
	}
	
}
