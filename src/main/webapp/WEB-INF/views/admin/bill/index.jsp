<%@page import="tdtu.bookstore.model.Bill"%>
<%@page import="tdtu.bookstore.model.User"%>
<%@page import="tdtu.bookstore.repository.UserRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%
	UserRepository userRepository = (UserRepository) request.getAttribute("userRepository");
%>

<%!public String getUser(Integer userid, UserRepository userRepository) {

	User user = userRepository.findById(userid).get();
	return user.getUsername();
}%>
<!DOCTYPE html>
<html data-bs-theme="light" lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.12.0/css/all.css">
	<jsp:include page="../../../assets/js/script.min.jsp"></jsp:include>
	<jsp:include page="../../../assets/bootstrap/css/bootstrap.min.jsp"></jsp:include>
	<jsp:include page="../../head.jsp"></jsp:include>
</head>
<body id="page-top">
<div id="wrapper">
	<nav class="navbar align-items-start sidebar sidebar-dark accordion bg-gradient-primary p-0 navbar-dark">
		<div class="container-fluid d-flex flex-column p-0"><a
				class="navbar-brand d-flex justify-content-center align-items-center sidebar-brand m-0" href="/">
			<div class="sidebar-brand-icon rotate-n-15"><i class="fas fa-laugh-wink"></i></div>
			<div class="sidebar-brand-text mx-3"><span>ADMIN</span></div>
		</a>
			<hr class="sidebar-divider my-0">
			<ul class="navbar-nav text-light" id="accordionSidebar">
				<li class="nav-item"><a class="nav-link" href="/"><i class="fas fa-home"></i><span>Home</span></a></li>
				<li class="nav-item"><a class="nav-link" href="/admin/books"><i class="fas fa-book"></i><span>Books</span></a></li>
				<li class="nav-item"><a class="nav-link" href="/admin/authors"><i class="fas fa-user"></i><span>Author</span></a></li>
				<li class="nav-item"><a class="nav-link" href="/admin/publishers"><i class="fas fa-building"></i><span>Publisher</span></a></li>
				<li class="nav-item"><a class="nav-link" href="/admin/categories"><i class="fas fa-list"></i><span>Category</span></a></li>
				<li class="nav-item"><a class="nav-link active" href="/admin/bills"><i class="fas fa-money-bill"></i><span>Bills</span></a></li>
				<li class="nav-item"><a class="nav-link" href="/admin/users"><i class="fas fa-users"></i><span>Users</span></a></li>
				<li class="nav-item"><a class="nav-link" href="/logout"><i class="fas fa-sign-out-alt"></i><span>Logout</span></a></li>
			</ul>
			<div class="text-center d-none d-md-inline">
				<button class="btn rounded-circle border-0" id="sidebarToggle" type="button"></button>
			</div>
		</div>
	</nav>
	<div class="d-flex flex-column" id="content-wrapper">
		<div id="content">
			<div class="d-sm-flex justify-content-between align-items-center mb-4">
				<h3 class="text-dark mb-0">Quản Lý Hóa Đơn</h3>
			</div>

			<div class="overflow-auto">
				<table class="table-responsive table mt-2">
					<thead>
					<tr class="table-secondary">
						<th scope="col">Id</th>
						<th scope="col">Tên người dùng</th>
						<th scope="col">Ngày đặt</th>
						<th scope="col">Tổng hóa đơn</th>
						<th scope="col">Trạng thái</th>
						<th scope="col">Thao tác</th>
					</tr>
					</thead>
					<tbody>
					<c:forEach items="${bills}" var="bill">
						<tr>
							<td>${bill.id}</td>
							<td><%=getUser(((Bill) pageContext.getAttribute("bill")).getUserid(), userRepository)%></td>
							<td>${bill.adddate}</td>
							<td><span class="book-price fw-bold">${bill.getTotalPriceString()}
								VND</span></td>
							<td><c:choose>
								<c:when test="${bill.status == 0}">
									Chưa giao hàng
								</c:when>
								<c:when test="${bill.status == -1}">
									Hủy giao hàng
								</c:when>
								<c:otherwise>
									Đã giao hàng
								</c:otherwise>
							</c:choose></td>
							<td>
								<button class="btn btn-primary" data-bs-toggle="modal"
										data-bs-target="#viewModal" onclick="viewBill(${bill.id})">
									<i class="fa-solid fa-eye"></i>
								</button>
							</td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
			</div>


			<div class="modal fade modal-lg" id="viewModal" tabindex="-1">
				<form method="post" action="/admin/books" id="viewForm">
					<div class="modal-dialog"  id="modalBody">

					</div>
				</form>
			</div>

		</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	<jsp:include page="../../../assets/js/script.min.jsp"></jsp:include>
</body>
</html>