
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<jsp:include page="head.jsp"></jsp:include>
<title>Thể loại ${category.name}</title>

<style>
.body {
	background: #efeff4;
	padding: 3rem 3rem;
}

.type-title {
	background: red;
	width: 25%;
	font-size: 1.5rem;
	line-height: 3rem;
	color: white;
	clip-path: polygon(0 0, 80% 0, 100% 50%, 80% 100%, 0 100%);
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
	border-radius: 0.25rem;
	padding: 1rem 2rem;
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
</style>
</head>

<body class="d-flex flex-column">
	<jsp:include page="header.jsp"></jsp:include>

	<div class="body flex-grow-1">
		<div class="row mb-4">
			<div class="row mb-2 fs-3" style="color: #3388ff;">Thể loại
				${category.name }</div>
			<div class="row">
				<c:forEach var="book" items="${books}">
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