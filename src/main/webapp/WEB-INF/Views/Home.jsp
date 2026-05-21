<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1">

    <title>Hospital Management System</title>

    <!-- Bootstrap CSS -->

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <!-- Bootstrap Icons -->

    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
          rel="stylesheet">

    <script>

        function showLoginAlert() {

            alert("Please login first!");

            window.location.href =
                "${pageContext.request.contextPath}/login";
        }

    </script>

    <style>

        body{
            background-color:#f4f6f9;
        }

        .hero{
            min-height:85vh;
            display:flex;
            align-items:center;
        }

        .hero-text h1{
            font-size:55px;
            font-weight:bold;
        }

        .hero-text p{
            font-size:20px;
            color:#6c757d;
        }

        .feature-card{
            transition:0.3s;
        }

        .feature-card:hover{
            transform:translateY(-5px);
        }

        footer{
            background:#0d6efd;
            color:white;
            padding:20px;
            margin-top:50px;
        }

    </style>

</head>

<body>

<!-- NAVBAR -->

<nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm">

    <div class="container">

        <a class="navbar-brand fw-bold"
           href="${pageContext.request.contextPath}/">

            <i class="bi bi-hospital"></i>
            HMS

        </a>

        <button class="navbar-toggler"
                type="button"
                data-bs-toggle="collapse"
                data-bs-target="#navbarNav">

            <span class="navbar-toggler-icon"></span>

        </button>

        <div class="collapse navbar-collapse"
             id="navbarNav">

            <ul class="navbar-nav ms-auto align-items-center">

                <!-- HOME -->

                <li class="nav-item">

                    <a class="nav-link"
                       href="${pageContext.request.contextPath}/">

                        Home

                    </a>

                </li>

                <!-- PATIENTS -->

                <c:choose>

                    <c:when test="${not empty sessionScope.loggedInPatient}">

                        <li class="nav-item">

                            <a class="nav-link"
                               href="${pageContext.request.contextPath}/patients">

                                Patients

                            </a>

                        </li>

                    </c:when>

                    <c:otherwise>

                        <li class="nav-item">

                            <button class="btn nav-link text-white"
                                    onclick="showLoginAlert()">

                                Patients

                            </button>

                        </li>

                    </c:otherwise>

                </c:choose>

                <!-- DOCTORS -->

                <c:choose>

                    <c:when test="${not empty sessionScope.loggedInPatient}">

                        <li class="nav-item">

                            <a class="nav-link"
                               href="${pageContext.request.contextPath}/doctors">

                                Doctors

                            </a>

                        </li>

                    </c:when>

                    <c:otherwise>

                        <li class="nav-item">

                            <button class="btn nav-link text-white"
                                    onclick="showLoginAlert()">

                                Doctors

                            </button>

                        </li>

                    </c:otherwise>

                </c:choose>

                <!-- DASHBOARD -->

                <c:choose>

                    <c:when test="${not empty sessionScope.loggedInPatient}">

                        <li class="nav-item">

                            <a class="nav-link"
                               href="${pageContext.request.contextPath}/dashboard">

                                Dashboard

                            </a>

                        </li>

                    </c:when>

                    <c:otherwise>

                        <li class="nav-item">

                            <button class="btn nav-link text-white"
                                    onclick="showLoginAlert()">

                                Dashboard

                            </button>

                        </li>

                    </c:otherwise>

                </c:choose>

                <!-- LOGIN / LOGOUT -->

                <c:choose>

                    <c:when test="${not empty sessionScope.loggedInPatient}">

                        <li class="nav-item ms-3">

                            <span class="badge bg-light text-dark p-2">

                                ${sessionScope.loggedInPatient.name}

                            </span>

                        </li>

                        <li class="nav-item ms-2">

                            <a class="btn btn-danger btn-sm"
                               href="${pageContext.request.contextPath}/logout">

                                Logout

                            </a>

                        </li>

                    </c:when>

                    <c:otherwise>

                        <li class="nav-item ms-2">

                            <a class="btn btn-light btn-sm"
                               href="${pageContext.request.contextPath}/login">

                                Login

                            </a>

                        </li>

                        <li class="nav-item ms-2">

                            <a class="btn btn-warning btn-sm"
                               href="${pageContext.request.contextPath}/register">

                                Register

                            </a>

                        </li>

                    </c:otherwise>

                </c:choose>

            </ul>

        </div>

    </div>

</nav>

<!-- HERO SECTION -->

<section class="hero">

    <div class="container">

        <div class="row align-items-center">

            <div class="col-lg-6 hero-text">

                <h1>
                    Hospital Management System
                </h1>

                <p class="mt-4">

                    Manage patients, doctors,
                    appointments and hospital
                    operations efficiently.

                </p>

                <div class="mt-4">

                    <c:choose>

                        <c:when test="${not empty sessionScope.loggedInPatient}">

                            <a href="${pageContext.request.contextPath}/dashboard"
                               class="btn btn-primary btn-lg me-3">

                                Go To Dashboard

                            </a>

                        </c:when>

                        <c:otherwise>

                            <button class="btn btn-primary btn-lg me-3"
                                    onclick="showLoginAlert()">

                                Go To Dashboard

                            </button>

                        </c:otherwise>

                    </c:choose>

                    <a href="${pageContext.request.contextPath}/register"
                       class="btn btn-outline-primary btn-lg">

                        Get Started

                    </a>

                </div>

            </div>

            <div class="col-lg-6 text-center">

                <img src="https://cdn-icons-png.flaticon.com/512/2966/2966486.png"
                     class="img-fluid"
                     width="450">

            </div>

        </div>

    </div>

</section>

<!-- FEATURES -->

<section class="container mb-5">

    <div class="text-center mb-5">

        <h2 class="fw-bold">

            HMS Features

        </h2>

        <p class="text-muted">

            Everything needed to manage a hospital efficiently

        </p>

    </div>

    <div class="row g-4">

        <!-- PATIENT -->

        <div class="col-md-4">

            <div class="card feature-card shadow-sm border-0 h-100">

                <div class="card-body text-center">

                    <i class="bi bi-people-fill text-primary"
                       style="font-size:60px;"></i>

                    <h4 class="mt-3">

                        Patient Management

                    </h4>

                    <p class="text-muted">

                        Add, update and manage
                        patient records easily.

                    </p>

                    <c:choose>

                        <c:when test="${not empty sessionScope.loggedInPatient}">

                            <a href="${pageContext.request.contextPath}/patients"
                               class="btn btn-primary">

                                Manage Patients

                            </a>

                        </c:when>

                        <c:otherwise>

                            <button class="btn btn-primary"
                                    onclick="showLoginAlert()">

                                Manage Patients

                            </button>

                        </c:otherwise>

                    </c:choose>

                </div>

            </div>

        </div>

        <!-- DOCTOR -->

        <div class="col-md-4">

            <div class="card feature-card shadow-sm border-0 h-100">

                <div class="card-body text-center">

                    <i class="bi bi-person-badge-fill text-success"
                       style="font-size:60px;"></i>

                    <h4 class="mt-3">

                        Doctor Management

                    </h4>

                    <p class="text-muted">

                        Manage doctor information,
                        departments and schedules.

                    </p>

                    <c:choose>

                        <c:when test="${not empty sessionScope.loggedInPatient}">

                            <a href="${pageContext.request.contextPath}/doctors"
                               class="btn btn-success">

                                Manage Doctors

                            </a>

                        </c:when>

                        <c:otherwise>

                            <button class="btn btn-success"
                                    onclick="showLoginAlert()">

                                Manage Doctors

                            </button>

                        </c:otherwise>

                    </c:choose>

                </div>

            </div>

        </div>

        <!-- APPOINTMENT -->

        <div class="col-md-4">

            <div class="card feature-card shadow-sm border-0 h-100">

                <div class="card-body text-center">

                    <i class="bi bi-calendar-check-fill text-warning"
                       style="font-size:60px;"></i>

                    <h4 class="mt-3">

                        Book Appointments

                    </h4>

                    <p class="text-muted">

                        Book and manage appointments
                        between doctors and patients.

                    </p>

                    <c:choose>

                        <c:when test="${not empty sessionScope.loggedInPatient}">

                            <a href="${pageContext.request.contextPath}/appointments"
                               class="btn btn-warning">

                                Book Now!!

                            </a>

                        </c:when>

                        <c:otherwise>

                            <button class="btn btn-warning"
                                    onclick="showLoginAlert()">

                                Book Now!!

                            </button>

                        </c:otherwise>

                    </c:choose>

                </div>

            </div>

        </div>

    </div>

</section>

<!-- FOOTER -->

<footer class="text-center">

    <h5>

        © 2026 Hospital Management System

    </h5>

</footer>

<!-- Bootstrap JS -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>