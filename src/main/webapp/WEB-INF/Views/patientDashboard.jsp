<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c"
           uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1">

    <title>Patient Dashboard</title>

    <!-- Bootstrap -->

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

</head>

<body class="bg-light">

<!-- NAVBAR -->

<nav class="navbar navbar-expand-lg navbar-dark bg-primary">

    <div class="container">

        <a class="navbar-brand fw-bold"
           href="#">

            HMS Patient Portal

        </a>

        <div class="d-flex align-items-center">

            <span class="text-white me-3">

                Welcome,
                ${sessionScope.loggedInUser.name}

            </span>

            <a href="${pageContext.request.contextPath}/logout"
               class="btn btn-light btn-sm">

                Logout

            </a>

        </div>

    </div>

</nav>

<!-- MAIN CONTENT -->

<div class="container mt-5">

    <!-- WELCOME CARD -->

    <div class="card shadow-sm border-0 mb-4">

        <div class="card-body">

            <h2 class="fw-bold text-primary">

                Patient Dashboard

            </h2>

            <p class="text-muted">

                Manage your appointments and hospital activities easily.

            </p>

        </div>

    </div>

    <!-- QUICK ACTIONS -->

    <div class="row g-4">

        <!-- BOOK APPOINTMENT -->

        <div class="col-md-4">

            <div class="card shadow-sm border-0 h-100">

                <div class="card-body text-center">

                    <h4 class="text-primary mb-3">

                        Book Appointment

                    </h4>

                    <p class="text-muted">

                        Schedule appointment with doctors.

                    </p>

                    <a href="${pageContext.request.contextPath}/appointments/book"
                       class="btn btn-primary">

                        Book Now

                    </a>

                </div>

            </div>

        </div>

        <!-- VIEW APPOINTMENTS -->

        <div class="col-md-4">

            <div class="card shadow-sm border-0 h-100">

                <div class="card-body text-center">

                    <h4 class="text-success mb-3">

                        My Appointments

                    </h4>

                    <p class="text-muted">

                        View all your scheduled appointments.

                    </p>

                    <a href="${pageContext.request.contextPath}/appointments/my"
                       class="btn btn-success">

                        View

                    </a>

                </div>

            </div>

        </div>

        <!-- PROFILE -->

        <div class="col-md-4">

            <div class="card shadow-sm border-0 h-100">

                <div class="card-body text-center">

                    <h4 class="text-warning mb-3">

                        My Profile

                    </h4>

                    <p class="text-muted">

                        Update and manage your profile.

                    </p>

                    <a href="${pageContext.request.contextPath}/patients/${patient.id}"
                       class="btn btn-warning text-white">

                        Profile

                    </a>

                </div>

            </div>

        </div>

    </div>

    <!-- RECENT APPOINTMENTS -->

    <div class="card shadow-sm border-0 mt-5">

        <div class="card-body">

            <h4 class="fw-bold mb-4">

                Recent Appointments

            </h4>

            <div class="table-responsive">

                <table class="table table-bordered table-hover align-middle">

                    <thead class="table-primary">

                    <tr>

                        <th>ID</th>

                        <th>Doctor</th>

                        <th>Date</th>

                        <th>Time</th>

                        <th>Reason</th>

                        <th>Status</th>

                    </tr>

                    </thead>

                    <tbody>

                    <!-- NO APPOINTMENTS -->

                    <c:if test="${empty appointments}">

                        <tr>

                            <td colspan="6"
                                class="text-center text-muted">

                                No appointments found.

                            </td>

                        </tr>

                    </c:if>

                    <!-- APPOINTMENT LOOP -->

                    <c:forEach items="${appointments}"
                               var="appointment">

                        <tr>

                            <!-- ID -->

                            <td>

                                ${appointment.id}

                            </td>

                            <!-- DOCTOR -->

                            <td>

                                <c:choose>

                                    <c:when test="${appointment.doctor != null}">

                                        ${appointment.doctor.name}

                                    </c:when>

                                    <c:otherwise>

                                        Not Assigned

                                    </c:otherwise>

                                </c:choose>

                            </td>

                            <!-- DATE -->

                            <td>

                                ${appointment.appointmentDate}

                            </td>

                            <!-- TIME -->

                            <td>

                                ${appointment.appointmentTime}

                            </td>

                            <!-- REASON -->

                            <td>

                                ${appointment.reason}

                            </td>

                            <!-- STATUS -->

                            <td>

                                <span class="badge bg-success">

                                    Scheduled

                                </span>

                            </td>

                        </tr>

                    </c:forEach>

                    </tbody>

                </table>

            </div>

        </div>

    </div>

</div>

<!-- Bootstrap JS -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>