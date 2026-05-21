<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c"
           uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <title>Login</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

</head>

<body class="bg-light">

<div class="container">

    <div class="row justify-content-center mt-5">

        <div class="col-md-5">

            <div class="card shadow border-0">

                <div class="card-body p-4">

                    <h2 class="text-center mb-4">
                        Login
                    </h2>
                    <c:if test="${not empty error}">

                        <div class="alert alert-danger">

                            ${error}

                        </div>

                    </c:if>

                    <form action="${pageContext.request.contextPath}/login"
                          method="post">

                        <div class="mb-3">

                            <label>Email</label>

                            <input type="email"
                                   name="email"
                                   class="form-control"
                                   required>

                        </div>

                        <div class="mb-3">

                            <label>Password</label>

                            <input type="password"
                                   name="password"
                                   class="form-control"
                                   required>

                        </div>

                        <button class="btn btn-primary w-100">

                            Login

                        </button>

                    </form>

                    <div class="text-center mt-3">

                        Don't have an account?

                        <a href="${pageContext.request.contextPath}/register">

                            Register

                        </a>

                    </div>

                </div>

            </div>

        </div>

    </div>

</div>

</body>
</html>