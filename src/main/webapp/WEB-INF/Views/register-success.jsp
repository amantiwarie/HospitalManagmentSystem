<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Registration Successful</title>

    <style>

        body{
            margin:0;
            padding:0;
            height:100vh;
            display:flex;
            justify-content:center;
            align-items:center;
            background:linear-gradient(to right,#4facfe,#00f2fe);
            font-family:Arial,sans-serif;
        }

        .success-box{
            background:white;
            padding:40px;
            border-radius:15px;
            text-align:center;
            box-shadow:0 8px 20px rgba(0,0,0,0.2);
            width:350px;
        }

        .success-box h2{
            color:#28a745;
            margin-bottom:15px;
        }

        .success-box p{
            color:#555;
            margin-bottom:25px;
            font-size:16px;
        }

        .login-btn{
            text-decoration:none;
            background:#007bff;
            color:white;
            padding:12px 25px;
            border-radius:8px;
            font-size:16px;
            transition:0.3s;
            display:inline-block;
        }

        .login-btn:hover{
            background:#0056b3;
            transform:scale(1.05);
        }

    </style>

</head>
<body>

<div class="success-box">

    <h2>🎉 Registration Successful!</h2>

    <p>Your account has been created successfully.</p>

    <a class="login-btn"
       href="${pageContext.request.contextPath}/login">

        Go to Login

    </a>

</div>

</body>
</html>