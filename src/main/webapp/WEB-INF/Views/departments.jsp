<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Manage Departments - HMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background-color: #f4f6f9; font-family: Arial, sans-serif; }
        .sidebar { width:260px; min-height:100vh; background:#1e293b; position:fixed; left:0; top:0; color:white; }
        .sidebar .logo { padding:20px; font-size:24px; font-weight:bold; border-bottom:1px solid rgba(255,255,255,0.1); }
        .sidebar a { display:block; color:#cbd5e1; text-decoration:none; padding:14px 20px; transition:0.3s; }
        .sidebar a:hover { background:#334155; color:white; }
        .sidebar a.active { background:#0d6efd; color:white; }
        .main-content { margin-left:260px; padding:25px; }
        .topbar { background:white; padding:15px 25px; border-radius:10px; margin-bottom:25px; display:flex; justify-content:space-between; align-items:center; box-shadow:0 2px 10px rgba(0,0,0,0.05); }
        .card { border:none; border-radius:12px; box-shadow:0 2px 10px rgba(0,0,0,0.05); }
    </style>
</head>
<body>

<!-- SIDEBAR -->
<div class="sidebar">
    <div class="logo">HMS Admin</div>
    <a href="${pageContext.request.contextPath}/admin/dashboard">
        <i class="bi bi-speedometer2"></i> Dashboard
    </a>
    <a href="${pageContext.request.contextPath}/patients">
        <i class="bi bi-people"></i> Patients
    </a>
    <a href="${pageContext.request.contextPath}/doctors">
        <i class="bi bi-person-badge"></i> Doctors
    </a>
    <a href="${pageContext.request.contextPath}/departments" class="active">
        <i class="bi bi-hospital"></i> Departments
    </a>
    <a href="${pageContext.request.contextPath}/logout">
        <i class="bi bi-box-arrow-right"></i> Logout
    </a>
</div>

<!-- MAIN -->
<div class="main-content">

    <!-- TOPBAR -->
    <div class="topbar">
        <div>
            <h4 class="mb-0">Manage Departments</h4>
            <small class="text-muted">Add and manage hospital departments</small>
        </div>
    </div>

    <div class="row">

        <!-- ADD FORM -->
        <div class="col-md-4">
            <div class="card p-4 mb-4">
                <h5 class="mb-3">Add New Department</h5>
                <form action="${pageContext.request.contextPath}/departments/save" method="post">
                    <div class="mb-3">
                        <label class="form-label fw-bold">Department Name</label>
                        <input type="text" name="name" class="form-control"
                               required placeholder="e.g. Cardiology">
                    </div>
                    <button type="submit" class="btn btn-primary w-100">
                        <i class="bi bi-plus-circle"></i> Add Department
                    </button>
                </form>
            </div>

            <!-- QUICK ADD 10 DEPARTMENTS INFO -->
            <div class="card p-4">
                <h6 class="mb-2 text-muted">Common Departments</h6>
                <small class="text-muted">
                    You can add these one by one:<br><br>
                    Cardiology, Neurology, Orthopedics,<br>
                    Pediatrics, Emergency, Radiology,<br>
                    Oncology, Dermatology, Gynecology,<br>
                    General Surgery
                </small>
            </div>
        </div>

        <!-- DEPARTMENTS TABLE -->
        <div class="col-md-8">
            <div class="card p-4">
                <h5 class="mb-3">
                    All Departments
                    <span class="badge bg-primary ms-2">${departments.size()}</span>
                </h5>

                <table class="table table-hover align-middle">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Department Name</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty departments}">
                                <c:forEach var="dept" items="${departments}">
                                    <tr>
                                        <td>#${dept.id}</td>
                                        <td>
                                            <i class="bi bi-hospital text-primary me-2"></i>
                                            ${dept.name}
                                        </td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/departments/delete/${dept.id}"
                                               class="btn btn-sm btn-outline-danger"
                                               onclick="return confirm('Delete ${dept.name}?')">
                                                <i class="bi bi-trash"></i> Delete
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="3" class="text-center text-muted py-4">
                                        No departments yet. Add one using the form.
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>

            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
