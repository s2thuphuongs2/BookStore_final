<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<jsp:include page="head.jsp"></jsp:include>
<title>${book.name}</title>

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
	padding: 0.5rem;
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
	border-right: 1px rgba(0, 0, 0, .15) solid;
}

.book-title {
	color: #3388ff
}

.book-quantity {
	height: 100%;
	border-radius: 0.25rem;
}

.book-category {
	font-size: 1.125;
	line-height: 2rem;
	padding: 0 0.5rem;
	text-decoration: none;
}
</style>
</head>

<body>
	<jsp:include page="header.jsp"></jsp:include>

	<div class="body">
		<div class="row mb-4 py-4 book">
			<div class="col col-4">
				<div class="image-container">
					<img class="book-image" src="data:image/webp;base64,${book.image}">
				</div>
			</div>
			<div class="col col-8 d-flex flex-column">
				<div class="row">
					<div class="fs-6">
						Tác giả: <a href="/author/${author.id}"
							style="text-decoration: none">${author.name }</a>
					</div>
				</div>

				<div class="row">
					<div class="book-title fs-4">${book.name }</div>
				</div>

				<div class="row mt-2">
					<div class="fs-1">
						Giá: <b class="text-danger">${book.getPriceString() } VND</b>
					</div>
				</div>

				<div class="row mt-4">
					<div class="fs-5">
						<b>Nhà xuất bản:</b> <a href="/publisher/${publisher.id}"
							style="text-decoration: none">${publisher.name }</a>
					</div>
					<div class="fs-5">
						<b>Kích thước:</b> ${book.size }
					</div>
					<div class="fs-5">
						<b>Số trang:</b> ${book.page }
					</div>
				</div>
				<div class="row mt-4">
					<div class="fs-5">
						<b>Thể loại:</b>
						<c:forEach items="${bookCategories}" var="bookCategory">
							<a class="book-category" href="/category/${bookCategory.id}">${bookCategory.name}</a>
						</c:forEach>
					</div>
				</div>

				<div class="row mt-4 flex-grow-1 align-content-end">
					<div class="col-12 d-flex flex-column">
						<div class="fs-5 fw-bold">Số lượng:</div>

						<form class="row" id="addCartForm" method="post">

							<div class="col-3 p-0">
								<input type="number" class="book-quantity" min="1" value="1"
									name="quantity" id="quantity">
							</div>
							<div class="col-6">
								<button type="submit" class="btn btn-primary">Thêm vào
									giỏ hàng</button>
							</div>

						</form>
					</div>
				</div>
			</div>
		</div>

		<div class="row mb-4 p-4 book">
			<div class="row mb-2 fs-3 ps-4" style="color: #3388ff;">Thông
				tin mô tả</div>
			<div class="row mt-2">${book.description }</div>
		</div>
	</div>

	<jsp:include page="modal/register.jsp"></jsp:include>	
</body>

<script>
$('#addCartForm').submit(function(e){
    e.preventDefault();
    
    if ($("#logged").length == 0) {
		window.location.replace("/login")
	}
	
    $.ajax({
        url: '/carts/${userid}',
        type: 'post',
        data:{
        	"bookid":${book.id},
        	"quantity": $("#quantity").val()
        },
        success: (data) => {
        	if (data.includes("add_success")) {
        		var quantity = data.split(":")[1]
        		$("#cartCount").html(quantity)
        	} else {
        		alert("Thêm vào giỏ hàng thất bại")
        	}
        }
    });
});

</script>
</html>