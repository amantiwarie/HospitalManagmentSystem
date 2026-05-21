<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>

    <title>Patient Profile</title>

    <style>

        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
            font-family: Arial, sans-serif;
        }

        body{
            background:linear-gradient(to right,#e3f2fd,#f5f5f5);
            min-height:100vh;
            display:flex;
            justify-content:center;
            align-items:center;
        }

        .profile-card{
            width:500px;
            background:white;
            border-radius:15px;
            overflow:hidden;
            box-shadow:0 4px 20px rgba(0,0,0,0.15);
        }

        .header{
            background:#1976d2;
            color:white;
            padding:30px;
            text-align:center;
        }

        .header h1{
            font-size:32px;
            margin-bottom:10px;
        }

        .header p{
            font-size:16px;
            opacity:0.9;
        }

        .content{
            padding:30px;
        }

        .info-box{
            background:#f8f9fa;
            padding:15px 20px;
            border-radius:10px;
            margin-bottom:20px;
            border-left:5px solid #1976d2;
        }

        .label{
            font-size:14px;
            color:#777;
            margin-bottom:5px;
        }

        .value{
            font-size:20px;
            color:#222;
            font-weight:bold;
        }

        .btn-container{
            text-align:center;
            margin-top:30px;
        }

        .btn{
            text-decoration:none;
            background:#1976d2;
            color:white;
            padding:12px 25px;
            border-radius:8px;
            transition:0.3s;
        }

        .btn:hover{
            background:#125ea7;
        }
        .home-btn{
            background:#28a745;
            margin-left:15px;
        }

        .home-btn:hover{
            background:#1f7d34;
        }

    </style>

</head>

<body>

<div class="profile-card">

    <div class="header">

        <h1>Patient Profile</h1>

        <p>
            Detailed Information of Patient
        </p>

    </div>

    <div class="content">

        <div class="info-box">

            <div class="label">
                Patient ID
            </div>

            <div class="value">
                ${patient.id}
            </div>

        </div>

        <div class="info-box">

            <div class="label">
                Full Name
            </div>

            <div class="value">
                ${patient.name}
            </div>

        </div>

        <div class="info-box">

            <div class="label">
                Email Address
            </div>

            <div class="value">
                ${patient.email}
            </div>

        </div>

        <div class="info-box">

            <div class="label">
                Blood Type
            </div>

            <div class="value">
                ${patient.bloodType}
            </div>

     <div class="btn-container">

         <a href="${pageContext.request.contextPath}/patients"
            class="btn">

             Back to Patients

         </a>

         <a href="${pageContext.request.contextPath}/"
            class="btn home-btn">

             Home Page

         </a>

     </div>

    </div>

</div>

</body>
</html>