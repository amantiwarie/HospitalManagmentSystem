<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>

    <title>Doctor Details</title>

    <style>

        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
            font-family: Arial, sans-serif;
        }

        body{
            background:#f4f6f9;
            padding:40px;
        }

        .container{
            width:60%;
            margin:auto;
            background:white;
            padding:30px;
            border-radius:10px;
            box-shadow:0 2px 10px rgba(0,0,0,0.1);
        }

        h1{
            text-align:center;
            color:#1976d2;
            margin-bottom:30px;
        }

        .detail{
            margin-bottom:20px;
            font-size:18px;
        }

        .label{
            font-weight:bold;
            color:#333;
        }

        .btn{
            display:inline-block;
            margin-top:20px;
            background:#1976d2;
            color:white;
            padding:10px 20px;
            text-decoration:none;
            border-radius:5px;
        }

    </style>

</head>

<body>

<div class="container">

    <h1>Doctor Details</h1>

    <div class="detail">
        <span class="label">ID:</span>
        ${doctor.get().id}
    </div>

    <div class="detail">
        <span class="label">Name:</span>
        ${doctor.get().name}
    </div>

    <div class="detail">
        <span class="label">Email:</span>
        ${doctor.get().email}
    </div>

    <div class="detail">
        <span class="label">Specialization:</span>
        ${doctor.get().specialization}
    </div>

   <div style="margin-top:25px;">

       <a href="${pageContext.request.contextPath}/doctors"
          class="btn">

           Back to Doctors

       </a>

       <a href="${pageContext.request.contextPath}/"
          class="btn"
          style="margin-left:15px; background:green;">

           Home Page

       </a>

   </div>

</div>

</body>
</html>