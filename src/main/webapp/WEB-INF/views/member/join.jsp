<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<head>
  <title>template</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>

<script type="text/javascript">

$(document).ready(function(){
	if(${!empty msgType}){
		$("#messageType").attr("class","modal-content panel-warning");
		$("#myMessage").modal("show");	
	}
});

function registerCheck() {
	var memID = $("#memID").val();
	$.ajax({
		url : "${contextPath}/memRegisterCheck.do",
		type : "get",
		data : {"memID" : memID},
		success : function(result) {
			//중복 유무 체크(result = 1 사용할 수 있는 아이디)
			if(result ==1) {
				$("#checkMessage").html("사용할 수 있는 아이디입니다.");
				$("#checkType").attr("class","modal-content panel-success")
			}else {
				$("#checkMessage").html("사용할 수 없는 아이디입니다.");
				$("#checkType").attr("class","modal-content panel-danger")
			}
			$("#myModal").modal("show");
		},
		error : function() {alert("error");}
	});
}

function passwordCheck() {
	var memPassword1 = $("#memPassword1").val();
	var memPassword2 = $("#memPassword2").val();
	if (memPassword1 != memPassword2) {
		$("#passMessage").html("비밀번호가 일치하지 않습니다.");
	}else {
		$("#passMessage").html("");
		$("#memPassword").val(memPassword1);
	}		
}

function goInsert() {
	var memAge= $("#memAge").val();
	if (memAge == null || memAge == "" || memAge == 0) {
		alert("나이를 입력하세요");
		return false;
	}
	document.frm.submit();
}
</script>

<body>

<div class="container">
<jsp:include page="../common/header.jsp"/>
  <h2>Panel Heading</h2>
  <div class="panel panel-default">
    <div class="panel-heading">회원가입</div>
    <div class="panel-body">
      <form action="${contextPath}/memRegister.do" method="post">
        <input type="hidden" name="memPassword" id="memPassword" value=""/>
      	<table class="table table-bordered" style="text-align:center; border: 1px solid #dddddd;" >
      	  <tr>
      	    <td style="width:110px; vertical-align: middle;">아이디</td>
      	    <td><input id="memID" name="memID" class="form-control" type="text" placeholder="아이디" maxlength="20"/></td>
      	    <td style="width:110px;"><button type="button" class="btn btn-primary btn-sm" onclick="registerCheck();">중복확인</button></td>
      	  </tr>
      	  <tr>
      	    <td style="width:110px; vertical-align: middle;">비밀번호</td>
      	    <td colspan="2"><input id="memPassword1" name="memPassword1" onkeyup="passwordCheck();" class="form-control" type="password" placeholder="비밀번호" maxlength="20"/></td>
      	  </tr>
      	  <tr>
      	    <td style="width:110px; vertical-align: middle;">비밀번호 확인</td>
      	    <td colspan="2"><input id="memPassword2" name="memPassword2" onkeyup="passwordCheck();" class="form-control" type="password" placeholder="비밀번호 확인" maxlength="20"/></td>
      	  </tr>
      	  <tr>
      	    <td style="width:110px; vertical-align: middle;">이름</td>
      	    <td colspan="2"><input id="memName" name="memName" class="form-control" type="text" placeholder="이름" maxlength="20"/></td>
      	  </tr>
      	  <tr>
      	    <td style="width:110px; vertical-align: middle;">나이</td>
      	    <td colspan="2"><input id="memAge" name="memAge" class="form-control" type="text" placeholder="나이" maxlength="20" value="0"/></td>
      	  </tr>
      	  <tr>
      	    <td style="width:110px; vertical-align: middle;">성별</td>
      	    <td colspan="2">
      	      <div class="form-group" style="text-align: center; margin:0 auto;">
      	        <div class="btn-group" data-toggle="buttons">
      	          <label class="btn btn-primary active">
      	          	<input id="memGender" name="memGender" type="radio" autocomplete="off" value="남자" checked/>남자
      	          </label>
      	          <label class="btn btn-primary">
      	          	<input id="memGender" name="memGender"  type="radio" autocomplete="off" value="여자" />여자
      	          </label>
      	        </div>
      	      </div>
      	    </td>
      	  </tr>
      	  <tr>
      	    <td style="width:110px; vertical-align: middle;">이메일</td>
      	    <td colspan="2"><input id="memEmail" name="memEmail" class="form-control" type="text" placeholder="이메일" maxlength="20"/></td>
      	  </tr>
      	  <tr>
      	    <td colspan="3" style="text-align: left;">
      	    	<span id="passMessage" style="color:red;"></span><input type="submit" value="등록" onclick ="goInsert();"class="btn btn-primary btn-sm pull-right"/>
      	    </td>
      	  </tr>
      	</table>
      </form>
    </div>
    

  <!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div id="checkType" class="modal-content">
        <div class="modal-header panel-heading">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">메세지 확인</h4>
        </div>
        <div class="modal-body">
          <p id="checkMessage"></p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>
  
  <!-- 실패 메세지 -->
  <div class="modal fade" id="myMessage" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div id="messageType" class="modal-content panel-info">
        <div class="modal-header panel-heading">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">${msgType }</h4>
        </div>
        <div class="modal-body">
          <p>${msg }</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>
</div>
    
    <div class="panel-footer">footer</div>
  </div>

</body>
</html>
