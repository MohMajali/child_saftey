<?php
session_start();

include "./Connect.php";

$A_ID = $_SESSION['A_Log'];
$clink_id = $_GET['clink_id'];

if (!$A_ID) {

    echo '<script language="JavaScript">
     document.location="./Adminlogin.php";
    </script>';

} else {

    $sql1 = mysqli_query($con, "select * from users where id='$A_ID'");
    $row1 = mysqli_fetch_array($sql1);

    $name = $row1['name'];
    $email = $row1['email'];

    $sql2 = mysqli_query($con, "select * from clinks where id='$clink_id'");
    $row2 = mysqli_fetch_array($sql2);

    $clink_name = $row2['name'];
    $clink_phone = $row2['phone'];
    $clink_description = $row2['description'];
    $clink_location_id = $row2['location_id'];

    $sql3 = mysqli_query($con, "select * from locations where id='$clink_location_id'");
    $row3 = mysqli_fetch_array($sql3);

    $location_name = $row3['name'];

    if (isset($_POST['Submit'])) {

        $clink_id = $_POST['clink_id'];
        $location_id = $_POST['location_id'];
        $name = $_POST['name'];
        $phone = $_POST['phone'];
        $description = $_POST['description'];
        $image;
        $image = $_FILES["file"]["name"];

        if ($image) {

            $image = 'images/' . $image;
            $stmt = $con->prepare("UPDATE clinks SET location_id = ?, name = ?, phone = ?, description = ?, image = ? WHERE id = ? ");
            $stmt->bind_param("issssi", $location_id, $name, $phone, $description, $image, $clink_id);

            if ($stmt->execute()) {

                move_uploaded_file($_FILES["file"]["tmp_name"], "../Database/images/" . $_FILES["file"]["name"]);

                echo "<script language='JavaScript'>
                  alert ('Clink Has Been Updated Successfully !');
             </script>";

                echo "<script language='JavaScript'>
            document.location='./Clinks.php';
               </script>";

            }
        } else {

            $stmt = $con->prepare("UPDATE clinks SET location_id = ?, name = ?, phone = ?, description = ? WHERE id = ? ");
            $stmt->bind_param("isssi", $location_id, $name, $phone, $description, $clink_id);

            if ($stmt->execute()) {

                echo "<script language='JavaScript'>
                  alert ('Clink Has Been Updated Successfully !');
             </script>";

                echo "<script language='JavaScript'>
            document.location='./Clinks.php';
               </script>";

            }

        }

    }
}

?>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />

    <title>Clink - Child Safety</title>
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
        <h1>Clink</h1>
        <nav>
          <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="index.html">Dashboard</a></li>
            <li class="breadcrumb-item">Clink</li>
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
                <form method="POST" action="./Edit-Clink.php?clink_id=<?php echo $clink_id ?>" enctype="multipart/form-data">

                <input type="hidden" name="clink_id" value="<?php echo $clink_id ?>">

                  <div class="row mb-3">
                    <label for="inputEmail3" class="col-sm-2 col-form-label"
                      >Image</label
                    >
                    <div class="col-sm-10">
                      <input type="file" name="file" class="form-control" id="inputText" />
                    </div>
                  </div>

                  <div class="row mb-3">
                    <label for="inputEmail3" class="col-sm-2 col-form-label"
                      >Location</label
                    >
                    <div class="col-sm-10">
                      <select class="form-select" name="location_id" id="">
                        <option value="<?php echo $location_id ?>" selected><?php echo $location_name ?></option>

                        <?php

$sql1 = mysqli_query($con, "SELECT * from locations WHERE active = 1 ORDER BY id DESC");

while ($row1 = mysqli_fetch_array($sql1)) {
    $location_id = $row1['id'];
    $location_name = $row1['name'];
    ?>
                                                <option value="<?php echo $location_id ?>"><?php echo $location_name ?></option>

                                                <?php }?>



                      </select>
                    </div>
                  </div>

                  <div class="row mb-3">
                    <label for="inputEmail3" class="col-sm-2 col-form-label"
                      >Name</label
                    >
                    <div class="col-sm-10">
                      <input type="text" name="name" value="<?php echo $clink_name ?>" class="form-control" id="inputText" />
                    </div>
                  </div>

                  <div class="row mb-3">
                    <label for="inputEmail3" class="col-sm-2 col-form-label"
                      >Phone</label
                    >
                    <div class="col-sm-10">
                      <input type="text" name="phone" value="<?php echo $clink_phone ?>" class="form-control" id="inputText" />
                    </div>
                  </div>

                  <div class="row mb-3">
                    <label for="inputEmail3" class="col-sm-2 col-form-label"
                      >Description</label
                    >
                    <div class="col-sm-10">
                      <textarea class="form-control" name="description" id=""><?php echo $clink_description ?></textarea>
                    </div>
                  </div>

                  <div class="text-end">
                    <button type="submit" name="Submit" class="btn btn-primary">
                      Submit
                    </button>
                    <button type="reset" class="btn btn-secondary">
                      Reset
                    </button>
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
     document.querySelector('#sidebar-nav .nav-item:nth-child(4) .nav-link').classList.remove('collapsed')
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
