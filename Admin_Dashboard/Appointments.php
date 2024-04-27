<?php
session_start();

include "./Connect.php";

$A_ID = $_SESSION['A_Log'];

function convertToAMPM($timeString)
{
    $time = DateTime::createFromFormat('H:i:s', $timeString);
    return $time->format('g:i A');
}

if (!$A_ID) {

    echo '<script language="JavaScript">
     document.location="./Adminlogin.php";
    </script>';

}

if (isset($_POST['Submit'])) {

    $appointment_id = $_POST['appointment_id'];
    $review = $_POST['review'];

    $stmt = $con->prepare("INSERT INTO appointments_reviews (appointment_id, review) VALUES (?, ?)");

    $stmt->bind_param("is", $appointment_id, $review);

    if ($stmt->execute()) {

        echo "<script language='JavaScript'>
    alert ('Review Has Been Added Successfully !');
</script>";

        echo "<script language='JavaScript'>
document.location='./Appointments.php';
 </script>";

    }
}
?>


<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />

    <title>Appointments - Child Safety</title>
    <meta content="" name="description" />
    <meta content="" name="keywords" />

    <!-- Favicons -->
    <link href="assets/img/Logo.jpg" rel="icon" />
    <link href="assets/img/Logo.jpg" rel="apple-touch-icon" />

    <!-- Google Fonts -->
    <link href="https://fonts.gstatic.com" rel="preconnect" />
    <link
      href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
      rel="stylesheet"
    />

    <!-- Vendor CSS Files -->
    <link
      href="assets/vendor/bootstrap/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link
      href="assets/vendor/bootstrap-icons/bootstrap-icons.css"
      rel="stylesheet"
    />
    <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet" />
    <link href="assets/vendor/quill/quill.snow.css" rel="stylesheet" />
    <link href="assets/vendor/quill/quill.bubble.css" rel="stylesheet" />
    <link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet" />
    <link href="assets/vendor/simple-datatables/style.css" rel="stylesheet" />

    <!-- Template Main CSS File -->
    <link href="assets/css/style.css" rel="stylesheet" />
  </head>

  <body>
    <!-- ======= Header ======= -->
    <header id="header" class="header fixed-top d-flex align-items-center">
      <div class="d-flex align-items-center justify-content-between">
        <a href="index.html" class="logo d-flex align-items-center">
          <img src="assets/img/Logo.jpg" alt="" />

        </a>
      </div>
      <!-- End Logo -->
      <!-- End Search Bar -->

      <nav class="header-nav ms-auto">
        <ul class="d-flex align-items-center">
          <li class="nav-item dropdown pe-3">
            <a
              class="nav-link nav-profile d-flex align-items-center pe-0"
              href="#"
              data-bs-toggle="dropdown"
            >
              <img
                src="https://www.computerhope.com/jargon/g/guest-user.png"
                alt="Profile"
                class="rounded-circle"
              />
              <span class="d-none d-md-block ps-2"><?php echo $name ?></span> </a
            ><!-- End Profile Iamge Icon -->
          </li>
          <!-- End Profile Nav -->
        </ul>
      </nav>
      <!-- End Icons Navigation -->
    </header>
    <!-- End Header -->

    <!-- ======= Sidebar ======= -->
    <?php require './Aside-Nav/Aside.php'?>
    <!-- End Sidebar-->

    <main id="main" class="main">
      <div class="pagetitle">
        <h1>Appointments</h1>
        <nav>
          <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="index.html">Dashboard</a></li>
            <li class="breadcrumb-item">Appointments</li>
          </ol>
        </nav>
      </div>
      <!-- End Page Title -->
      <section class="section">



      <div class="modal fade" id="verticalycentered" tabindex="-1">
          <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title">Appointement Review</h5>
                <button
                  type="button"
                  class="btn-close"
                  data-bs-dismiss="modal"
                  aria-label="Close"
                ></button>
              </div>
              <div class="modal-body">

                <form method="POST" action="./Appointments.php" enctype="multipart/form-data">

                <input id="appointement-id-input" type="hidden" name="appointment_id" value="">

                  <div class="row mb-3">
                    <label for="inputText" class="col-sm-4 col-form-label"
                      >Review</label
                    >
                    <div class="col-sm-8">
                      <textarea class="form-control" name="review"></textarea>
                    </div>
                  </div>




                  <div class="row mb-3">
                    <div class="text-end">
                      <button type="submit" name="Submit" class="btn btn-primary">
                        Submit Form
                      </button>
                    </div>
                  </div>

                </form>

              </div>
              <div class="modal-footer">
                <button
                  type="button"
                  class="btn btn-secondary"
                  data-bs-dismiss="modal"
                >
                  Close
                </button>
              </div>
            </div>
          </div>
        </div>




        <div class="row">
          <div class="col-lg-12">
            <div class="card">
              <div class="card-body">
                <!-- Table with stripped rows -->
                <table class="table datatable">
                  <thead>
                    <tr>
                      <th scope="col">ID</th>
                      <th scope="col">Client Name</th>
                      <th scope="col">Doctor Name</th>
                      <th scope="col">Service Name</th>
                      <th scope="col">Date Time</th>
                      <th scope="col">Status</th>
                      <th scope="col">Actions</th>
                    </tr>
                  </thead>
                  <tbody>
<?php
$sql1 = mysqli_query($con, "SELECT * from appointments ORDER BY id DESC");

while ($row1 = mysqli_fetch_array($sql1)) {

    $appointment_id = $row1['id'];
    $status = $row1['status'];
    $service_id = $row1['service_id'];
    $client_id = $row1['client_id'];
    $doctor_id = $row1['doctor_id'];
    $date_id = $row1['date_id'];

    $sql2 = mysqli_query($con, "SELECT * from services WHERE id = '$service_id'");
    $row2 = mysqli_fetch_array($sql2);

    $service_name = $row2['name'];

    $sql3 = mysqli_query($con, "SELECT * from users WHERE id = '$client_id'");
    $row3 = mysqli_fetch_array($sql3);

    $client_name = $row3['name'];

    $sql4 = mysqli_query($con, "SELECT * from users WHERE id = '$doctor_id'");
    $row4 = mysqli_fetch_array($sql4);

    $doctor_name = $row4['name'];

    $sql5 = mysqli_query($con, "SELECT * from services_dates WHERE id = '$date_id'");
    $row5 = mysqli_fetch_array($sql5);

    $from_time = $row5['from_time'];
    $to_time = $row5['to_time'];
    $date = $row5['date'];

    ?>
                    <tr>
                      <th scope="row"><?php echo $appointment_id ?></th>
                      <td><?php echo $client_name ?></td>
                      <td><?php echo $doctor_name ?></td>
                      <td><?php echo $service_name ?></td>
                      <td><?php echo $date ?> <?php echo $from_time ?> - <?php echo $to_time ?></td>
                      <td><?php echo $status ?> </td>



                      <td>

                          <?php if ($status == 'PENDING') {?>

                            <a href="./AcceptOrRejectAppointment.php?appointment_id=<?php echo $appointment_id ?>&&status=<?php echo 'ACCEPTED' ?>" class="btn btn-primary">Accept</a>

                            <a href="./AcceptOrRejectAppointment.php?appointment_id=<?php echo $appointment_id ?>&&status=<?php echo 'REJECTED' ?>" class="btn btn-danger">Reject</a>

                            <?php } else {?>

                              <button onclick="btnClicked(event)" data-bs-toggle="modal" data-bs-target="#verticalycentered" class="btn btn-primary review-btn" id="btn-<?php echo $appointment_id ?>">Add Review</button>
                              <?php }?>

                              <a href="./Appointement-Review.php?appointment_id=<?php echo $appointment_id ?>" class="btn btn-primary">View Review</a>

                      </td>
                    </tr>
<?php }?>
                  </tbody>
                </table>
                <!-- End Table with stripped rows -->
              </div>
            </div>
          </div>
        </div>
      </section>
    </main>
    <!-- End #main -->

    <!-- ======= Footer ======= -->
    <footer id="footer" class="footer">
      <div class="copyright">
        &copy; Copyright <strong><span>Child Saftey</span></strong
        >. All Rights Reserved
      </div>
    </footer>
    <!-- End Footer -->

    <a
      href="#"
      class="back-to-top d-flex align-items-center justify-content-center"
      ><i class="bi bi-arrow-up-short"></i
    ></a>

    <script>
    window.addEventListener('DOMContentLoaded', (event) => {
     document.querySelector('#sidebar-nav .nav-item:nth-child(7) .nav-link').classList.remove('collapsed')
   });
</script>

    <!-- Vendor JS Files -->
    <script src="assets/vendor/apexcharts/apexcharts.min.js"></script>
    <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="assets/vendor/chart.js/chart.umd.js"></script>
    <script src="assets/vendor/echarts/echarts.min.js"></script>
    <script src="assets/vendor/quill/quill.min.js"></script>
    <script src="assets/vendor/simple-datatables/simple-datatables.js"></script>
    <script src="assets/vendor/tinymce/tinymce.min.js"></script>
    <script src="assets/vendor/php-email-form/validate.js"></script>

    <!-- Template Main JS File -->
    <script src="assets/js/main.js"></script>

    <script>
      let hiddenInput = document.getElementById('appointement-id-input')
      // let button = document.getElementsByClassName('review-btn')


      const btnClicked = (e) => {
        const id = e.target.id.split('-')[1]
        hiddenInput.value = id
      }

    </script>
  </body>
</html>