## 목차
- [프로젝트 소개](#intro)
- [📌 핵심 기능](#features)
- [⚙️ 사용 도구 & 선택 이유](#tools)
- [👉 선택 배경 요약](#rationale)
- [📂 모듈 개요 (커피 게시판 예시)](#module-coffee)
- [🔄 요청 흐름 (요약)](#flows)
- [📁 프로젝트 구조](#structure)
- [🚀 시작하기(설치)](#quickstart)
- [🧭 URL 매핑(요약)](#routing)
- [🧱 ERD & 컬럼 설명](#erd)
- [🔒 정책(삭제 / 파일 업로드 / 페이징)](#policy)

--- 
<a id="intro"></a>
# 🍰 NewProject – 커뮤니티/게시판 웹 애플리케이션

간단한 커뮤니티/게시판 기반 웹 애플리케이션입니다.  
카테고리별 게시판(디저트, 전통과자, 커피, 공지)과 댓글, 사용자 관리를 포함합니다.

---
<a id="features"></a>
 ## 📌 핵심 기능
- 👤 **사용자 관리** : 회원가입 / 로그인 / 권한
- 📝 **게시판 CRUD** : 디저트 / 전통과자 / 커피 / 공지
- 💬 **댓글/대댓글** : 정책에 따라 수정·삭제, 제재 가능
- 🔍 **검색/페이징** : 서버사이드 렌더링 기반

---
<a id="tools"></a>
## ⚙️ 사용 도구 & 선택 이유

| 도구/라이브러리 | 장점 | 단점 |
|----------------|------|------|
| **JSP 스크립틀릿 (<% ... %>)** | 러닝커브 낮음, 빠른 구현 가능 | 뷰/비즈니스/DB 로직 혼재 → 유지보수 어려움 |
| **JDBC 직접 사용** (`java.sql.*`, `PreparedStatement`) | 프레임워크 의존성 없이 SQL 제어 | 커넥션/리소스/트랜잭션 직접 처리 필요 |
| **O’Reilly COS** (`com.oreilly.servlet.MultipartRequest`) | 파일 업로드 간단 | Servlet 3.x `Part` 대비 보안/유연성 한계 |
| **유틸 클래스** (`DBConn`, `PagingUtil`) | DB 연결 및 페이징 편의 제공 | 고도화에는 한계 |


---
<a id="rationale"></a>
## 👉 선택 배경 요약

초기 학습/프로토타입 단계에서 **서버사이드 렌더링 + 최소 의존성**으로  
빠른 결과를 내기 위한 구조를 채택했습니다.  

→ 이후 단계에서는 **MVC 전환 / 보안 강화 / 테스트 자동화**의 토대를 마련하는 것을 목표로 합니다.


---
<a id="module-coffee"></a>
## 📂 모듈 개요 (커피 게시판 예시)

### 주요 기능
- 게시글 목록 / 검색 / 페이징
- 게시글 등록 / 수정 / 상세 / 조회수 증가
- 게시글 삭제 (`state='D'`)
- 첨부파일 업로드 (서버 저장, UUID 파일명 치환)
- 댓글 등록 / 수정 / 삭제 / 목록

### 주요 JSP 파일
- `coffee/list.jsp` : 목록 / 검색 / 페이징
- `coffee/view.jsp` : 상세 / 조회수 증가 / 댓글 영역
- `coffee/register.jsp` : 등록 폼
- `coffee/registerOk.jsp` : 등록 처리 (파일 업로드 포함)
- `coffee/modify.jsp` : 수정 폼
- `coffee/modifyOk.jsp` : 수정 처리
- `coffee/deleteOk.jsp` : 삭제 처리 (`state='D'`)
- `coffee/commentRegisterOk.jsp` : 댓글 등록
- `coffee/commentModifyOk.jsp` : 댓글 수정
- `coffee/commentDeleteFormOk.jsp` : 댓글 삭제
- `coffee/include/header.jsp`, `coffee/include/footer.jsp` : 공통 레이아웃


---
<a id="flows"></a>
## 🔄 요청 흐름 (요약)
<details> <summary><b>목록 & 검색</b></summary>
GET /coffee/list.jsp?searchType=title&id&nowPage=n
list.jsp 동작:
총 건수 조회 → PagingUtil로 구간 계산
LIMIT ?, ? 로 게시글 페이지 조회
결과 렌더링
</details> <details> <summary><b>상세 보기</b></summary>
GET /coffee/view.jsp?fno={게시글번호}
view.jsp 동작:
UPDATE coffee_board SET hit=hit+1 WHERE fno=?
게시글 단건 조회 + 첨부 표시
댓글 목록 조회
작성자일 경우 수정/삭제 버튼 표시
</details> <details> <summary><b>등록</b></summary>
GET /coffee/register.jsp (폼)
POST /coffee/registerOk.jsp
MultipartRequest로 파일 수신
업로드 파일명 UUID로 변경하여 저장
INSERT INTO coffee_board (...) VALUES (...)
</details> <details> <summary><b>수정</b></summary>
GET /coffee/modify.jsp?fno=... (폼)
POST /coffee/modifyOk.jsp
새 파일 업로드 시 UUID 갱신
UPDATE coffee_board SET ... WHERE fno=?
</details> <details> <summary><b>삭제</b></summary>
POST /coffee/deleteOk.jsp
UPDATE coffee_board SET state='D' WHERE fno=?
성공 시 목록으로 리다이렉트
</details> <details> <summary><b>댓글</b></summary>
등록: POST /coffee/commentRegisterOk.jsp
수정: POST /coffee/commentModifyOk.jsp
삭제: POST /coffee/commentDeleteFormOk.jsp
</details>

---
<a id="structure"></a>
## 📁 프로젝트 구조

```text
newproject/
├─ src/
│  └─ main/
│     ├─ java/
│     │  └─ jspStudy/
│     │     ├─ BoardDTO.java
│     │     ├─ CommentC.java
│     │     ├─ CommentD.java
│     │     ├─ CommentK.java
│     │     ├─ CommentQ.java
│     │     ├─ DBConn.java          # DB 연결 헬퍼
│     │     ├─ PagingUtil.java      # 페이징 유틸
│     │     └─ UserDTO.java
│     └─ webapp/
│        ├─ coffee/                 # 커피 게시판
│        │  ├─ include/
│        │  │  ├─ footer.jsp
│        │  │  └─ header.jsp
│        │  ├─ list.jsp
│        │  ├─ view.jsp
│        │  ├─ register.jsp
│        │  ├─ registerOk.jsp
│        │  ├─ modify.jsp
│        │  ├─ modifyOk.jsp
│        │  ├─ deleteOk.jsp
│        │  ├─ commentRegisterOk.jsp
│        │  ├─ commentModifyOk.jsp
│        │  └─ commentDeleteFormOk.jsp
│        │
│        ├─ dess/                   # 디저트 게시판
│        │  ├─ include/
│        │  │  ├─ footer.jsp
│        │  │  └─ header.jsp
│        │  ├─ list.jsp
│        │  ├─ view.jsp
│        │  ├─ register.jsp        
│        │  ├─ registerOk.jsp      
│        │  ├─ modify.jsp
│        │  ├─ modifyOk.jsp        
│        │  ├─ deleteOk.jsp
│        │  ├─ down.jsp
│        │  ├─ commentRegisterOk.jsp
│        │  ├─ commentModifyOk.jsp
│        │  └─ commentDeleteFormOk.jsp
│        │
│        ├─ kore/                   # 전통과자 게시판
│        │  ├─ include/
│        │  │  ├─ footer.jsp
│        │  │  └─ header.jsp
│        │  ├─ list.jsp
│        │  ├─ view.jsp
│        │  ├─ register.jsp        
│        │  ├─ registerOk.jsp      
│        │  ├─ modify.jsp
│        │  ├─ modifyOk.jsp         
│        │  ├─ deleteOk.jsp
│        │  ├─ commentRegisterOk.jsp
│        │  ├─ commentModifyOk.jsp
│        │  └─ commentDeleteFormOk.jsp
│        │
│        ├─ notice/                 # 공지 게시판
│        │  ├─ include/
│        │  │  ├─ footer.jsp
│        │  │  └─ header.jsp
│        │  ├─ list.jsp
│        │  ├─ view.jsp
│        │  ├─ register.jsp       
│        │  ├─ registerOk.jsp      
│        │  ├─ modify.jsp
│        │  ├─ modifyOk.jsp         
│        │  ├─ deleteOk.jsp
│        │  ├─ down.jsp
│        │  ├─ commentRegisterOk.jsp
│        │  ├─ commentModifyOk.jsp
│        │  └─ commentDeleteFormOk.jsp
│        │
│        ├─ user/                   # 사용자
│        │  ├─ include/
│        │  │  ├─ footer.jsp
│        │  │  └─ header.jsp
│        │  ├─ join.jsp
│        │  ├─ joinOk.jsp
│        │  ├─ login.jsp
│        │  ├─ loginOk.jsp
│        │  ├─ logout.jsp
│        │  ├─ checkEmail.jsp
│        │  └─ checkID.jsp
│        │
│        ├─ js/
│        │  └─ jquery-3.7.1.js
│        ├─ upload/                 # 업로드 파일 저장소
│        │  └─ (이미지 파일들)
│        ├─ home.jsp                # 홈 화면
│        ├─ META-INF/
│        │  └─ MANIFEST.MF
│        └─ WEB-INF/
│           ├─ lib/
│           │  ├─ cos-05Nov2002.jar
│           │  └─ mysql-connector-j-8.1.0.jar
│           └─ web.xml
├─ build/
└─ new.erm                          # ERD 파일
```
---
<a id="quickstart"></a>
## 🚀 시작하기 (설치)

### 요구사항
- JDK 11
- Apache Tomcat 9+
- MySQL 8.x


---


<a id="routing"></a>
## 🧭 URL 매핑(요약)

### Coffee
- 목록/검색: `GET /coffee/list.jsp?searchType=...&id=...&nowPage=n`
- 상세: `GET /coffee/view.jsp?fno={번호}`
- 등록: `GET /coffee/register.jsp`, `POST /coffee/registerOk.jsp`
- 수정: `GET /coffee/modify.jsp?fno=...`, `POST /coffee/modifyOk.jsp`
- 삭제: `POST /coffee/deleteOk.jsp`
- 댓글: `POST /coffee/commentRegisterOk.jsp`, `commentModifyOk.jsp`, `commentDeleteFormOk.jsp`

### Dessert/KoreanTradition/Notice
- 각 모듈 구조 및 엔드포인트 패턴은 Coffee와 동일

---
<a id="erd"></a>
## 🧱 ERD  &  컬럼 설명


```mermaid
erDiagram
  %% ===== Entities =====
  USER {
    INT user_no PK
    VARCHAR user_id
    VARCHAR user_pw
    VARCHAR user_name
    VARCHAR email
    INT age
    CHAR gender
    TIMESTAMP join_date
    CHAR state      "E/D"
    CHAR role       "A/U"
  }

  COFFEE_BOARD {
    INT fno PK
    INT writer_no FK
    VARCHAR title
    TEXT content
    TIMESTAMP rdate
    INT hit
    CHAR state        "N/D"
    CHAR notice_flag  "Y/N"
    VARCHAR origin_filename
    VARCHAR uuid_filename
  }

  DESSERT_BOARD {
    INT fno PK
    INT writer_no FK
    VARCHAR title
    TEXT content
    TIMESTAMP rdate
    INT hit
    CHAR state
    CHAR notice_flag
    VARCHAR origin_filename
    VARCHAR uuid_filename
  }

  KOREAN_TRADITION_DESSERT_BOARD {
    INT fno PK
    INT writer_no FK
    VARCHAR title
    TEXT content
    TIMESTAMP rdate
    INT hit
    CHAR state
    CHAR notice_flag
    VARCHAR origin_filename
    VARCHAR uuid_filename
  }

  NOTICE_BOARD {
    INT fno PK
    INT writer_no FK
    VARCHAR title
    TEXT content
    TIMESTAMP rdate
    INT hit
    CHAR state
    CHAR notice_flag
    VARCHAR origin_filename
    VARCHAR uuid_filename
  }

  COMMENT_C {
    INT cno PK
    INT fno   FK
    INT writer_no FK
    TEXT content
    TIMESTAMP rdate
    CHAR state "N/D"
  }

  COMMENT_D {
    INT cno PK
    INT fno   FK
    INT writer_no FK
    TEXT content
    TIMESTAMP rdate
    CHAR state
  }

  COMMENT_K {
    INT cno PK
    INT fno   FK
    INT writer_no FK
    TEXT content
    TIMESTAMP rdate
    CHAR state
  }

  COMMENT_Q {
    INT cno PK
    INT fno   FK
    INT writer_no FK
    TEXT content
    TIMESTAMP rdate
    CHAR state
  }

  %% ===== Relationships =====
  USER ||--o{ COFFEE_BOARD : writes
  USER ||--o{ DESSERT_BOARD : writes
  USER ||--o{ KOREAN_TRADITION_DESSERT_BOARD : writes
  USER ||--o{ NOTICE_BOARD : writes

  COFFEE_BOARD ||--o{ COMMENT_C : has
  DESSERT_BOARD ||--o{ COMMENT_D : has
  KOREAN_TRADITION_DESSERT_BOARD ||--o{ COMMENT_K : has
  NOTICE_BOARD ||--o{ COMMENT_Q : has

  USER ||--o{ COMMENT_C : comments
  USER ||--o{ COMMENT_D : comments
  USER ||--o{ COMMENT_K : comments
  USER ||--o{ COMMENT_Q : comments

```
### 컬럼 설명
### 👤 USER
| 컬럼명 | 타입 | 설명 |
|--------|------|------|
| `user_no` | INT (PK) | 사용자 고유 번호 (Auto Increment) |
| `user_id` | VARCHAR | 로그인 ID |
| `user_pw` | VARCHAR | 비밀번호 (현재 평문 저장 → 해시 권장) |
| `user_name` | VARCHAR | 사용자 이름 |
| `email` | VARCHAR | 이메일 |
| `age` | INT | 나이 |
| `gender` | CHAR | 성별 (M/F/U) |
| `note` | VARCHAR / TEXT | 비고 (NULL 허용) |
| `join_date` | TIMESTAMP | 가입일 (기본 CURRENT_TIMESTAMP) |
| `state` | CHAR | 상태 (E=정상, D=삭제) |
| `role` | CHAR | 권한 (A=관리자, U=일반 사용자) |

---

### ☕ COFFEE_BOARD
| 컬럼명 | 타입 | 설명 |
|--------|------|------|
| `fno` | INT (PK) | 게시글 번호 |
| `writer_no` | INT (FK → USER.user_no) | 작성자 번호 |
| `title` | VARCHAR | 글 제목 |
| `content` | TEXT | 글 내용 |
| `rdate` | TIMESTAMP | 등록일 |
| `hit` | INT | 조회수 |
| `state` | CHAR | 상태 (E=정상, D=삭제) |
| `notice_flag` | CHAR | 공지글 여부 (Y/N) |
| `uuid_filename` | VARCHAR | 서버 저장 파일명 (UUID) |
| `origin_filename` | VARCHAR | 원본 파일명 |

---

### 🍰 DESSERT_BOARD / KOREAN_TRADITION_DESSERT_BOARD / NOTICE_BOARD
> 구조는 COFFEE_BOARD와 동일

| 컬럼명 | 타입 | 설명 |
|--------|------|------|
| `fno` | INT (PK) | 게시글 번호 |
| `writer_no` | INT (FK → USER.user_no) | 작성자 번호 |
| `title` | VARCHAR | 글 제목 |
| `content` | TEXT | 글 내용 |
| `rdate` | TIMESTAMP | 등록일 |
| `hit` | INT | 조회수 |
| `state` | CHAR | 상태 (E=정상, D=삭제) |
| `notice_flag` | CHAR | 공지글 여부 (Y/N) |
| `uuid_filename` | VARCHAR | 서버 저장 파일명 (UUID) |
| `origin_filename` | VARCHAR | 원본 파일명 |

---

### 💬 COMMENT_C / COMMENT_D / COMMENT_K / COMMENT_Q
> 각 게시판에 대응하는 댓글 테이블 (구조 동일)

| 컬럼명 | 타입 | 설명 |
|--------|------|------|
| `cno` | INT (PK) | 댓글 번호 |
| `fno` | INT (FK → 각 BOARD.fno) | 게시글 번호 |
| `writer_no` | INT (FK → USER.user_no) | 작성자 번호 |
| `content` | TEXT | 댓글 내용 |
| `rdate` | TIMESTAMP | 작성일 |
| `state` | CHAR | 상태 (E=정상, D=삭제) |
---

<a id="policy"></a>
## 🔒 정책
- 삭제: 게시글/댓글 삭제 시 state='D' 처리
- 파일 업로드: COS 라이브러리 사용, 저장 파일명은 UUID
- 페이징: PagingUtil로 계산 후 LIMIT ?, ? 사용
