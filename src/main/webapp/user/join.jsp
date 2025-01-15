<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./include/header.jsp" %>
<script src="<%=request.getContextPath() %>/js/jquery-3.7.1.js"></script>
<script>
		
		var idCheckFlag = false;
		function idCheck() {
			if(idCheckFlag == true){ return true; }
			var idPattern = /^[a-zA-Z0-9-]+$/;
			let obj = document.getElementById("id");
			let msgBox = document.getElementsByClassName("msgbox")[0];
			if( obj.value == "" ) {
				msgBox.innerHTML = "<span style='color:black'>아이디를 입력하세요</span>";
				
				return false;
			}else if( obj.value.length < 4 || obj.value.length > 15 || !idPattern.test(obj.value)) {
				msgBox.innerHTML = "<span style='color:black'>아이디는 4글자 이상 15글자 이하 영문 대소문자 숫자로 조합하여 입력하세요</span>";
				
				return false;
			}else{
				let value = $("#id").val();
				$.ajax({
					url : "checkID.jsp",
					type : "get",
					data : "id=" +value,
					success : function(data) {
						if(data.trim() == "isid"){
							$(".msgbox:eq(0)").html("사용할 수 없는 아이디입니다.");
							
							return false;
						}else {
							$(".msgbox:eq(0)").html("사용할수 있는 아이디입니다");
							idCheckFlag = true;
							return true;
							}
						
					}	
				});
			}

		}
			
		
		function pwCheck() {
			var pwPattern = /^[a-z0-9_-]{1,10}$/;
			let obj = document.getElementById("pw");
			let msgBox = obj.parentElement.getElementsByClassName("msgbox")[0];
			if( obj.value == "" ) {
				msgBox.innerHTML = "<span style='color:black'>비밀번호를 입력하세요</span>";
				obj.focus();
				return false;
			}else if(obj.value.trim() == "" || obj.value.length < 8 || !pwPattern.test(obj.value)) {
				msgBox.innerHTML = "<span style='color:black'>비밀번호는 8글자 이상 영문 대소문자 숫자로 조합하여 입력하세요 </span>";				
				
				return false;
			}else {
				msgBox.innerHTML = "";
				return true;
				
			}
			
		}
		
		function pwcCheck() {
			let obj = document.getElementById("pwc");
			let msgBox = obj.parentElement.getElementsByClassName("msgbox")[0];
			if( obj.value == "" ) {
				msgBox.innerHTML = "<span style='color:black'>비밀번호 확인을 입력하세요</span>";
				obj.focus();
				return false;
			}else if( obj.value.trim() == "" || obj.value.length < 8 ) {
				msgBox.innerHTML = "<span style='color:black'>비밀번호 확인은 8글자 이상 영문 대소문자 숫자로 조합하여 입력하세요</span>";				
				obj.focus();
				return false;
			}else {
				msgBox.innerHTML = "";
				return true;
				
			}
			
		}
		
		function pwMath() {
			let pw = document.getElementById("pw");
			let pwc = document.getElementById("pwc");
			msgBox = pwc.parentElement.getElementsByClassName("msgbox")[0];
			if( pw.value != pwc.value )
			{
				msgBox.innerHTML = "<span style='color:black'>비밀번호 확인이 일치하지 않습니다</span>";				
				pwc.focus();
				return false;
			}else {
				msgBox.innerHTML = "";
				return true;
				
					
			}
			
		}
		
		function nameCheck() {
			var namePattern = /^[가-힣]+$/;
			let obj = document.getElementsByName("name")[0];
			let msgBox = obj.parentNode.getElementsByClassName("msgbox")[0];
			if( obj.value == "" ) {
				msgBox.innerHTML = "<span style='color:black'>이름을 입력하세요</span>";
				obj.focus();
				return false;
			}else if(obj.value.trim() == "" ||  obj.value.length < 2 ||  !namePattern.test(obj.value) ) {
				msgBox.innerHTML = "<span style='color:black'>이름은 2글자 이상 한글로만 입력하세요</span>";				
				obj.focus();
				return false;
			}else {
				msgBox.innerHTML = "";
				return true;
				
			}
			
		}
		
		function emailCheck() {
			var emailPattern = /^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;
			let obj = document.getElementById("email");
			let msgBox = obj.parentNode.getElementsByClassName("msgbox")[0];
			if( obj.value == "" ) {
				msgBox.innerHTML = "<span style='color:black'>이메일을 입력하세요</span>";
				obj.focus();
				return false;
			}else if(!emailPattern.test(obj.value)){
				msgBox.innerHTML = "<span style='color:black'>유효한 이메일 주소를 입력하세요</span>";
		        obj.focus();
		        return false;
				
			}else {
				let value = $("#email").val();
				$.ajax({
					url : "checkEmail.jsp",
					type : "get",
					data : "email=" +value,
					success : function(data) {
						if(data.trim() == "isemail"){
							$(".msgbox:eq(5)").html("사용할 수 없는 이메일입니다.");
							obj.focus();
							return false;
						} else {
							$(".msgbox:eq(5)").html("사용할 수 있는 이메일입니다.");
							return true;
						}
					}
				});
				
			}
			
		}
		
		function ageCheck(){
			let obj = document.getElementsByName("age")[0];
			let msgBox = obj.parentNode.getElementsByClassName("msgbox")[0];
			if( obj.value == "" ){
				msgBox.innerHTML = "<span style='color:black'>나이를 입력하세요</span>";
				obj.focus();
				return false;
			}else if(obj.value.trim() == "" || obj.value < 14 ) {
				msgBox.innerHTML = "<span style='color:black'>나이를 14이상 입력하세요</span>";
				obj.focus();
				return false;			
			}else {
				msgBox.innerHTML = "";			
				return true;
				
			}
			
		}
		
		function DoJoin(){
			
			if(idCheck() == false) return false;
		
			if(pwCheck() == false) return false;
		
			if(pwcCheck() == false) return false;
			
			if(pwMath() == false) return false;
			
			if(ageCheck() == false) return false;
			
			if(nameCheck() == false) return false;
			
			if(emailCheck() == false) return false;

			
			if( confirm("회원가입을 진행하시겠습니까?") == false ) {
				return false;
			}else {
				return true;
			}
		}
		
		function DoReset(obj){
			idCheckFlag = false;
			let msgBox = obj.parentNode.getElementsByClassName("msgbox")[0];
			msgBox.innerHTML = "";
			idCheck();
		}
		
		
		
	</script>
	<section >
        <form action="joinOk.jsp" method="post"  onsubmit="return DoJoin();">
          <div style="background-color: #FAFAFA; margin: 10px; border-radius: 5px; padding: 10px;">
          <h2>join</h2>
          <div>
            아이디<br>
                <input type="text"  id="id" name="id" oninput="idCheck();"  onblur="idCheck();" onkeyup="DoReset(this);">       
			    <div class="msgbox"></div>
          </div>
          <br>
          <div>
            비밀번호<br>
                <input type="password"  id="pw" name="pw" onblur="pwCheck()">
                <div class="msgbox"></div>
          </div>
          <br>
          <div>
            비밀번호 확인<br>
                <input type="password"  id="pwc" name="pwc" onblur="if(pwcCheck())pwMath();">
                <div class="msgbox"></div>
          </div>
          <br>
          <div>
            나이<br>
                <input type="number" name="age"  onblur="ageCheck();">
                <div class="msgbox"></div>
          </div>
          <br>
          <div>
            이름<br>
                <input type="text" name="name" onblur="nameCheck();">
                <div class="msgbox"></div>
          </div>
          <br>
          <div>
            이메일<br>
                <input type="email" name="email" id="email" onblur="emailCheck();">
                <div class="msgbox"></div>
          </div>
          <br>
          <div>
            <label>성별<br>
              <label>여성<input type="radio" name="gender" value="F"></label>
              <label>남성<input type="radio" name="gender" value="M"></label>
              <label>미공개<input type="radio" name="gender" value="U" checked></label>
           </label>
          </div>
          <br>
          <div>
            <label>관심분야<br>
              <label>한식디저트<input type="radio" name=" interest" value="A"></label>
              <label>제과<input type="radio" name=" interest" value="B"></label>
              <label>제빵<input type="radio" name=" interest" value="C"></label>
              <label>초콜릿<input type="radio" name=" interest" value="D"></label><br>
              <label>디저트<input type="radio" name=" interest" value="E"></label>
              <label>커피<input type="radio" name=" interest" value="F"></label>
           </label>
          </div>
          <br><br>
          <div style="text-align: center;">
            <label>
              <input type="submit" value="회원가입" class="btn">
              <input type="reset" value="취소" class="btn">
            </label>
          </div>
          </div>
       </form>
      </section>
<%@ include file="./include/footer.jsp" %>
                       