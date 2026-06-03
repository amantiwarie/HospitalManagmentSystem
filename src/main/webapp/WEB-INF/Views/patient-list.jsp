<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Manage Patients - HMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background-color: #f4f6f9; }
        .sidebar { width:260px; min-height:100vh; background:#1e293b; position:fixed; left:0; top:0; }
        .sidebar .logo { padding:20px; font-size:22px; font-weight:bold; color:white; border-bottom:1px solid rgba(255,255,255,0.1); }
        .sidebar a { display:block; color:#cbd5e1; text-decoration:none; padding:14px 20px; transition:0.3s; }
        .sidebar a:hover { background:#334155; color:white; }
        .sidebar a.active { background:#0d6efd; color:white; }
        .main-content { margin-left:260px; padding:25px; }
        .topbar { background:white; padding:15px 25px; border-radius:10px; margin-bottom:25px; display:flex; justify-content:space-between; align-items:center; box-shadow:0 2px 8px rgba(0,0,0,0.06); }
        .card { border:none; border-radius:12px; box-shadow:0 2px 8px rgba(0,0,0,0.06); }
        .avatar { width:38px; height:38px; border-radius:50%; object-fit:cover; }
        .avatar-placeholder { width:38px; height:38px; border-radius:50%; background:#e2e8f0; display:flex; align-items:center; justify-content:center; color:#94a3b8; font-size:16px; }
    </style>
</head>
<body>

<div class="sidebar">
    <div class="logo"><i class="bi bi-hospital me-2"></i>HMS Admin</div>
    <a href="${pageContext.request.contextPath}/admin/dashboard"><i class="bi bi-speedometer2 me-2"></i>Dashboard</a>
    <a href="${pageContext.request.contextPath}/patients" class="active"><i class="bi bi-people me-2"></i>Patients</a>
    <a href="${pageContext.request.contextPath}/doctors"><i class="bi bi-person-badge me-2"></i>Doctors</a>
    <a href="${pageContext.request.contextPath}/departments"><i class="bi bi-hospital me-2"></i>Departments</a>
    <a href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right me-2"></i>Logout</a>
</div>

<div class="main-content">

    <div class="topbar">
        <div>
            <h5 class="mb-0 fw-bold">Manage Patients</h5>
            <small class="text-muted">View, add and manage patients</small>
        </div>
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-outline-secondary btn-sm">
            <i class="bi bi-arrow-left me-1"></i> Back to Dashboard
        </a>
    </div>

    <%-- SUCCESS MESSAGE --%>
    <c:if test="${not empty sessionScope.successMessage}">
        <div class="alert alert-success alert-dismissible fade show">
            <i class="bi bi-check-circle me-2"></i>${sessionScope.successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <c:remove var="successMessage" scope="session"/>
    </c:if>

    <div class="row g-4">

        <!-- LEFT: ADD FORM + SEARCH -->
        <div class="col-md-4">

            <!-- ADD PATIENT FORM -->
            <div class="card p-4 mb-4">
                <h6 class="fw-bold mb-3"><i class="bi bi-person-plus me-2 text-primary"></i>Add New Patient</h6>

                <%-- FIX: enctype required for image upload --%>
                <form action="${pageContext.request.contextPath}/patients/save"
                      method="post" enctype="multipart/form-data">

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Name</label>
                        <input type="text" name="name" class="form-control" required placeholder="Full name">
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Email</label>
                        <input type="email" name="email" class="form-control" required placeholder="email@example.com">
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Age</label>
                        <input type="number" name="age" class="form-control" placeholder="25" min="0" max="150">
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Blood Type</label>
                        <select name="bloodType" class="form-select">
                            <option value="">-- Select --</option>
                            <option value="A_POSITIVE">A+</option>
                            <option value="A_NEGATIVE">A-</option>
                            <option value="B_POSITIVE">B+</option>
                            <option value="B_NEGATIVE">B-</option>
                            <option value="O_POSITIVE">O+</option>
                            <option value="O_NEGATIVE">O-</option>
                            <option value="AB_POSITIVE">AB+</option>
                            <option value="AB_NEGATIVE">AB-</option>
                        </select>
                    </div>

                    <%-- PHOTO UPLOAD --%>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">
                            Profile Photo <span class="text-muted fw-normal">(optional)</span>
                        </label>
                        <input type="file" name="imageFile" class="form-control"
                               accept="image/*" onchange="previewImage(this, 'addPreview')">
                        <div class="mt-2">
                            <img id="addPreview" src="#" alt="Preview"
                                 class="rounded-circle border d-none"
                                 style="width:55px;height:55px;object-fit:cover;">
                        </div>
                    </div>

                    <button type="submit" class="btn btn-primary w-100">
                        <i class="bi bi-plus-circle me-1"></i> Add Patient
                    </button>
                </form>
            </div>

            <!-- SEARCH -->
            <div class="card p-4">
                <h6 class="fw-bold mb-3"><i class="bi bi-search me-2 text-secondary"></i>Search Patient</h6>
                <form action="${pageContext.request.contextPath}/patients/search" method="get">
                    <div class="mb-3">
                        <input type="text" name="name" class="form-control"
                               placeholder="Type name..."
                               value="${searchTerm}">
                    </div>
                    <button type="submit" class="btn btn-outline-primary w-100 mb-2">
                        <i class="bi bi-search me-1"></i> Search
                    </button>
                    <%-- CLEAR SEARCH button shown only when search is active --%>
                    <c:if test="${not empty searchTerm}">
                        <a href="${pageContext.request.contextPath}/patients"
                           class="btn btn-outline-secondary w-100">
                            <i class="bi bi-x me-1"></i> Clear Results
                        </a>
                    </c:if>
                </form>
            </div>
        </div>

        <!-- RIGHT: PATIENTS TABLE -->
        <div class="col-md-8">
            <div class="card p-4">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h6 class="fw-bold mb-0">
                        <c:choose>
                            <c:when test="${not empty searchTerm}">
                                Results for "<span class="text-primary">${searchTerm}</span>"
                            </c:when>
                            <c:otherwise>All Patients</c:otherwise>
                        </c:choose>
                    </h6>
                    <span class="badge bg-primary rounded-pill">${patients.size()} Total</span>
                </div>

                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-dark">
                            <tr>
                                <th>Photo</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Blood Type</th>
                                <th>Registered</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty patients}">
                                    <c:forEach var="patient" items="${patients}">
                                        <tr>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty patient.imagePath}">
                                                        <img src="${pageContext.request.contextPath}/${patient.imagePath}"
                                                             class="avatar">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="avatar-placeholder">
                                                            <i class="bi bi-person"></i>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="fw-semibold">${patient.name}</td>
                                            <td class="text-muted">${patient.email}</td>
                                            <td><span class="badge bg-danger">${patient.bloodType}</span></td>
                                            <td>${patient.registeredAt}</td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/patients/${patient.id}"
                                                   class="btn btn-sm btn-outline-primary me-1"
                                                   title="View Details">
                                                    <i class="bi bi-eye"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/patients/delete/${patient.id}"
                                                   class="btn btn-sm btn-outline-danger"
                                                   title="Delete"
                                                   onclick="return confirm('Delete ${patient.name}?')">
                                                    <i class="bi bi-trash"></i>
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="6" class="text-center text-muted py-5">
                                            <i class="bi bi-people display-6 d-block mb-2 opacity-25"></i>
                                            <c:choose>
                                                <c:when test="${not empty searchTerm}">
                                                    No patients found for "<strong>${searchTerm}</strong>"
                                                </c:when>
                                                <c:otherwise>No patients found. Add one using the form.</c:otherwise>
                                            </c:choose>
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function previewImage(input, previewId) {
        const preview = document.getElementById(previewId);
        if (input.files && input.files[0]) {
            const reader = new FileReader();
            reader.onload = e => {
                preview.src = e.target.result;
                preview.classList.remove('d-none');
            };
            reader.readAsDataURL(input.files[0]);
        }
    }
</script>
</body>
</html>
