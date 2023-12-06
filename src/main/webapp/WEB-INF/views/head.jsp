<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<script src="https://code.jquery.com/jquery-3.6.1.min.js"
	integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ="
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
	integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.min.js"
	integrity="sha384-IDwe1+LCz02ROU9k972gdyvl+AESN10+x7tBKgc9I5HFtuNz0wWnPclzo6p9vxnk"
	crossorigin="anonymous"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css"
	integrity="sha512-MV7K8+y+gLIBoVD59lQIYicR65iaqukzvf/nwasF0nqhPay5w/9lJmVM2hMDcnK1OnMGCdVK+iQrJ7lzPJQd1w=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-select@1.14.0-beta3/dist/css/bootstrap-select.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.14.0-beta3/dist/js/bootstrap-select.min.js"></script>
<link rel="icon" type="image/x-icon" href="/images/favicon.ico">
<link href="https://use.fontawesome.com/releases/v5.12.0/css/all.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<script>
	///////////////////////////////////////////////// AUTHOR ///////////////////////////////////////////////////////////
	function editAuthor(id, name) {
		$("#authorNameEdit").val(name)
		$("#editForm").attr("action","/admin/authors/"+id+"/edit")
	}

	function deleteAuthor(id, name) {
		$("#authorNameDelete").val(name)
		$("#deleteForm").attr("action","/admin/authors/"+id+"/delete")
	}
	///////////////////////////////////////////////// BILL /////////////////////////////////////////////////////////////
	var curBillid = 0;

	async function viewBill(billid) {
		curBillid = billid;
		const response = await fetch('/admin/bills/'+billid);
		const billdetail = await response.text();
		$("#modalBody").html(billdetail);
	}

	function doneBill() {
		$.ajax({
			url: '/admin/bills/'+curBillid+'/done',
			type: 'post',
			success: (data) => {
				if (data.includes("done_success")) {
					window.location.replace("/admin/bills")
				} else {
					alert("Hoàn thành đơn thất bại")
				}
			}
		});
	}
	function cancelBill() {
		$.ajax({
			url: '/admin/bills/'+curBillid+'/cancel',
			type: 'post',
			success: (data) => {
				if (data.includes("done_success")) {
					window.location.replace("/admin/bills")
				} else {
					alert("Hủy đơn thất bại")
				}
			}
		});
	}
	///////////////////////////////////////////////// BOOK /////////////////////////////////////////////////////////////
	async function editBookById(bookid) {
		const response = await fetch('/admin/books/'+bookid);
		const book = await response.json();

		$("#bookNameEdit").val(book.name)
		$("#bookPriceEdit").val(book.price)
		$("#bookSizeEdit").val(book.size)
		$("#bookPageEdit").val(book.page)

		$("#bookDescEdit").val(book.description)

		$("#bookCateEdit").val(book.category.split(","))
		$("#bookCateEdit").selectpicker("destroy")
		$("#bookCateEdit").selectpicker()

		$("#bookPublEdit").val(book.publisherid)
		$("#bookPublEdit").selectpicker("destroy")
		$("#bookPublEdit").selectpicker()

		$("#bookAuthorEdit").val(book.authorid)
		$("#bookAuthorEdit").selectpicker("destroy")
		$("#bookAuthorEdit").selectpicker()


		$("#editForm").attr("action","/admin/books/"+book.id+"/edit")
	}

	async function deleteBookById(bookid) {
		const response = await fetch('/admin/books/'+bookid);
		const book = await response.json();

		$("#bookNameDelete").val(book.name)
		$("#bookPriceDelete").val(book.price)
		$("#bookSizeDelete").val(book.size)
		$("#bookPageDelete").val(book.page)

		$("#bookDescDelete").val(book.description)

		$("#bookCateDelete").val(book.category.split(","))
		$("#bookCateDelete").selectpicker("destroy")
		$("#bookCateDelete").selectpicker()

		$("#bookPublDelete").val(book.publisherid)
		$("#bookPublDelete").selectpicker("destroy")
		$("#bookPublDelete").selectpicker()

		$("#bookAuthorDelete").val(book.authorid)
		$("#bookAuthorDelete").selectpicker("destroy")
		$("#bookAuthorDelete").selectpicker()

		$("#deleteForm").attr("action","/admin/books/"+book.id+"/delete")
	}
	///////////////////////////////////////////////// CATEGORY /////////////////////////////////////////////////////////
	function editCategory(id, name) {
		$("#categoryNameEdit").val(name)
		$("#editForm").attr("action","/admin/categories/"+id+"/edit")
	}

	function deleteCategory(id, name) {
		$("#categoryNameDelete").val(name)
		$("#deleteForm").attr("action","/admin/categories/"+id+"/delete")
	}
	///////////////////////////////////////////////// PUBLISHER ////////////////////////////////////////////////////////
	function editPublisher(id, name) {
		$("#publisherNameEdit").val(name)
		$("#editForm").attr("action","/admin/publishers/"+id+"/edit")
	}

	function deletePublisher(id, name) {
		$("#publisherNameDelete").val(name)
		$("#deleteForm").attr("action","/admin/publishers/"+id+"/delete")
	}
	///////////////////////////////////////////////// USER /////////////////////////////////////////////////////////////
	function editUser(id) {
		$("#editForm").attr("action","/admin/users/"+id+"/edit")
	}
</script>
