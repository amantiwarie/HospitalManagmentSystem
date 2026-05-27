<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c"
           uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1">

    <title>Book Appointment</title>

    <!-- Bootstrap -->

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

</head>

<body class="bg-light">

<div class="container mt-5">

    <div class="row justify-content-center">

        <div class="col-md-7">

            <!-- CARD -->

            <div class="card shadow border-0 rounded-4">

                <div class="card-body p-5">

                    <!-- TITLE -->

                    <div class="text-center mb-4">

                        <h2 class="text-primary fw-bold">

                            Book Appointment

                        </h2>

                        <p class="text-muted">

                            Schedule appointment with doctors easily.

                        </p>

                    </div>

                    <!-- FORM -->

                    <form action="${pageContext.request.contextPath}/appointments/save"
                          method="post">

                        <!-- DATE -->

                        <div class="mb-3">

                            <label class="form-label fw-semibold">

                                Appointment Date

                            </label>

                            <input type="date"
                                   name="appointmentDate"
                                   class="form-control"
                                   required>

                        </div>

                        <!-- TIME -->

                        <div class="mb-3">

                            <label class="form-label fw-semibold">

                                Appointment Time

                            </label>

                            <input type="time"
                                   name="appointmentTime"
                                   class="form-control"
                                   required>

                        </div>

                        <!-- REASON -->

                        <div class="mb-3">

                            <label class="form-label fw-semibold">

                                Reason

                            </label>

                            <textarea name="reason"
                                      class="form-control"
                                      rows="4"
                                      placeholder="Enter appointment reason"
                                      required></textarea>

                        </div>


                        <select name="doctorId"
                                class="form-select"
                                required>

                            <option value="">

                                Select Doctor

                            </option>

                            <c:forEach items="${doctors}"
                                       var="doctor">

                                <option value="${doctor.id}">

                                    Dr. ${doctor.name}

                                </option>

                            </c:forEach>

                        </select>

                        <!-- BUTTON -->

                        <button type="submit"
                                class="btn btn-primary w-100 py-2">

                            Book Appointment

                        </button>

                    </form>

                    <!-- NAVIGATION BUTTONS -->

                    <div class="d-flex justify-content-between mt-4">

                        <a href="${pageContext.request.contextPath}/patient/dashboard"
                           class="btn btn-outline-primary">

                            Back to Dashboard

                        </a>

                        <a href="${pageContext.request.contextPath}/"
                           class="btn btn-dark">

                            Home

                        </a>

                    </div>

                </div>

            </div>

        </div>

    </div>

</div>

</body>

</html>