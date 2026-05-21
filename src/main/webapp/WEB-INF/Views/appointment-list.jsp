<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c"
           uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>

<head>

    <title>Appointments</title>

    <style>

        body{
            font-family: Arial;
            margin:40px;
            background:#f5f5f5;
        }

        table{
            width:100%;
            border-collapse:collapse;
            background:white;
        }

        th,td{
            border:1px solid #ddd;
            padding:12px;
            text-align:center;
        }

        th{
            background:#1976d2;
            color:white;
        }

        form{
            margin-bottom:30px;
            background:white;
            padding:20px;
        }

        input{
            padding:10px;
            margin:10px;
        }

        button{
            padding:10px 20px;
            background:#1976d2;
            color:white;
            border:none;
            cursor:pointer;
        }

        a{
            text-decoration:none;
            color:red;
        }

    </style>

</head>

<body>

<h1>Appointment Management</h1>

<form action="${pageContext.request.contextPath}/appointments/save"
      method="post">

    <input type="date"
           name="appointmentDate"
           required>

    <input type="time"
           name="appointmentTime"
           required>

    <button type="submit">
        Add Appointment
    </button>

</form>

<table>

    <tr>

        <th>ID</th>

        <th>Date</th>

        <th>Time</th>

        <th>Delete</th>

    </tr>

    <c:forEach items="${appointments}"
               var="appointment">

        <tr>

            <td>${appointment.id}</td>

            <td>${appointment.appointmentDate}</td>

            <td>${appointment.appointmentTime}</td>

            <td>

                <a href="${pageContext.request.contextPath}/appointments/delete/${appointment.id}">

                    Delete

                </a>

            </td>

        </tr>

    </c:forEach>

</table>

</body>

</html>