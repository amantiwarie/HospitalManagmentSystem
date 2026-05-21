<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c"
           uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <title>Register</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

</head>

<body class="bg-light">

<div class="container">

    <div class="row justify-content-center mt-5">

        <div class="col-md-6">

            <div class="card shadow border-0">

                <div class="card-body p-4">

                    <h2 class="text-center mb-4">

                        Register

                    </h2>

                    <!-- BACKEND ERROR MESSAGE -->

                    <c:if test="${not empty error}">

                        <div class="alert alert-danger">

                            ${error}

                        </div>

                    </c:if>

                    <form action="${pageContext.request.contextPath}/register"
                          method="post"
                          onsubmit="return validateForm()">

                        <!-- NAME -->

                        <div class="mb-3">

                            <label>Name</label>

                            <input type="text"
                                   id="name"
                                   name="name"
                                   class="form-control"
                                   required>

                        </div>

                        <!-- EMAIL -->

                        <div class="mb-3">

                            <label>Email</label>

                            <input type="email"
                                   id="email"
                                   name="email"
                                   class="form-control"
                                   required
                                   onkeyup="validateEmail()">

                            <small id="emailError"
                                   class="text-danger"></small>

                        </div>

                        <!-- PASSWORD -->

                        <div class="mb-3">

                            <label>Password</label>

                            <input type="password"
                                   id="password"
                                   name="password"
                                   class="form-control"
                                   required
                                   onkeyup="validatePassword()">

                            <small id="passwordError"
                                   class="text-danger"></small>

                        </div>

                        <button class="btn btn-success w-100">

                            Register

                        </button>

                    </form>

                </div>

            </div>

        </div>

    </div>

</div>

<script>

    // EMAIL VALIDATION

    function validateEmail(){

        let email =
            document.getElementById("email").value;

        let emailError =
            document.getElementById("emailError");

        let regex =
            /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

        if(email === ""){

            emailError.innerHTML = "";
        }

        else if(!regex.test(email)){

            emailError.innerHTML =
                "Invalid email format";
        }

        else{

            emailError.innerHTML = "";
        }
    }

    // PASSWORD VALIDATION

    function validatePassword(){

        let password =
            document.getElementById("password").value;

        let passwordError =
            document.getElementById("passwordError");

        if(password.length < 4){

            passwordError.innerHTML =
                "Password must be at least 4 characters";
        }

        else{

            passwordError.innerHTML = "";
        }
    }

    // FINAL FORM VALIDATION

    function validateForm(){

        let emailError =
            document.getElementById("emailError").innerHTML;

        let passwordError =
            document.getElementById("passwordError").innerHTML;

        if(emailError !== "" || passwordError !== ""){

            return false;
        }

        return true;
    }

</script>

</body>

</html>