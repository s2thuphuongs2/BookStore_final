<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>


<style>
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

.book-info {
	place-self: center;
	text-align: center;
}
</style>

<div class="modal-header">
	<h1 class="modal-title fs-5">Xem chi tiết</h1>
	<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
</div>
<div class="modal-body">
	<c:forEach var="book" items="${books}">

		<div class="row my-2" id="book-${book.id}">
			<div class="row mb-2">
				<div class="col col-1">
					<img class="book-image" src="data:image/webp;base64,${book.image}">
				</div>

				<div class="col col-4">
					<a class="item" href="/book/${book.id}"><div class="book-title">${book.name}</div></a>
				</div>

				<div class="col col-34 px-2 book-info">
					<div>Số lượng: ${book.quantity}</div>

				</div>

				<div class="col col-4 px-2 book-info">
					<div>
						Tổng tiền: <span class="book-price" id="price-${book.id}">${book.getTotalPriceString()}
							VND</span>
					</div>
				</div>

			</div>
		</div>
		<hr>
	</c:forEach>

	<div class="row mt-2 mb-4">
		<div class="text-end">
			Tổng số hóa đơn: <span class="book-price fw-bold">${bill.getTotalPriceString()}
				VND</span>
		</div>
	</div>

	<div class="row">
		<div class="col px-4">
			<div class="row mb-2">
				<span><b>Địa chỉ:</b> ${bill.address}</span>
			</div>

			<div class="row mb-2">
				<span><b>Số điện thoại:</b> ${bill.phone}</span>
			</div>
		</div>
	</div>
</div>
<div class="modal-footer">
	<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>

	<c:choose>
		<c:when test="${bill.status == 0}">
			<button type="button" class="btn btn-danger" onclick="cancelBill()">Hủy
				giao hàng</button>
		</c:when>

		<c:otherwise>
		</c:otherwise>
	</c:choose>
</div>