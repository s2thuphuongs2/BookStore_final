<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
                <li class="nav-item"><a class="nav-link active" href="/admin/books"><i class="fas fa-book"></i><span>Books</span></a>
                </li>
                <li class="nav-item"><a class="nav-link" href="/admin/authors"><i
                        class="fas fa-user"></i><span>Author</span></a></li>
                <li class="nav-item"><a class="nav-link" href="/admin/publishers"><i class="fas fa-building"></i><span>Publisher</span></a>
                </li>
                <li class="nav-item"><a class="nav-link" href="/admin/categories"><i class="fas fa-list"></i><span>Category</span></a>
                </li>
                <li class="nav-item"><a class="nav-link" href="/admin/bills"><i class="fas fa-money-bill"></i><span>Bills</span></a>
                </li>
                <li class="nav-item"><a class="nav-link" href="/admin/users"><i
                        class="fas fa-users"></i><span>Users</span></a></li>
                <li class="nav-item"><a class="nav-link" href="/logout"><i
                        class="fas fa-sign-out-alt"></i><span>Logout</span></a></li>
            </ul>
            <div class="text-center d-none d-md-inline">
                <button class="btn rounded-circle border-0" id="sidebarToggle" type="button"></button>
            </div>
        </div>
    </nav>
    <div class="d-flex flex-column" id="content-wrapper">
        <div id="content">
            <div class="d-sm-flex justify-content-between align-items-center mb-4">
                <h3 class="text-dark mb-0">Quản Lý Sách</h3>
                <a class="btn btn-primary btn-sm d-none d-sm-inline-block" role="button" data-bs-toggle="modal" data-bs-target="#addModal">
                    <i class="fas fa-add fa-sm text-white-50"></i>&nbsp;Thêm Sách
                </a>
            </div>
            <div class="overflow-auto">
                <table class="table-responsive table mt-2">
                    <thead>
                    <tr class="table-secondary">
                        <th scope="col">Id</th>
                        <th scope="col">Tên</th>
                        <th scope="col">Tác giả</th>
                        <th scope="col">Nhà xuất bản</th>
                        <th scope="col">Thao tác</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${books}" var="book">
                        <tr>
                            <td>${book.id}</td>
                            <td>${book.name}</td>
                            <td>${authors.stream().filter(author -> book.authorid == author.id).findFirst().orElse(null).name}</td>
                            <td>${publishers.stream().filter(publisher -> book.publisherid == publisher.id).findFirst().orElse(null).name}</td>
                            <td>
                                <button class="btn btn-primary" data-bs-toggle="modal"
                                        data-bs-target="#editModal" onclick="editBookById(${book.id})">
                                    <i class="fa-solid fa-pen-to-square"></i>
                                </button>
                                <button class="btn btn-danger" data-bs-toggle="modal"
                                        data-bs-target="#deleteModal" onclick="deleteBookById(${book.id})">
                                    <i class="fa-solid fa-trash"></i>
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>


            <div class="modal fade modal-lg" id="addModal" tabindex="-1">
                <form method="post" action="/admin/books"
                      enctype="multipart/form-data">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h1 class="modal-title fs-5">Thêm nhà xuất bản</h1>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body">
                                <div class="row mb-3">
                                    <div class="col col-8">
                                        <label for="bookName" class="form-label">Tên sách</label> <input
                                            type="text" class="form-control" id="bookName" name="bookName">
                                    </div>

                                    <div class="col col-4">
                                        <label for="bookPrice" class="form-label">Giá sách</label> <input
                                            type="number" class="form-control" id="bookPrice"
                                            name="bookPrice">
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <div class="col col-8">
                                        <label for="bookSize" class="form-label">Kích thước</label> <input
                                            type="text" class="form-control" id="bookSize" name="bookSize">
                                    </div>

                                    <div class="col col-4">
                                        <label for="bookPage" class="form-label">Số trang</label> <input
                                            type="number" class="form-control" id="bookPage"
                                            name="bookPage">
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <div class="col col-12">
                                        <label for="bookCate" class="form-label">Thể loại</label> <select
                                            class="selectpicker form-control" multiple id="bookCate"
                                            name="bookCate" data-live-search="true"
                                            title="Chọn thể loại sách">
                                        <c:forEach items="${categories}" var="category">
                                            <option value="${category.id}">${category.name}</option>
                                        </c:forEach>
                                    </select>
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <div class="col col-6">
                                        <label for="bookAuthor" class="form-label">Tác giả</label> <select
                                            class="selectpicker form-control" id="bookAuthor"
                                            name="bookAuthor" data-live-search="true">
                                        <c:forEach items="${authors}" var="author">
                                            <option value="${author.id}">${author.name}</option>
                                        </c:forEach>
                                    </select>
                                    </div>

                                    <div class="col col-6">
                                        <label for="bookPubl" class="form-label">Nhà xuất bản</label> <select
                                            class="selectpicker form-control" id="bookPubl" name="bookPubl"
                                            data-live-search="true">
                                        <c:forEach items="${publishers}" var="publisher">
                                            <option value="${publisher.id}">${publisher.name}</option>
                                        </c:forEach>
                                    </select>
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <div class="col col-12">
                                        <label for="bookDesc" class="form-label">Mô tả sách</label>
                                        <textarea type="text" class="form-control" id="bookDesc"
                                                  name="bookDesc"></textarea>
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <div class="col col-12">
                                        <label for="bookImage" class="form-label">Thêm ảnh</label> <input
                                            class="form-control" type="file" id="bookImage"
                                            name="bookImage">
                                    </div>
                                </div>


                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary"
                                        data-bs-dismiss="modal">Hủy
                                </button>
                                <button type="submit" class="btn btn-primary">Thêm</button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>

            <div class="modal fade modal-lg" id="editModal" tabindex="-1">
                <form id="editForm" method="post" enctype="multipart/form-data">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h1 class="modal-title fs-5">Chỉnh sửa sách</h1>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body">
                                <div class="row mb-3">
                                    <div class="col col-8">
                                        <label for="bookName" class="form-label">Tên sách</label> <input
                                            type="text" class="form-control" id="bookNameEdit"
                                            name="bookName">
                                    </div>

                                    <div class="col col-4">
                                        <label for="bookPrice" class="form-label">Giá sách</label> <input
                                            type="number" class="form-control" id="bookPriceEdit"
                                            name="bookPrice">
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <div class="col col-8">
                                        <label for="bookSize" class="form-label">Kích thước</label> <input
                                            type="text" class="form-control" id="bookSizeEdit"
                                            name="bookSize">
                                    </div>

                                    <div class="col col-4">
                                        <label for="bookPage" class="form-label">Số trang</label> <input
                                            type="number" class="form-control" id="bookPageEdit"
                                            name="bookPage">
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <div class="col col-12">
                                        <label for="bookCate" class="form-label">Thể loại</label> <select
                                            class="selectpicker form-control" multiple id="bookCateEdit"
                                            name="bookCate" data-live-search="true"
                                            title="Chọn thể loại sách">
                                        <c:forEach items="${categories}" var="category">
                                            <option value="${category.id}">${category.name}</option>
                                        </c:forEach>
                                    </select>
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <div class="col col-6">
                                        <label for="bookAuthor" class="form-label">Tác giả</label> <select
                                            class="selectpicker form-control" id="bookAuthorEdit"
                                            name="bookAuthor" data-live-search="true">
                                        <c:forEach items="${authors}" var="author">
                                            <option value="${author.id}">${author.name}</option>
                                        </c:forEach>
                                    </select>
                                    </div>

                                    <div class="col col-6">
                                        <label for="bookPubl" class="form-label">Nhà xuất bản</label> <select
                                            class="selectpicker form-control" id="bookPublEdit"
                                            name="bookPubl" data-live-search="true">
                                        <c:forEach items="${publishers}" var="publisher">
                                            <option value="${publisher.id}">${publisher.name}</option>
                                        </c:forEach>
                                    </select>
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <div class="col col-12">
                                        <label for="bookDesc" class="form-label">Mô tả sách</label>
                                        <textarea type="text" class="form-control" id="bookDescEdit"
                                                  name="bookDesc"></textarea>
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <div class="col col-12">
                                        <label for="bookImage" class="form-label">Thêm ảnh</label> <input
                                            class="form-control" type="file" id="bookImage"
                                            name="bookImage">
                                    </div>
                                </div>


                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary"
                                        data-bs-dismiss="modal">Hủy
                                </button>
                                <button type="submit" class="btn btn-primary">Sửa</button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>

            <div class="modal fade modal-lg" id="deleteModal" tabindex="-1">
                <form id="deleteForm" method="post" enctype="multipart/form-data">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h1 class="modal-title fs-5">Xóa nhà sách</h1>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body">
                                <div class="row mb-3">
                                    <div class="col col-8">
                                        <label for="bookName" class="form-label">Tên sách</label> <input
                                            type="text" class="form-control" id="bookNameDelete"
                                            name="bookName" disabled>
                                    </div>

                                    <div class="col col-4">
                                        <label for="bookPrice" class="form-label">Giá sách</label> <input
                                            type="number" class="form-control" id="bookPriceDelete"
                                            name="bookPrice" disabled>
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <div class="col col-8">
                                        <label for="bookSize" class="form-label">Kích thước</label> <input
                                            type="text" class="form-control" id="bookSizeDelete"
                                            name="bookSize" disabled>
                                    </div>

                                    <div class="col col-4">
                                        <label for="bookPage" class="form-label">Số trang</label> <input
                                            type="number" class="form-control" id="bookPageDelete"
                                            name="bookPage" disabled>
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <div class="col col-12">
                                        <label for="bookCate" class="form-label">Thể loại</label> <select
                                            class="selectpicker form-control" multiple id="bookCateDelete"
                                            name="bookCate" data-live-search="true"
                                            title="Chọn thể loại sách" disabled>
                                        <c:forEach items="${categories}" var="category">
                                            <option value="${category.id}">${category.name}</option>
                                        </c:forEach>
                                    </select>
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <div class="col col-6">
                                        <label for="bookAuthor" class="form-label">Tác giả</label> <select
                                            class="selectpicker form-control" id="bookAuthorDelete"
                                            name="bookAuthor" data-live-search="true" disabled>
                                        <c:forEach items="${authors}" var="author">
                                            <option value="${author.id}">${author.name}</option>
                                        </c:forEach>
                                    </select>
                                    </div>

                                    <div class="col col-6">
                                        <label for="bookPubl" class="form-label">Nhà xuất bản</label> <select
                                            class="selectpicker form-control" id="bookPublDelete"
                                            name="bookPubl" data-live-search="true" disabled>
                                        <c:forEach items="${publishers}" var="publisher">
                                            <option value="${publisher.id}">${publisher.name}</option>
                                        </c:forEach>
                                    </select>
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <div class="col col-12">
                                        <label for="bookDesc" class="form-label">Mô tả sách</label>
                                        <textarea type="text" class="form-control" id="bookDescDelete"
                                                  disabled name="bookDesc"></textarea>
                                    </div>
                                </div>

                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary"
                                        data-bs-dismiss="modal">Hủy
                                </button>
                                <button type="submit" class="btn btn-danger">Xóa</button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>

        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <jsp:include page="../../../assets/js/script.min.jsp"></jsp:include>
</body>
</html>