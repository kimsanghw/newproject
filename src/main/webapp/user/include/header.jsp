<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login</title>
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
            margin: 20px;
            padding-left: 100px;
            font-size: 70pt;
        }
       

        /*----------------------------------------목록 hover css------------------------------------------------------*/
        *, *:after, *:before {
            -webkit-box-sizing: border-box;
            -moz-box-sizing: border-box;
            box-sizing: border-box;
        }
        .menu {
            height: 30px;
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

       
         /*----------------------------------------로그인  css------------------------------------------------------*/
        footer{
                       
            height: 50px;
            text-align: center;
            padding-top: 50px;
            
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
        
        
        .btn {
            width: 100px;
            height: 30px;
            background-color: #585858;
            color: #FAFAFA;
            border: none; /* none 속성값 비움 */
            border-radius: 5px;
        }
        table {
            width: 400px;
            height: auto;
            background-color:#FAFAFA;
            border-radius: 5px;
            padding: 10px;
           
        }
        h2 {
          font-family: Lato;
          color:#585858;
          text-align: center;
          margin: 20px;
        }
        td{
          text-align: left;
        }
        form{
          width: 400px;
          margin: 80px 750px;
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
	          	<a href="../user/login.jsp" >login</a>
	          	<a href="../user/join.jsp">join</a>
	          </div>
          </div>
          
        <nav>
            <div class="column">
                <ul class="menu effect">
                  <li><a href="../home.jsp">home</a></li>
                  <li><a href="../west/list.jsp">coffee</a></li>
                  <li><a href="../kore/list.jsp">koreantraditiondessert</a></li>
                  <li><a href="../dess/list.jsp">dessert</a></li>
                  <li><a href="../notice/list.jsp">noticeboard</a></li>
                </ul>
              </div>
        </nav>
      </header>

