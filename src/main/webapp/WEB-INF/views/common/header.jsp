<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>
</head>
<body>
<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="${contextPath }">web</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
        <li class="active"><a href="${contextPath }/">Home</a></li>
        <li><a href="boardMain.do">게시판</a></li>
        <li><a href="#">Page 2</a></li>
      </ul>
      
      <c:if test="${empty mvo}">
	      <ul class="nav navbar-nav navbar-right">
	            <li><a href="${contextPath }/memLoginForm.do"><span class="glyphicon glyphicon-log-in"></span> 로그인</a></li>
	            <li><a href="${contextPath }/memJoin.do"><span class="glyphicon glyphicon-user"></span> 회원가입</a></li>
	      </ul>
      </c:if>
      <c:if test="${!empty mvo}">
	      <ul class="nav navbar-nav navbar-right">
	            <li><a href="${contextPath }/memUpdateForm.do"><span class="glyphicon glyphicon-wrench"></span> 회원정보수정</a></li>
	            <li><a href="${contextPath }/memImageForm.do""><span class="glyphicon glyphicon-picture"></span> 사진등록</a></li>
	            <li><a href="${contextPath }/memLogout.do"><span class="glyphicon glyphicon-log-out"></span>로그아웃</a></li>
	      		  <c:if test="${empty mvo }">
				    <label>환영합니다.</label>
				  </c:if>
				  <c:if test="${!empty mvo }">
				  	<c:if test="${mvo.memProfile eq ''}">
				  		<li style="color:white;"><img src="${contextPath }/resources/images/person.png"  class="img-circle"style="width:50px; height:50px;">${mvo.memName }</li>
				  	</c:if>
				  	<c:if test="${mvo.memProfile ne ''}">
				  		<li><img src="${contextPath}/resources/upload/${mvo.memProfile}" style="width:50px; height:50px;" class="img-circle">${mvo.memName }</li>
				  	</c:if>
				  </c:if>
	      </ul>
      </c:if>
      
    </div>
  </div>
</nav>
</body>
</html>