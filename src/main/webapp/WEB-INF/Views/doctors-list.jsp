```jsp
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1">

    <title>Manage Doctors - HMS</title>

    <!-- BOOTSTRAP -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <!-- ICONS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
          rel="stylesheet">

    <style>

        body {
            background-color: #f4f6f9;
        }

        .sidebar {
            width: 260px;
            min-height: 100vh;
            background: #1e293b;
            position: fixed;
            left: 0;
            top: 0;
        }

        .sidebar .logo {
            padding: 20px;
            font-size: 22px;
            font-weight: bold;
            color: white;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }

        .sidebar a {
            display: block;
            color: #cbd5e1;
            text-decoration: none;
            padding: 14px 20px;
            transition: 0.3s;
        }

        .sidebar a:hover {
            background: #334155;
            color: white;
        }

        .sidebar a.active {
            background: #0d6efd;
            color: white;
        }

        .main-content {
            margin-left: 260px;
            padding: 25px;
        }

        .topbar {
            background: white;
            padding: 15px 25px;
            border-radius: 10px;
            margin-bottom: 25px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 8px rgba(0,0,0,0.06);
        }

        .card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.06);
        }

        .doctor-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
        }

        .avatar-placeholder {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #e2e8f0;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #94a3b8;
            font-size: 18px;
        }

    </style>

</head>

<body>

<!-- SIDEBAR -->
<div class="sidebar">

    <div class="logo">
        <i class="bi bi-hospital me-2"></i>
        HMS Admin
    </div>

    <a href="${pageContext.request.contextPath}/admin/dashboard">
        <i class="bi bi-speedometer2 me-2"></i>
        Dashboard
    </a>

    <a href="${pageContext.request.contextPath}/patients">
        <i class="bi bi-people me-2"></i>
        Patients
    </a>

    <a href="${pageContext.request.contextPath}/doctors"
       class="active">

        <i class="bi bi-person-badge me-2"></i>
        Doctors

    </a>

    <a href="${pageContext.request.contextPath}/departments">
        <i class="bi bi-hospital me-2"></i>
        Departments
    </a>

    <a href="${pageContext.request.contextPath}/logout">
        <i class="bi bi-box-arrow-right me-2"></i>
        Logout
    </a>

</div>

<!-- MAIN CONTENT -->
<div class="main-content">

    <!-- TOPBAR -->
    <div class="topbar">

        <div>

            <h5 class="mb-0 fw-bold">
                Manage Doctors
            </h5>

            <small class="text-muted">
                Add and manage doctors
            </small>

        </div>

        <a href="${pageContext.request.contextPath}/admin/dashboard"
           class="btn btn-outline-secondary btn-sm">

            <i class="bi bi-arrow-left me-1"></i>
            Back to Dashboard

        </a>

    </div>

    <!-- SUCCESS MESSAGE -->
    <c:if test="${not empty sessionScope.successMessage}">

        <div class="alert alert-success alert-dismissible fade show">

            <i class="bi bi-check-circle me-2"></i>
            ${sessionScope.successMessage}

            <button type="button"
                    class="btn-close"
                    data-bs-dismiss="alert">

            </button>

        </div>

        <c:remove var="successMessage"
                  scope="session"/>

    </c:if>

    <div class="row g-4">

        <!-- ADD DOCTOR FORM -->
        <div class="col-md-4">

            <div class="card p-4">

                <h6 class="fw-bold mb-3">
                    Add New Doctor
                </h6>

                <form action="${pageContext.request.contextPath}/doctors/save"
                      method="post"
                      enctype="multipart/form-data">

                    <!-- NAME -->
                    <div class="mb-3">

                        <label class="form-label fw-semibold">
                            Name
                        </label>

                        <input type="text"
                               name="name"
                               class="form-control"
                               required
                               placeholder="Dr. John Smith">

                    </div>

                    <!-- EMAIL -->
                    <div class="mb-3">

                        <label class="form-label fw-semibold">
                            Email
                        </label>

                        <input type="email"
                               name="email"
                               class="form-control"
                               required
                               placeholder="doctor@hospital.com">

                    </div>

                    <!-- AGE -->
                    <div class="mb-3">

                        <label class="form-label fw-semibold">
                            Age
                        </label>

                        <input type="number"
                               name="age"
                               class="form-control"
                               placeholder="35">

                    </div>

                    <!-- DEPARTMENT -->
                    <div class="mb-3">

                        <label class="form-label fw-semibold">
                            Department
                        </label>

                        <select name="departmentId"
                                class="form-select"
                                required>

                            <option value="">
                                -- Select Department --
                            </option>

                            <c:forEach var="dept"
                                       items="${departments}">

                                <option value="${dept.id}">
                                    ${dept.name}
                                </option>

                            </c:forEach>

                        </select>

                    </div>

                    <!-- IMAGE -->
                    <div class="mb-3">

                        <label class="form-label fw-semibold">

                            Profile Photo

                            <span class="text-muted fw-normal">
                                (optional)
                            </span>

                        </label>

                        <input type="file"
                               name="imageFile"
                               class="form-control"
                               accept="image/*"
                               onchange="previewImage(this, 'addPreview')">

                        <div class="mt-2">

                            <img id="addPreview"
                                 src="#"
                                 alt="Preview"
                                 class="rounded-circle border d-none"
                                 style="width:60px;height:60px;object-fit:cover;">

                        </div>

                    </div>

                    <!-- BUTTON -->
                    <button type="submit"
                            class="btn btn-success w-100">

                        <i class="bi bi-plus-circle me-1"></i>
                        Add Doctor

                    </button>

                </form>

            </div>

        </div>

        <!-- DOCTORS TABLE -->
        <div class="col-md-8">

            <div class="card p-4">

                <!-- TOP -->
                <div class="d-flex justify-content-between align-items-center mb-3">

                    <h6 class="fw-bold mb-0">
                        All Doctors
                    </h6>

                    <!-- SEARCH -->
                    <input type="text"
                           id="doctorSearch"
                           class="form-control w-50 mx-3"
                           placeholder="Search doctor...">

                    <span class="badge bg-success">
                        ${doctors.size()} Total
                    </span>

                </div>

                <div class="table-responsive">

                    <table class="table table-hover align-middle mb-0">

                        <thead class="table-dark">

                        <tr>

                            <th>Photo</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Department</th>
                            <th>Actions</th>

                        </tr>

                        </thead>

                        <!-- IMPORTANT -->
                        <tbody id="doctorTableBody">

                        <c:choose>

                            <c:when test="${not empty doctors}">

                                <c:forEach var="doctor"
                                           items="${doctors}">

                                    <tr>

                                        <!-- PHOTO -->
                                        <td>

                                            <c:choose>

                                                <c:when test="${not empty doctor.imagePath}">

                                                    <img src="${pageContext.request.contextPath}/${doctor.imagePath}"
                                                         class="doctor-avatar">

                                                </c:when>

                                                <c:otherwise>

                                                    <div class="avatar-placeholder">
                                                        <i class="bi bi-person"></i>
                                                    </div>

                                                </c:otherwise>

                                            </c:choose>

                                        </td>

                                        <!-- NAME -->
                                        <td>${doctor.name}</td>

                                        <!-- EMAIL -->
                                        <td>${doctor.email}</td>

                                        <!-- DEPARTMENT -->
                                        <td>

                                            <c:choose>

                                                <c:when test="${not empty doctor.department}">

                                                    <span class="badge bg-info text-dark">
                                                        ${doctor.department.name}
                                                    </span>

                                                </c:when>

                                                <c:otherwise>

                                                    <span class="text-muted fst-italic">
                                                        Not assigned
                                                    </span>

                                                </c:otherwise>

                                            </c:choose>

                                        </td>

                                        <!-- ACTION -->
                                        <td>

                                            <a href="${pageContext.request.contextPath}/doctors/${doctor.id}"
                                               class="btn btn-sm btn-outline-primary">

                                                <i class="bi bi-eye"></i>

                                            </a>

                                            <a href="${pageContext.request.contextPath}/doctors/delete/${doctor.id}"
                                               class="btn btn-sm btn-outline-danger"
                                               onclick="return confirm('Delete this doctor?')">

                                                <i class="bi bi-trash"></i>

                                            </a>

                                        </td>

                                    </tr>

                                </c:forEach>

                            </c:when>

                            <c:otherwise>

                                <tr>

                                    <td colspan="5"
                                        class="text-center text-muted py-4">

                                        No doctors found.

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

</div>

<!-- BOOTSTRAP -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>

    // IMAGE PREVIEW
    function previewImage(input, previewId) {

        const preview =
            document.getElementById(previewId);

        if (input.files && input.files[0]) {

            const reader = new FileReader();

            reader.onload = e => {

                preview.src = e.target.result;

                preview.classList.remove('d-none');

            };

            reader.readAsDataURL(input.files[0]);

        }

    }

    // DOCTOR SEARCH
    const doctorSearch =
        document.getElementById("doctorSearch");

    doctorSearch.addEventListener("keyup", function () {

        const keyword =
            doctorSearch.value.toLowerCase();

        const rows =
            document.querySelectorAll("#doctorTableBody tr");

        rows.forEach(row => {

            const doctorName =
                row.children[1]
                    .textContent
                    .toLowerCase();

            const doctorEmail =
                row.children[2]
                    .textContent
                    .toLowerCase();

            const department =
                row.children[3]
                    .textContent
                    .toLowerCase();

            if (
                doctorName.includes(keyword) ||
                doctorEmail.includes(keyword) ||
                department.includes(keyword)
            ) {

                row.style.display = "";

            } else {

                row.style.display = "none";

            }

        });

    });

</script>

</body>
</html>
```
