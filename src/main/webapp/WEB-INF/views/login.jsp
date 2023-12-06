<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html data-bs-theme="light" lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Login</title>

<%--    <link rel="stylesheet" href="/assets/bootstrap/css/bootstrap.min.css">--%>
<%--    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">--%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.12.0/css/all.css">
<%--    <link rel="stylesheet" href="/WEB-INF/css/styles.min.css">--%>

</head>

<body class="bg-gradient-primary">
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-9 col-lg-12 col-xl-10">
            <div class="card shadow-lg o-hidden border-0 my-5">
                <div class="card-body p-0">
                    <div class="row">
                        <div class="col-lg-6 d-none d-lg-flex">
                            <div class="flex-grow-1 bg-login-image" style="background-image: url('https://i.pinimg.com/564x/0c/9b/89/0c9b89b62ba04b4b4740f4ce2da28b54.jpg');"></div>
                        </div>
                        <div class="col-lg-6">
                            <div class="p-5">
                                <div class="text-center">
                                    <h4 class="text-dark mb-4">Welcome Back!</h4>
                                </div>

                                <form class="user" action="/login" method="post" id = "loginForm">
                                    <div class="mb-3">
                                        <input class="form-control form-control-user" type="text" id="inputUsername"
                                               aria-describedby="userHelp" placeholder="Enter User Name..." name="username" required/>
                                    </div>
                                    <div class="mb-3">
                                        <input class="form-control form-control-user" type="password" id="inputPassword"
                                               placeholder="Password" name="password" required/>
                                    </div>

                                    <div class="mb-3">
                                        <div class="custom-control custom-checkbox small">
                                            <div class="form-check">
                                                <input class="form-check-input custom-control-input" type="checkbox"
                                                       id="formCheck-1">
                                                <label class="form-check-label custom-control-label" for="formCheck-1">
                                                    Remember Me
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                    <button class="btn btn-primary d-block btn-user w-100" type="submit">Login</button>
                                    <hr>
                                  <a class="btn btn-primary d-block btn-google btn-user w-100 mb-2" role="button"><i
                                          class="fab fa-google"></i>&nbsp; Login with Google</a>
                                    <a
                                        class="btn btn-primary d-block btn-facebook btn-user w-100"  role="button"><i
                                        class="fab fa-facebook-f"></i>&nbsp; Login with Facebook</a>
                                    <hr>
                                </form>

                                <div class="text-center">You don't have an account?</div>
                                <div class="text-center"><a class="small" type="submit" onclick="registerModal()">Create An Account!</a></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="../../assets/js/script.min.jsp"></script>
<script>
    function registerModal() {
        const registerModal = new bootstrap.Modal(document
            .getElementById('registerModal'))
        registerModal.show()
    }
</script>
<jsp:include page="modal/register.jsp"></jsp:include>

</body>

</html>

