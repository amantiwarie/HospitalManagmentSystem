<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Admin Dashboard - HMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background-color:#f4f6f9; font-family: Arial, sans-serif; }
        .sidebar { width:260px; min-height:100vh; background:#1e293b; position:fixed; left:0; top:0; color:white; }
        .sidebar .logo { padding:20px; font-size:24px; font-weight:bold; border-bottom:1px solid rgba(255,255,255,0.1); }
        .sidebar a { display:block; color:#cbd5e1; text-decoration:none; padding:14px 20px; transition:0.3s; }
        .sidebar a:hover { background:#334155; color:white; }
        .sidebar a.active { background:#0d6efd; color:white; }
        .main-content { margin-left:260px; padding:25px; }
        .topbar { background:white; padding:15px 25px; border-radius:10px; margin-bottom:25px; display:flex; justify-content:space-between; align-items:center; box-shadow:0 2px 10px rgba(0,0,0,0.05); }
        .dashboard-card { border:none; border-radius:12px; box-shadow:0 2px 10px rgba(0,0,0,0.05); transition:0.3s; }
        .dashboard-card:hover { transform:translateY(-3px); }
        .icon-box { width:55px; height:55px; border-radius:10px; display:flex; justify-content:center; align-items:center; font-size:24px; color:white; }
        .bg-patient { background:#0d6efd; }
        .bg-doctor { background:#198754; }
        .bg-appointment { background:#ffc107; }
        .bg-department { background:#dc3545; }
        .table-container { background:white; padding:20px; border-radius:12px; box-shadow:0 2px 10px rgba(0,0,0,0.05); margin-bottom:25px; }
        @media(max-width:768px) { .sidebar { width:100%; min-height:auto; position:relative; } .main-content { margin-left:0; } }
    </style>
</head>
<body>

<!-- SIDEBAR -->
<div class="sidebar">
    <div class="logo">HMS Admin</div>
    <a href="${pageContext.request.contextPath}/admin/dashboard" class="active">
        <i class="bi bi-speedometer2"></i> Dashboard
    </a>
    <a href="${pageContext.request.contextPath}/patients">
        <i class="bi bi-people"></i> Patients
    </a>

    <a href="${pageContext.request.contextPath}/doctors">
        <i class="bi bi-person-badge"></i> Doctors
    </a>
    <a href="${pageContext.request.contextPath}/departments">
        <i class="bi bi-hospital"></i> Departments
    </a>
    <a href="${pageContext.request.contextPath}/logout">
        <i class="bi bi-box-arrow-right"></i> Logout
    </a>
</div>

<!-- MAIN CONTENT -->
<div class="main-content">

    <!-- TOPBAR -->
    <div class="topbar">
        <div>
            <h4 class="mb-0">Admin Dashboard</h4>

            <small class="text-muted">
                Welcome back,
                <c:choose>
                    <c:when test="${not empty sessionScope.loggedInUser}">
                        ${sessionScope.loggedInUser.name}
                    </c:when>
                    <c:otherwise>Admin</c:otherwise>
                </c:choose>
            </small>
        </div>
        <div>
            <span class="badge bg-success p-2">System Active</span>
        </div>
    </div>

    <!-- SUCCESS MESSAGE -->
    <c:if test="${not empty sessionScope.successMessage}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            ${sessionScope.successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <c:remove var="successMessage" scope="session"/>
    </c:if>

    <!-- STATS CARDS -->
    <div class="row g-4 mb-4">

        <!-- PATIENTS -->
        <div class="col-md-3">
            <div class="card dashboard-card">
                <div class="card-body d-flex justify-content-between align-items-center">
                    <div>
                        <h6 class="text-muted">Total Patients</h6>
                        <h2>${totalPatients != null ? totalPatients : 0}</h2>
                    </div>
                    <div class="icon-box bg-patient">
                        <i class="bi bi-people-fill"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- DOCTORS -->
        <div class="col-md-3">
            <div class="card dashboard-card">
                <div class="card-body d-flex justify-content-between align-items-center">
                    <div>
                        <h6 class="text-muted">Total Doctors</h6>
                        <h2>${totalDoctors != null ? totalDoctors : 0}</h2>
                    </div>
                    <div class="icon-box bg-doctor">
                        <i class="bi bi-person-badge-fill"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- APPOINTMENTS -->
        <div class="col-md-3">
            <div class="card dashboard-card">
                <div class="card-body d-flex justify-content-between align-items-center">
                    <div>
                        <h6 class="text-muted">Total Appointments</h6>
                        <h2>${totalAppointments != null ? totalAppointments : 0}</h2>
                    </div>
                    <div class="icon-box bg-appointment">
                        <i class="bi bi-calendar2-check-fill"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- DEPARTMENTS -->
        <div class="col-md-3">
            <div class="card dashboard-card">
                <div class="card-body d-flex justify-content-between align-items-center">
                    <div>
                        <h6 class="text-muted">Departments</h6>
                        <h2>${totalDepartments != null ? totalDepartments : 0}</h2>
                    </div>
                    <div class="icon-box bg-department">
                        <i class="bi bi-hospital-fill"></i>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <!-- RECENT PATIENTS TABLE -->
    <div class="table-container">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h5>Recent Patients</h5>
            <a href="${pageContext.request.contextPath}/patients" class="btn btn-primary btn-sm">View All</a>
        </div>
        <table class="table table-hover align-middle">
            <thead class="table-light">
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Blood Group</th>
                    <th>Registered Date</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty recentPatients}">
                        <c:forEach var="p" items="${recentPatients}">
                            <tr>
                                <td>#${p.id}</td>
                                <td>${p.name}</td>
                                <td>${p.email}</td>
                                <td><span class="badge bg-danger">${p.bloodType}</span></td>
                                <td>${p.registeredAt}</td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="5" class="text-center text-muted">No Patients Found</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>

    <!-- RECENT DOCTORS TABLE -->
    <div class="table-container">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h5>Doctors</h5>
            <a href="${pageContext.request.contextPath}/doctors" class="btn btn-success btn-sm">View All</a>
        </div>
        <table class="table table-hover align-middle">
            <thead class="table-light">
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Specialization</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty recentDoctors}">
                        <c:forEach var="d" items="${recentDoctors}">
                            <tr>
                                <td>#${d.id}</td>
                                <td>${d.name}</td>
                                <td>${d.email}</td>
                                <td><span class="badge bg-success">${d.specialization}</span></td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="4" class="text-center text-muted">No Doctors Found</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>

    <!-- RECENT APPOINTMENTS TABLE -->
    <div class="table-container">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h5>Recent Appointments</h5>
        </div>
        <table class="table table-hover align-middle">
            <thead class="table-light">
                <tr>
                    <th>ID</th>
                    <th>Patient</th>
                    <th>Doctor</th>
                    <th>Date</th>
                    <th>Time</th>
                    <th>Reason</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty recentAppointments}">
                        <c:forEach var="a" items="${recentAppointments}">
                            <tr>
                                <td>#${a.id}</td>
                                <td>${a.patient.name}</td>
                                <td>${a.doctor.name}</td>
                                <td>${a.appointmentDate}</td>
                                <td>${a.appointmentTime}</td>
                                <td>${a.reason}</td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="6" class="text-center text-muted">No Appointments Found</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
