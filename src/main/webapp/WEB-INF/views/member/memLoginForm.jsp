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
<script type="text/javascript">
$(document).ready(function(){
	if(${!empty msgType}){
		$("#messageType").attr("class","modal-content panel-warning");
		$("#myMessage").modal("show");	
	}
});
</script>
</head>
<body>

<div class="container">
<jsp:include page="../common/header.jsp"/>
  <h2>Panel Heading</h2>
  <div class="panel panel-default">
    <div class="panel-heading">로그인화면</div>
    <div class="panel-body">
    	 <form action="${contextPath}/memLogin.do" method="post">
      	<table class="table table-bordered" style="text-align:center; border: 1px solid #dddddd;" >
      	  <tr>
      	    <td style="width:110px; vertical-align: middle;">아이디</td>
      	    <td><input id="memID" name="memID" class="form-control" type="text" placeholder="아이디" maxlength="20"/></td>
      	  </tr>
      	  <tr>
      	    <td style="width:110px; vertical-align: middle;">비밀번호</td>
      	    <td colspan="2"><input id="memPassword" name="memPassword" class="form-control" type="password" placeholder="비밀번호" maxlength="20"/></td>
      	  </tr>
      	  <tr>
      	    <td colspan="2" style="text-align: left;">
      	    	<input type="submit" value="로그인" class="btn btn-primary btn-sm pull-right"/>
      	    </td>
      	  </tr>
      	</table>
      </form>
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
</div>

</body>
</html>
