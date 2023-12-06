<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
.row, .col {
	margin: 0;
	padding: 0;
}

.header {
	background: linear-gradient(#2079ff, #cedff6);
	margin: 0;
}

.header-top {
	height: 7.5rem;
	margin: 0;
}

.header-bottom {
	background: white;
	color: #3388ff;

	justify-content: center;
	margin: 0;
	font-family: "JetBrains Mono ExtraBold", Helvetica, Arial, sans-serif;
}

.search-bar {
	padding: 1px;
	width: 100%;
	height: 2.5rem;
	background: white;
}

.search-bar-input {
	width: 80%;
	border: 0;
	outline: 0;
}

.search-bar-button {
	width: 20%;
	outline: 0;
	border: 0;
	color: white;
	background: #3388ff;
}

.search-bar-button:hover {
	background: #0a3067;
}

.cart-button {
	color: white;
}

.login-button {
	color: white;
}

.category {
	flex: 0 0 fit-content;
	font-weight: bold;
	font-size: 1.2rem;
	line-height: 2rem;
	padding: 0 0.5rem;
	text-decoration: none;
}

.click-up {
	color: white;
	text-decoration: none;
}

.click-up:hover {
	color: lightblue;
	cursor: pointer;
}
</style>


<div class="header">
	<div class="row header-top">
		<div class="col col-3 h-100 d-flex justify-content-center">
			<a class="d-block" href="/"><img class="h-100"
				src="/images/logo.svg"></a>
		</div>
		<div class="col col-6 align-self-center">
			<form class="search-bar row shadow rounded-1" action="/search"
				method="get">
				<input type="text" name="q" value="${query}"
					placeholder="Tìm kiếm... " class="search-bar-input"
					autocomplete="off">
				<button class="search-bar-button rounded-1">
					<i class="fa-solid fa-magnifying-glass"></i> Tìm kiếm
				</button>
			</form>
		</div>
		<div class="col col-3 align-self-center d-flex justify-content-center">
			<div class="row w-100">
				<div class="col-6 login-button">
					<div class="row">
						<div class="col flex-grow-0">
							<i class="fa-solid fa-user fs-2"></i>
						</div>
						<div class="col ms-2">
							<c:choose>
								<c:when test="${username == 'admin'}">
									<a class="d-block click-up" href="/admin"><div class="row lh-1" id="logged">${username}</div></a>
									<a class="d-block click-up" href="/logout"><div
											class="row lh-1">Đăng xuất</div></a>
								</c:when>
								<c:when test="${username != ''}">
									<div class="row lh-1" id="logged">${username}</div>
									<a class="d-block click-up" href="/logout"><div
											class="row lh-1">Đăng xuất</div></a>
								</c:when>
								<c:otherwise>
									<a class="d-block click-up" href="/login"><div
											class="row lh-1">Đăng nhập</div></a>
									<a class="d-block click-up">
										<div class="row lh-1" onclick="registerModal()">Đăng ký</div>
									</a>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>

				<div class="col-6 cart-button">

					<div class="row">
						<div class="col flex-grow-0">
							<i class="fa-solid fa-cart-shopping fs-2"></i>
						</div>
						<div class="col ms-2">
							<div class="row lh-1"><a class="d-block click-up" href="/checkout">Giỏ hàng <b id="cartCount">${cartcount}</b></a></div>
							<div class="row lh-1"><a class="d-block click-up" href="/bills">Hóa đơn</a></div>
						</div>
					</div>
				</div>


			</div>
		</div>
	</div>
	<div class="row header-bottom">
		<c:forEach var="categoryEach" items="${categories}">
			<a class="col category" href="/category/${categoryEach.id}">${categoryEach.name}</a>
		</c:forEach>
	</div>
</div>

<script>
	function registerModal() {
		const registerModal = new bootstrap.Modal(document
				.getElementById('registerModal'))
		registerModal.show()
	}
</script>