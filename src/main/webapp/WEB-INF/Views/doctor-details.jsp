<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Doctor Details - HMS</title>
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
        .info-row { display:flex; justify-content:space-between; padding:12px 0; border-bottom:1px solid #f0f0f0; }
        .info-row:last-child { border-bottom:none; }
        .info-label { font-weight:600; color:#64748b; font-size:14px; }
        .info-value { color:#1e293b; font-size:14px; }
        .doctor-photo { width:100px; height:100px; border-radius:50%; object-fit:cover; border:3px solid #e2e8f0; }
        .doctor-photo-placeholder { width:100px; height:100px; border-radius:50%; background:#e2e8f0; display:flex; align-items:center; justify-content:center; font-size:40px; color:#94a3b8; border:3px solid #e2e8f0; }
    </style>
</head>
<body>

<div class="sidebar">
    <div class="logo"><i class="bi bi-hospital me-2"></i>HMS Admin</div>
    <a href="${pageContext.request.contextPath}/admin/dashboard"><i class="bi bi-speedometer2 me-2"></i>Dashboard</a>
    <a href="${pageContext.request.contextPath}/patients"><i class="bi bi-people me-2"></i>Patients</a>
    <a href="${pageContext.request.contextPath}/doctors" class="active"><i class="bi bi-person-badge me-2"></i>Doctors</a>
    <a href="${pageContext.request.contextPath}/departments"><i class="bi bi-hospital me-2"></i>Departments</a>
    <a href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right me-2"></i>Logout</a>
</div>

<div class="main-content">

    <div class="topbar">
        <div>
            <h5 class="mb-0 fw-bold">Doctor Details</h5>
            <small class="text-muted">#${doctor.id} — ${doctor.name}</small>
        </div>
        <a href="${pageContext.request.contextPath}/doctors" class="btn btn-outline-secondary btn-sm">
            <i class="bi bi-arrow-left me-1"></i> Back to Doctors
        </a>
    </div>

    <c:if test="${not empty sessionScope.successMessage}">
        <div class="alert alert-success alert-dismissible fade show">
            <i class="bi bi-check-circle me-2"></i>${sessionScope.successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <c:remove var="successMessage" scope="session"/>
    </c:if>

    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card p-4">

                <!-- HEADER -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div class="d-flex align-items-center gap-3">
                        <%-- PHOTO --%>
                        <c:choose>
                            <c:when test="${not empty doctor.imagePath}">
                                <img src="${pageContext.request.contextPath}/${doctor.imagePath}"
                                     class="doctor-photo" id="currentPhoto">
                            </c:when>
                            <c:otherwise>
                                <div class="doctor-photo-placeholder" id="currentPhoto">
                                    <i class="bi bi-person"></i>
                                </div>
                            </c:otherwise>
                        </c:choose>
                        <div>
                            <h5 class="mb-0 fw-bold">${doctor.name}</h5>
                            <small class="text-muted">${doctor.email}</small>
                        </div>
                    </div>
                    <div>
                        <button id="editBtn" class="btn btn-warning btn-sm" onclick="toggleEdit(true)">
                            <i class="bi bi-pencil me-1"></i> Edit
                        </button>
                        <button id="cancelBtn" class="btn btn-outline-secondary btn-sm d-none" onclick="toggleEdit(false)">
                            <i class="bi bi-x me-1"></i> Cancel
                        </button>
                    </div>
                </div>

                <%-- ====== VIEW MODE ====== --%>
                <div id="viewMode">
                    <div class="info-row">
                        <span class="info-label">Doctor ID</span>
                        <span class="info-value">#${doctor.id}</span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Name</span>
                        <span class="info-value">${doctor.name}</span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Email</span>
                        <span class="info-value">${doctor.email}</span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Age</span>
                        <span class="info-value">${doctor.age}</span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Department</span>
                        <span class="info-value">
                            <c:choose>
                                <c:when test="${not empty doctor.department}">
                                    <span class="badge bg-info text-dark">${doctor.department.name}</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="text-muted">Not assigned</span>
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </div>

                    <div class="mt-4 text-end">
                        <a href="${pageContext.request.contextPath}/doctors/delete/${doctor.id}"
                           class="btn btn-outline-danger btn-sm"
                           onclick="return confirm('Delete this doctor?')">
                            <i class="bi bi-trash me-1"></i> Delete Doctor
                        </a>
                    </div>
                </div>

                <%-- ====== EDIT MODE ====== --%>
                <div id="editMode" class="d-none">
                    <form action="${pageContext.request.contextPath}/doctors/update"
                          method="post" enctype="multipart/form-data">

                        <input type="hidden" name="id" value="${doctor.id}">
                        <%-- keep existing image if no new one uploaded --%>
                        <input type="hidden" name="imagePath" value="${doctor.imagePath}">

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-semibold">Name</label>
                                <input type="text" name="name" class="form-control"
                                       value="${doctor.name}" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-semibold">Email</label>
                                <input type="email" name="email" class="form-control"
                                       value="${doctor.email}" required>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-semibold">Age</label>
                                <input type="number" name="age" class="form-control"
                                       value="${doctor.age}">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-semibold">Department</label>
                                <select name="departmentId" class="form-select">
                                    <option value="">-- Select Department --</option>
                                    <c:forEach var="dept" items="${departments}">
                                        <option value="${dept.id}"
                                            ${doctor.department != null && doctor.department.id == dept.id ? 'selected' : ''}>
                                            ${dept.name}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <%-- PHOTO UPLOAD --%>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">
                                Change Photo <span class="text-muted fw-normal">(optional)</span>
                            </label>
                            <input type="file" name="imageFile" class="form-control"
                                   accept="image/*"
                                   onchange="previewNewImage(this)">
                            <div class="mt-2">
                                <img id="newPreview" src="#" alt="New Preview"
                                     class="rounded-circle border d-none"
                                     style="width:70px;height:70px;object-fit:cover;">
                            </div>
                            <div class="form-text">Leave empty to keep current photo</div>
                        </div>

                        <div class="d-flex gap-2 mt-3">
                            <button type="submit" class="btn btn-success">
                                <i class="bi bi-check-lg me-1"></i> Save Changes
                            </button>
                            <button type="button" class="btn btn-outline-secondary"
                                    onclick="toggleEdit(false)">
                                Cancel
                            </button>
                        </div>

                    </form>
                </div>

            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function toggleEdit(editing) {
        document.getElementById('viewMode').classList.toggle('d-none', editing);
        document.getElementById('editMode').classList.toggle('d-none', !editing);
        document.getElementById('editBtn').classList.toggle('d-none', editing);
        document.getElementById('cancelBtn').classList.toggle('d-none', !editing);
    }

    function previewNewImage(input) {
        const preview = document.getElementById('newPreview');
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
