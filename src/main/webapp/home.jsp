<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>home</title>
	    <style>
        body {
            background-color: #353535;
            margin: 0px;
            padding:0px;
        }
       /*----------------------------------------로고  css------------------------------------------------------*/
        h1 {
            font-family:Impact, Haettenschweiler, 'Arial Narrow Bold', sans-serif;
            color: #D8D8D8;
            padding-left: 100px;
            font-size: 70pt;
            color: #D8D8D8;

        }
        /*----------------------------------------목록 hover css------------------------------------------------------*/
        *, *:after, *:before {
            -webkit-box-sizing: border-box;
            -moz-box-sizing: border-box;
            box-sizing: border-box;
        }
        .menu {
            height: 30px;
            background-color: #353535;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 5px;
            list-style: none;
            padding: 30px;
        }
        nav a:hover, a:focus {
            outline: none;
        }
        .menu a {
            color: rgba(255, 255, 255, 0.8);
            font-family: Lato;
            font-size: 17pt;
            font-weight: 400;
            padding: 15px 25px;           
            position: relative;
            display: block;
            text-decoration: none;
            text-transform: uppercase;
        }
        .effect a:before, .effect a:after {
            position: absolute;
            top: 100%;
            left: 0;
            width: 100%;
            height: 2px;
            background: rgba(255, 255, 255, 0.5);
            content: '';
            -webkit-transition: -webkit-transform 0.3s;
            -moz-transition: -moz-transform 0.3s;
            transition: transform 0.3s;
            -webkit-transform: scale(0.85);
            -moz-transform: scale(0.85);
            transform: scale(0.85);
        }
        .effect a:after {
            opacity: 0;
            -webkit-transition: top 0.3s, opacity 0.3s, -webkit-transform 0.3s;
            -moz-transition: top 0.3s, opacity 0.3s, -moz-transform 0.3s;
            transition: top 0.3s, opacity 0.3s, transform 0.3s;
        }

        .effect a:hover:before, .effect a:hover:after, .effect a:focus:before, .effect a:focus:after {
            -webkit-transform: scale(1);
            -moz-transform: scale(1);
            transform: scale(1);
            background: #c8a755;
        }

        .effect a:hover:after, .effect a:focus:after {
            top: 0%;
            opacity: 1;
        }
    /*----------------------------------------이미지 hover css------------------------------------------------------*/
        .column {
            margin: 250px 250px 400px;
            padding: 20px;
        }
        .column:last-child {
            padding-bottom: 60px;
        }
        .column::after {
            content: '';
            clear: both;
            display: block;
        }
        .column div {
            position: relative;
            float: left;
            width: 300px;
            height: 200px;
            margin: 0 0 0 25px;
            padding: 0;
        }
        figure {
            width: 300px;
            height: 200px;
            margin: 0;
            padding: 0;                 
            overflow: hidden;
            display: flex;
            justify-content: space-between;                
        }

        .hover figure:hover img {
            opacity: 1;
            -webkit-animation: flash 1.5s;
            animation: flash 1.5s;
        }
        @-webkit-keyframes flash {
                0% {
                opacity: .4;
            }
                100% {
                opacity: 1;
            }
        }
        @keyframes flash {
                0% {
                opacity: .4;
            }
                100% {
                opacity: 1;
            }
        }
        .figure :hover  img{
            opacity: 1;
            -webkit-animation: flash 1.5s;
            animation: flash 1.5s;
           
        }
        @-webkit-keyframes flash {
                0% {
                opacity: .4;
            }
                100% {
                opacity: 1;
            }
        }
        @keyframes flash {
                0% {
                opacity: .4;
            }
                100% {
                opacity: 1;
            }
        }

        .title_inner{
            position: relative;
            display: flex;
            width: 100%;
        }
        .login{
            position: absolute;
            right: 30px;
            top: 30px;
           
        }
        .login a{
            color: #D8D8D8;
            font-size: 15pt;
            font-family: Lato;

        }
       
    </style>
	</head>
	<body>
	<header>
        <div class="title_inner">
            <div>
              <h1>rkit</h1>
            </div>
            <div class="login">
<%--             	<%String id = ""; 
	            	if(session.getAttribute("id") != null){
	            	id = (String)session.getAttribute("id");
            	} %>
 --%>				<%
				String userlevel = (String)session.getAttribute("authorization");
				if(userlevel != null && !userlevel.equals("") ){
					if(userlevel.equals("A")){	%>
						<div>
							관리자님 이시군요!
						</div>
						<a href="./user/logout.jsp">logout</a>
<%					}else{
						String userName = (String)session.getAttribute("name");	%>
						<div>
							<strong><%= userName %></strong>님, 반갑습니다
						</div>	
						<a href="./user/logout.jsp">logout</a>
<%					}
				}else{
				%>
              <a href="./user/login.jsp" >login</a>
          
              <a href="./user/join.jsp" >join</a>
<%				} %>
            </div>
          </div>
        <nav>
            <div >
                <ul class="menu effect">
                  <li><a href="home.jsp">home</a></li>
                  <li><a href="./coffee/list.jsp">coffee</a></li>
                  <li><a href="./kore/list.jsp">koreantraditiondessert</a></li>
                  <li><a href="./dess/list.jsp">dessert</a></li>
                  <li><a href="./notice/list.jsp">noticeboard</a></li>
                </ul>
            </div>
        </nav>
      </header>
      <section>
        <div class="hover column">
            <div>
                <figure>
                <img src="https://cdn.pixabay.com/photo/2017/02/27/15/12/rice-2103481_960_720.jpg">
                </figure>
            </div>
            <div>
                <figure>
                <img src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_1280.jpg">
                </figure>
            </div>
            <div>
                <figure>
                <img src="https://cdn.pixabay.com/photo/2017/08/01/14/22/fruits-2565817_1280.jpg">
                </figure>
            </div>
            <div>
                <figure>
                <img src="https://cdn.pixabay.com/photo/2017/08/02/00/51/food-2569257_1280.jpg">
                </figure>
            </div>
        </div>
      </section>
	
	</body>
</html>