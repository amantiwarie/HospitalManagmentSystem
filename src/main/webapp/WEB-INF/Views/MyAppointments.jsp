<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c"
           uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1">

    <title>My Appointments</title>

    <!-- Bootstrap -->

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

</head>

<body class="bg-light">

<div class="container mt-5">

    <!-- HEADER -->

    <div class="d-flex justify-content-between align-items-center mb-4">

        <div>

            <h2 class="text-primary fw-bold mb-1">

                My Appointments

            </h2>

            <p class="text-muted mb-0">

                View all your scheduled appointments.

            </p>

        </div>

        <!-- BUTTONS -->

        <div>

            <a href="${pageContext.request.contextPath}/patient/dashboard"
               class="btn btn-outline-primary me-2">

                Patient Dashboard

            </a>

            <a href="${pageContext.request.contextPath}/"
               class="btn btn-dark">

                Home

            </a>

        </div>

    </div>

    <!-- TABLE CARD -->

    <div class="card shadow border-0">

        <div class="card-body">

            <div class="table-responsive">

                <table class="table table-hover align-middle">

                    <thead class="table-primary">

                    <tr>

                        <th>ID</th>

                        <th>Date</th>

                        <th>Time</th>

                        <th>Reason</th>

                        <th>Patient</th>

                        <th>Doctor</th>

                        <th>Action</th>

                    </tr>

                    </thead>

                    <tbody>

                    <!-- NO APPOINTMENTS -->

                    <c:if test="${empty appointments}">

                        <tr>

                            <td colspan="7"
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

                            <!-- PATIENT -->

                            <td>

                                <c:choose>

                                    <c:when test="${appointment.patient != null}">

                                        ${appointment.patient.name}

                                    </c:when>

                                    <c:otherwise>

                                        <span class="text-muted">

                                            Not Assigned

                                        </span>

                                    </c:otherwise>

                                </c:choose>

                            </td>

                            <!-- DOCTOR -->

                            <td>

                                <c:choose>

                                    <c:when test="${appointment.doctor != null}">

                                        Dr. ${appointment.doctor.name}

                                    </c:when>

                                    <c:otherwise>

                                        <span class="text-muted">

                                            Not Assigned

                                        </span>

                                    </c:otherwise>

                                </c:choose>

                            </td>

                            <!-- ACTION -->

                            <td>

                                <a href="${pageContext.request.contextPath}/appointments/delete/${appointment.id}"
                                   class="btn btn-danger btn-sm">

                                    Cancel

                                </a>

                            </td>

                        </tr>

                    </c:forEach>

                    </tbody>

                </table>

            </div>

        </div>

    </div>

</div>

</body>

</html>