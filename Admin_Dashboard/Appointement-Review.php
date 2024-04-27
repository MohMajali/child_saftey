<?php
session_start();

include "./Connect.php";

$A_ID = $_SESSION['A_Log'];
$appointment_id = $_GET['appointment_id'];

if (!$A_ID) {

    echo '<script language="JavaScript">
     document.location="./Adminlogin.php";
    </script>';

} else {

    $sql1 = mysqli_query($con, "select * from users where id='$A_ID'");
    $row1 = mysqli_fetch_array($sql1);

    $name = $row1['name'];
    $email = $row1['email'];

    $sql2 = mysqli_query($con, "select * from appointments where id='$appointment_id'");
    $row2 = mysqli_fetch_array($sql2);

    $service_id = $row2['service_id'];
    $client_id = $row2['client_id'];
    $doctor_id = $row2['doctor_id'];
    $date_id = $row2['date_id'];

    $sql3 = mysqli_query($con, "select * from services where id='$service_id'");
    $row3 = mysqli_fetch_array($sql3);

    $service_name = $row3['name'];

    $sql4 = mysqli_query($con, "select * from users where id='$client_id'");
    $row4 = mysqli_fetch_array($sql4);

    $client_name = $row4['name'];

    $sql5 = mysqli_query($con, "select * from users where id='$doctor_id'");
    $row5 = mysqli_fetch_array($sql5);

    $doctor_name = $row5['name'];

    $sql5 = mysqli_query($con, "select * from services_dates where id='$date_id'");
    $row5 = mysqli_fetch_array($sql5);

    $from_time = $row5['from_time'];
    $to_time = $row5['to_time'];
    $date = $row5['date'];

    $sql6 = mysqli_query($con, "select * from appointments_reviews where appointment_id='$appointment_id'");
    $row6 = mysqli_fetch_array($sql6);

    $review = $row6['review'];

}

?>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />

    <title>Clink - Child Saftey</title>
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
        <h1>Appointement Review</h1>
        <nav>
          <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="index.html">Dashboard</a></li>
            <li class="breadcrumb-item">Appointement Review</li>
          </ol>
        </nav>
      </div>
      <!-- End Page Title -->
      <section class="section">
        <div class="row">
          <div class="col-lg-12">
            <div class="card">
              <div class="card-body">
                <h5 class="card-title"></h5>

                <!-- Horizontal Form -->
                <form method="POST" action="" enctype="multipart/form-data">

                  <div class="row mb-3">
                    <label for="inputEmail3" class="col-sm-2 col-form-label"
                      >Client Name</label
                    >
                    <div class="col-sm-10">
                      <input type="text" name="name" value="<?php echo $client_name ?>" class="form-control" id="inputText" disabled/>
                    </div>
                  </div>

                  <div class="row mb-3">
                    <label for="inputEmail3" class="col-sm-2 col-form-label"
                      >Doctor Name</label
                    >
                    <div class="col-sm-10">
                      <input type="text" name="phone" value="<?php echo $doctor_name ?>" class="form-control" id="inputText" disabled/>
                    </div>
                  </div>

                  <div class="row mb-3">
                    <label for="inputEmail3" class="col-sm-2 col-form-label"
                      >Review </label
                    >
                    <div class="col-sm-10">
                      <textarea class="form-control" name="description" id="" disabled><?php echo $review ?></textarea>
                    </div>
                  </div>

                </form>
                <!-- End Horizontal Form -->
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
  </body>
</html>
