프로젝트 소개
간단한 커뮤니티/게시판 기반 웹 애플리케이션입니다. 카테고리별 게시판(디저트, 전통과자, 커피, 공지 등)과 댓글, 사용자 관리가 포함됩니다.
핵심 기능
사용자 관리(회원가입/로그인/권한)
게시판(디저트/전통과자/커피/공지) CRUD
댓글/대댓글(정책에 따라 수정·삭제, 제재 가능)
검색/페이징(서버 사이드 렌더링 기반)
사용 도구 & 선택 이유
JSP 스크립틀릿 (<% ... %>)
장점: 러닝커브 낮고, 작은 기능을 빠르게 구현 가능
단점: 뷰/비즈니스/데이터 접근 로직이 한 파일에 혼재 → 유지보수/테스트 어려움
JDBC 직접 사용 (java.sql.*, PreparedStatement)
장점: 프레임워크 의존성 없이 SQL 제어
단점: 커넥션/리소스 관리, 예외 처리, 트랜잭션을 직접 처리해야 함
O’Reilly COS (com.oreilly.servlet.MultipartRequest)
파일 업로드 처리 간단
단점: 최신 서블릿 3.x의 Part 기반 업로드 대비 유연성/보안 측면 한계
유틸 클래스
DBConn : 커넥션 획득/해제 헬퍼
PagingUtil : 페이징 계산 헬퍼
선택 배경 요약
초기 학습/프로토타입 단계에서 서버사이드 렌더링 + 최소 의존성으로 빠른 결과를 내기 위한 구조. 추후 MVC 전환/보안 강화/테스트 자동화의 토대가 됨.
모듈 개요(커피 게시판(Coffee Board))을 대표 예시로 
주요 기능
게시글 목록/검색/페이징
게시글 등록/수정/상세/조회수 증가/소프트 삭제(state='D')
첨부파일 업로드(서버 경로에 저장, 파일명 UUID로 치환)
댓글 등록/수정/삭제/목록
주요 JSP 파일 (실제 코드 기준)
coffee/list.jsp : 목록/검색/페이징
coffee/view.jsp : 상세/조회수 증가/댓글 영역
coffee/register.jsp : 등록 폼 
coffee/registerOk.jsp : 등록 처리(파일 업로드 포함)
coffee/modify.jsp : 수정 폼
coffee/modifyOk.jsp : 수정 처리 
coffee/deleteOk.jsp : 삭제 처리(state='D')
coffee/commentRegisterOk.jsp : 댓글 등록
coffee/commentModifyOk.jsp : 댓글 수정
coffee/commentDeleteFormOk.jsp : 댓글 삭제
coffee/include/header.jsp, coffee/include/footer.jsp : 공통 레이아웃

요청 흐름 (요약)
목록 & 검색
GET /coffee/list.jsp?searchType=title&id&nowPage=n
list.jsp
총 건수 조회 → PagingUtil로 구간 계산
게시글 페이지 조회 (LIMIT ?, ?)
결과 렌더링
상세 보기
GET /coffee/view.jsp?fno={게시글번호}
view.jsp
UPDATE coffee_board SET hit = hit+1 WHERE fno=?
게시글 단건 조회 + 첨부 표시
댓글 목록 조회
(본인 글일 경우) 수정/삭제 버튼 활성화
등록
GET /coffee/resgister.jsp (폼)
POST /coffee/resgisterOk.jsp
MultipartRequest로 파일 수신
업로드 파일명 → UUID로 변경하여 저장(물리명/논리명 관리)
INSERT INTO coffee_board (...) VALUES (...)
수정
GET /coffee/modify.jsp?fno=... (폼)
POST /coffee/modityOk.jsp
새 파일이 있으면 업로드 & UUID 교체
UPDATE coffee_board SET ... WHERE fno=?
삭제(소프트)
POST /coffee/deleteOk.jsp
UPDATE coffee_board SET state='D' WHERE fno=?
성공 시 목록으로 리다이렉트
댓글
등록: POST /coffee/commentRegisterOk.jsp
수정: POST /coffee/commentModifyOk.jsp
삭제: POST /coffee/commentDeleteFormOk.jsp
