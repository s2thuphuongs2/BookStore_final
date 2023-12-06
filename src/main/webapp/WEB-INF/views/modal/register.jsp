<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>

<div class="modal fade" id="registerModal" tabindex="-1">
	<form method="post" action="/register" id="registerForm">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5">Đăng ký</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<div class="modal-body">
					<div class="row mb-3">
						<label for="usernameRegister" class="form-label">Tên người
							dùng:</label> <input type="text" class="form-control"
												 id="usernameRegister" name="username">
					</div>

					<div class="row mb-3">
						<label for="passwordRegister" class="form-label">Mật khẩu:</label>
						<input type="password" class="form-control" id="passwordRegister"
							   name="password">
					</div>

					<div class="row mb-3">
						<label for="phoneRegister" class="form-label">Số điện
							thoại:</label> <input type="text" class="form-control" id="phoneRegister"
												  name="phone">
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Hủy</button>
					<button type="submit" class="btn btn-success">Đăng ký</button>
				</div>
			</div>
		</div>
	</form>
</div>
<script>
	$('#registerForm').submit(function(e){
		e.preventDefault();
		$.ajax({
			url: '/register',
			type: 'post',
			data:$('#registerForm').serialize(),
			success: (data) => {
				if (data == "REGISTER_SUCCESS"){
					window.location.replace("/login")
				} else if (data == "EXISTED_USERNAME"){
					alert("Username đã tồn tại!")
				} else if (data == "EXISTED_PHONE_NUMBER"){
					alert("Số điện thoại đã tồn tại!")
				} else {
					alert("Đăng ký thất bại!")
				}
			}
		});
	});
</script>