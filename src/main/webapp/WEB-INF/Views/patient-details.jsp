<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c"
           uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

<head>

    <title>Patient Details</title>

    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet">

</head>

<body class="bg-light">

<div class="container mt-5">

    <div class="card shadow-lg border-0">

        <div class="card-header bg-primary text-white">

            <h2 class="mb-0">

                Patient Details

            </h2>

        </div>

        <div class="card-body">

            <!-- UPDATE FORM -->

            <form action="${pageContext.request.contextPath}/patients/update"
                  method="post">

                <!-- ID -->

                <input type="hidden"
                       name="id"
                       value="${patient.id}">

                <div class="row">

                    <!-- NAME -->

                    <div class="col-md-6 mb-3">

                        <label class="form-label fw-bold">

                            Name

                        </label>

                        <input type="text"
                               name="name"
                               value="${patient.name}"
                               class="form-control"
                               required>

                    </div>

                    <!-- EMAIL -->

                    <div class="col-md-6 mb-3">

                        <label class="form-label fw-bold">

                            Email

                        </label>

                        <input type="email"
                               name="email"
                               value="${patient.email}"
                               class="form-control"
                               required>

                    </div>

                </div>

                <div class="row">

                    <!-- AGE -->

                    <div class="col-md-6 mb-3">

                        <label class="form-label fw-bold">

                            Age

                        </label>

                        <input type="number"
                               name="age"
                               value="${patient.age}"
                               class="form-control">

                    </div>

                    <!-- BLOOD TYPE -->

                    <div class="col-md-6 mb-3">

                        <label class="form-label fw-bold">

                            Blood Type

                        </label>

                        <select name="bloodType"
                                class="form-select">

                            <option value="A_POSITIVE"
                                ${patient.bloodType == 'A_POSITIVE' ? 'selected' : ''}>
                                A+
                            </option>

                            <option value="B_POSITIVE"
                                ${patient.bloodType == 'B_POSITIVE' ? 'selected' : ''}>
                                B+
                            </option>

                            <option value="O_POSITIVE"
                                ${patient.bloodType == 'O_POSITIVE' ? 'selected' : ''}>
                                O+
                            </option>

                            <option value="AB_POSITIVE"
                                ${patient.bloodType == 'AB_POSITIVE' ? 'selected' : ''}>
                                AB+
                            </option>

                        </select>

                    </div>

                </div>

                <!-- REGISTERED DATE -->

                <div class="mb-3">

                    <label class="form-label fw-bold">

                        Registered At

                    </label>

                    <input type="date"
                           name="registeredAt"
                           value="${patient.registeredAt}"
                           class="form-control">

                </div>

                <!-- BUTTONS -->

                <div class="text-center mt-4">

                    <button type="submit"
                            class="btn btn-success me-2">

                        Update Details

                    </button>

                    <a href="${pageContext.request.contextPath}/patients"
                       class="btn btn-primary me-2">

                        Back

                    </a>

                    <a href="${pageContext.request.contextPath}/patients/delete/${patient.id}"
                       class="btn btn-danger">

                        Delete Patient

                    </a>

                </div>

            </form>

        </div>

    </div>

</div>

</body>

</html>