<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>

    <title>Manage Doctors</title>

    <style>

        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
            font-family: Arial, sans-serif;
        }

        body{
            background:#f4f6f9;
            padding:30px;
        }

        h1{
            text-align:center;
            color:#1976d2;
            margin-bottom:30px;
        }

        .container{
            width:90%;
            margin:auto;
        }

        .form-container{
            background:white;
            padding:25px;
            border-radius:10px;
            margin-bottom:30px;
            box-shadow:0 2px 10px rgba(0,0,0,0.1);
        }

        .form-group{
            margin-bottom:15px;
        }

        label{
            display:block;
            margin-bottom:5px;
            font-weight:bold;
        }

        input{
            width:100%;
            padding:10px;
            border:1px solid #ccc;
            border-radius:5px;
        }

        .btn{
            background:#1976d2;
            color:white;
            border:none;
            padding:10px 20px;
            border-radius:5px;
            cursor:pointer;
        }

        .view-btn{
            background:green;
            color:white;
            padding:8px 12px;
            text-decoration:none;
            border-radius:5px;
        }

        .delete-btn{
            background:red;
            color:white;
            padding:8px 12px;
            text-decoration:none;
            border-radius:5px;
        }

        table{
            width:100%;
            border-collapse:collapse;
            background:white;
            box-shadow:0 2px 10px rgba(0,0,0,0.1);
        }

        table th{
            background:#1976d2;
            color:white;
            padding:15px;
        }

        table td{
            padding:12px;
            border-bottom:1px solid #ddd;
            text-align:center;
        }

    </style>

</head>

<body>

<div class="container">

    <h1>Manage Doctors</h1>

    <!-- ADD DOCTOR FORM -->

    <div class="form-container">

        <form action="${pageContext.request.contextPath}/doctors/save"
              method="post">

            <div class="form-group">

                <label>Name</label>

                <input type="text"
                       name="name"
                       required>

            </div>

            <div class="form-group">

                <label>Email</label>

                <input type="email"
                       name="email"
                       required>

            </div>

            <div class="form-group">

                <label>Specialization</label>

                <input type="text"
                       name="specialization"
                       required>

            </div>

            <button type="submit" class="btn">
                Add Doctor
            </button>

        </form>

    </div>

    <!-- DOCTOR TABLE -->

    <table>

        <tr>

            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Specialization</th>
            <th>Actions</th>

        </tr>

        <c:forEach var="doctor" items="${doctors}">

            <tr>

                <td>${doctor.id}</td>

                <td>${doctor.name}</td>

                <td>${doctor.email}</td>

                <td>${doctor.specialization}</td>

                <td>

                    <a href="${pageContext.request.contextPath}/doctors/${doctor.id}"
                       class="view-btn">

                        View

                    </a>

                    |

                    <a href="${pageContext.request.contextPath}/doctors/delete/${doctor.id}"
                       class="delete-btn">

                        Delete

                    </a>

                </td>

            </tr>

        </c:forEach>

    </table>
    <div style="margin-top:25px; text-align:center;">

        <a href="${pageContext.request.contextPath}/"
           class="btn"
           style="text-decoration:none;">

            Home Page

        </a>

    </div>

</div>

</body>
</html>