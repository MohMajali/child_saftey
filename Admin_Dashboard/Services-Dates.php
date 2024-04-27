<?php
session_start();

include "./Connect.php";

$A_ID = $_SESSION['A_Log'];
if (!$A_ID) {

    echo '<script language="JavaScript">
     document.location="./Adminlogin.php";
    </script>';

} else {

    $sql1 = mysqli_query($con, "select * from users where id='$A_ID'");
    $row1 = mysqli_fetch_array($sql1);

    $name = $row1['name'];
    $email = $row1['email'];

    if (isset($_POST['Submit'])) {

        $from_time = $_POST['from_time'];
        $to_time = $_POST['to_time'];
        $date = $_POST['date'];
        $service_id = $_POST['service_id'];

        $stmt = $con->prepare("INSERT INTO services_dates (from_time, to_time, date, service_id)
            VALUES (?, ?, ?, ?)");

        $stmt->bind_param("sssi", $from_time, $to_time, $date, $service_id);

        if ($stmt->execute()) {

            echo "<script language='JavaScript'>
              alert ('A New Date Has Been Added Successfully !');
         </script>";

            echo "<script language='JavaScript'>
        document.location='./Services-Dates.php';
           </script>";

        }

    }
}

?>


<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />

    <title>Services Dates - Child Safety</title>
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
        <h1>Services Dates</h1>
        <nav>
          <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="index.html">Dashboard</a></li>
            <li class="breadcrumb-item">Services Dates</li>
          </ol>
        </nav>
      </div>
      <!-- End Page Title -->
      <section class="section">
        <div class="mb-3">
          <button
            type="button"
            class="btn btn-primary"
            data-bs-toggle="modal"
            data-bs-target="#verticalycentered"
          >
            Add New Service Date
          </button>
        </div>

        <div class="modal fade" id="verticalycentered" tabindex="-1">
          <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title">Service Date Information</h5>
                <button
                  type="button"
                  class="btn-close"
                  data-bs-dismiss="modal"
                  aria-label="Close"
                ></button>
              </div>
              <div class="modal-body">

                <form method="POST" action="./Services-Dates.php" enctype="multipart/form-data">

                  <div class="row mb-3">
                    <label for="inputText" class="col-sm-4 col-form-label"
                      >Service</label
                    >
                    <div class="col-sm-8">
                      <select class="form-select" name="service_id" id="">
                        <?php

$sql1 = mysqli_query($con, "SELECT * from services WHERE active = 1 ORDER BY id DESC");

while ($row1 = mysqli_fetch_array($sql1)) {
    $service_id = $row1['id'];
    $service_name = $row1['name'];
    ?>
                        <option value="<?php echo $service_id ?>"><?php echo $service_name ?></option>

                        <?php }?>
                      </select>
                    </div>
                  </div>

                  <div class="row mb-3">
                    <label for="inputText" class="col-sm-4 col-form-label"
                      >Start Time</label
                    >
                    <div class="col-sm-8">
                      <input type="time" class="form-control" name="from_time" required/>
                    </div>
                  </div>

                  <div class="row mb-3">
                    <label for="inputText" class="col-sm-4 col-form-label"
                      >End Time</label
                    >
                    <div class="col-sm-8">
                      <input type="time" class="form-control" name="to_time" required/>
                    </div>
                  </div>

                  <div class="row mb-3">
                    <label for="inputText" class="col-sm-4 col-form-label"
                      >Date</label
                    >
                    <div class="col-sm-8">
                      <input type="date" min="<?php echo date('Y-m-d')?>" class="form-control" name="date" required/>
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
                      <th scope="col">Service Name</th>
                      <th scope="col">Start Time</th>
                      <th scope="col">End Time</th>
                      <th scope="col">Date</th>
                      <th scope="col">Actions</th>
                    </tr>
                  </thead>
                  <tbody>
<?php
$sql1 = mysqli_query($con, "SELECT * from services_dates ORDER BY id DESC");

while ($row1 = mysqli_fetch_array($sql1)) {

    $dateTime_id = $row1['id'];
    $service_id = $row1['service_id'];
    $from_time = $row1['from_time'];
    $to_time = $row1['to_time'];
    $date = $row1['date'];
    $active = $row1['active'];

    $sql2 = mysqli_query($con, "SELECT * from services WHERE id = '$service_id'");
    $row2 = mysqli_fetch_array($sql2);

    $service_name = $row2['name'];

    ?>
                    <tr>
                      <th scope="row"><?php echo $dateTime_id ?></th>
                      <td><?php echo $service_name ?></td>
                      <td><?php echo $from_time ?></td>
                      <td><?php echo $to_time ?></td>
                      <td><?php echo $date ?></td>



                      <td>

                          <?php if ($active == 1) {?>

                            <a href="./DeleteOrRestoreData.php?dateTime_id=<?php echo $dateTime_id ?>&&isActive=<?php echo 0 ?>" class="btn btn-danger">Delete</a>

                            <?php } else {?>

                              <a href="./DeleteOrRestoreData.php?dateTime_id=<?php echo $dateTime_id ?>&&isActive=<?php echo 1 ?>" class="btn btn-primary">Restore</a>

                          <?php }?>

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
     document.querySelector('#sidebar-nav .nav-item:nth-child(6) .nav-link').classList.remove('collapsed')
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
