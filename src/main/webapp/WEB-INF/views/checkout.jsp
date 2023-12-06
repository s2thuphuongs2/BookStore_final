
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
			<div class="row mb-2 fs-3" style="color: #3388ff;">Giỏ hàng</div>

			<div class="book row">
				<c:forEach var="book" items="${books}">

					<div class="row my-2" id="book-${book.id}">
						<div class="row mb-2">
							<div class="col col-1">
								<img class="book-image"
									src="data:image/webp;base64,${book.image}">
							</div>

							<div class="col col-4">
								<a class="item" href="/book/${book.id}"><div
										class="book-title">${book.name}</div></a>
							</div>

							<div class="col col-3 px-2 book-info">
								<div>
									Số lượng: <input class="form-control" type="number"
										value="${book.quantity}"
										onchange="updatePrice(${book.id}, ${book.price})"
										id="quantity-${book.id}" min="1">
								</div>

							</div>

							<div class="col col-3 px-2 book-info">
								<div>
									Tổng tiền:
									<div class="book-price" id="price-${book.id}">${book.getTotalPriceString()}
										VND</div>
								</div>
							</div>

							<div class="col col-1 px-2 book-info">
								<button class="btn btn-danger" onclick="deleteBook(${book.id})">
									<i class="fa-solid fa-trash"></i>
								</button>
							</div>
						</div>
					</div>
					<hr>

				</c:forEach>

				<div class="row mt-2 mb-4">
					<div class="fs-3 text-end">
						Tổng số hóa đơn: <span class="book-price fw-bold">${totalprice}
							VND</span>
					</div>
				</div>
			</div>
			<div class="row my-2 fs-3" style="color: #3388ff;">Thông tin
				giao hàng</div>

			<form class="book" id="checkoutForm">
				<div class="row">
					<div class="col px-2">
						<div class="row mb-2">
							<label for="address" class="form-label">Địa chỉ</label> <input
								type="text" class="form-control" id="address" name="address">
						</div>

						<div class="row mb-2">
							<label for="phone" class="form-label">Số điện thoại</label> <input
								type="text" class="form-control" id="phone" name="phone" value="${phone}">
						</div>

						<div class="row mb-2">
							<c:choose>
								<c:when test="${books.size() != 0}">
									<button class="btn btn-primary">Đặt hàng</button>
								</c:when>
								<c:otherwise>
									<button class="btn btn-primary" disabled>Đặt hàng</button>
								</c:otherwise>
							</c:choose>

						</div>

					</div>
				</div>
			</form>
		</div>
	</div>
	
	<jsp:include page="modal/register.jsp"></jsp:include>
</body>

<script>
function updatePrice(bookid, bookprice) {
	var newQuantity = $("#quantity-"+bookid).val()

	$.ajax({
        url: '/carts/${userid}/'+bookid,
        type: 'post',
        data:{
        	"quantity": newQuantity
        },
        success: (data) => {
        	if (data.includes("edit_success")) {
        		var newPrice = (newQuantity * bookprice).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")+" VND";
        		
        		$("#price-"+bookid).html(newPrice)
        		
        		$("#cartCount").html(data.split(":")[1])
        	} else {
        		alert("Chỉnh sửa thất bại")
        	}
        }
    });
}

function deleteBook(bookid) {
	$.ajax({
        url: '/carts/${userid}/'+bookid+'/delete',
        type: 'post',
        success: (data) => {
        	if (data.includes("remove_success")) {
        		$("#book-"+bookid).remove()
        		$("#cartCount").html(data.split(":")[1])
        	} else {
        		alert("Xóa thất bại")
        	}
        }
    });
}

$("#checkoutForm").submit((e) => {
	e.preventDefault();
	
    $.ajax({
        url: '/carts/${userid}/checkout',
        type: 'post',
        data:$("#checkoutForm").serialize(),
        success: (data) => {
        	if (data.includes("checkout_success")) {
        		window.location.replace("/bills")
        	} else {
        		alert("Đặt hàng thất bại")
        	}
        }
    });
})
</script>
</html>