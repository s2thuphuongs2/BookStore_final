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

.book-info {
	place-self: center;
	text-align: center;
}
</style>
</head>

<body class="d-flex flex-column">
	<jsp:include page="header.jsp"></jsp:include>

	<div class="body flex-grow-1">
		<div class="row mb-4">
			<div class="row mb-2 fs-3" style="color: #3388ff;">Hóa đơn</div>

			<div class="book row p-0">
				<table class="table table-hover table-striped m-0">
					<thead>
						<tr class="table-secondary">
							<th scope="col">Mã Đơn</th>
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
								<td>${bill.adddate}</td>
								<td><span class="book-price fw-bold">${bill.getTotalPriceString()}
										VND</span></td>
								<td><c:choose>
										<c:when test="${bill.status == 0}">
									Đang giao
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
										data-bs-target="#viewModal" onclick="view(${bill.id})">
										<i class="fa-solid fa-eye"></i>
									</button>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>

	<div class="modal fade modal-lg" id="viewModal" tabindex="-1">
		<form method="post" action="/admin/books" id="viewForm">
			<div class="modal-dialog">
				<div class="modal-content" id="modalBody"></div>
			</div>
		</form>
	</div>
	
	<jsp:include page="modal/register.jsp"></jsp:include>
</body>

<script>
var curBillid = 0;

async function view(billid) {
	curBillid = billid;
	const response = await fetch('/bills/'+billid);
	const billdetail = await response.text();
	$("#modalBody").html(billdetail);
}

function cancelBill() {
    $.ajax({
        url: '/bills/'+curBillid+'/cancel',
        type: 'post',
        success: (data) => {
        	if (data.includes("cancel_success")) {
        		window.location.replace("/bills")
        	} else {
        		alert("Hủy đơn thất bại")
        	}
        }
    });
}
</script>
</html>