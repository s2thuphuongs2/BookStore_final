<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<jsp:include page="head.jsp"></jsp:include>
<title>Trang chủ</title>

<style>
.body {
	background: #efeff4;
	padding: 3rem 3rem;
}

.type-title {
	background: #5f73ea;
	width: 25% !important;
	font-size: 1.5rem;
	line-height: 3rem;
	color: white;
	clip-path: polygon(0 0, 80% 0, 100% 50%, 80% 100%, 0 100%);
	border-bottom-left-radius: 20px ;
}

.item {
	display: block;
	padding: 0.5rem;
	text-decoration: none;
}

.book {
	width: 100%;
	background: white;
	box-shadow: 0 .5rem 1rem rgba(0, 0, 0, .15);
	padding: 1rem 2rem;
}

.book:hover {
	box-shadow: 0 1rem 3rem rgba(0, 0, 0, .25);
}

.book-image {
	width: 100%;
	object-fit: contain;
}

.book-title {
	color: #3388ff;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	overflow: hidden;
}

.book-price {
	color: red;
}

body {
	height: 100vh;
}

.bg-white {
	border-radius: 15px;
}
</style>
</head>

<body class="d-flex flex-column">
	<jsp:include page="header.jsp"></jsp:include>

	<div class="body flex-grow-1" >
		
		
		<div class="row">
			<div class="row bg-white mb-2">
				<div class="type-title">Sách mới</div>
			</div>
			<div class="row">
				<c:forEach var="book" items="${latestbooks }">
					<div class="col col-3 p-2">
						<a class="item" href="/book/${book.id}">
							<div class="book">
								<img class="book-image"
									src="data:image/webp;base64,${book.image}">
								<div class="book-title">${book.name}</div>
								<div class="book-price">${book.getPriceString()} VND</div>
							</div>
						</a>
					</div>
				</c:forEach>
			</div>
		</div>
		
		<div class="row">
			<div class="row bg-white mb-2">
				<div class="type-title">Ngẫu nhiên</div>
			</div>
			<div class="row">
				<c:forEach var="book" items="${randbooks }">
					<div class="col col-3 p-2">
						<a class="item" href="/book/${book.id}">
							<div class="book">
								<img class="book-image"
									src="data:image/webp;base64,${book.image}">
								<div class="book-title">${book.name}</div>
								<div class="book-price">${book.getPriceString()} VND</div>
							</div>
						</a>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>

	<jsp:include page="modal/register.jsp"></jsp:include>

</body>
</html>