<?php
session_start();

include "./Connect.php";

$A_ID = $_SESSION['A_Log'];
$chat_id = $_GET['chat_id'];
$patient_id = $_GET['patient_id'];

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
?>


<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />

    <title>Appointments - Chats</title>
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
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">

    <!-- Template Main CSS File -->
    <link href="assets/css/style.css" rel="stylesheet" />
    <link href="assets/css/chat_style.css" rel="stylesheet" />
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
        <h1>Chats</h1>
        <nav>
          <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="index.html">Dashboard</a></li>
            <li class="breadcrumb-item">Chats</li>
          </ol>
        </nav>
      </div>
      <!-- End Page Title -->
      <section class="section">


        <div class="row">
          <div class="col-lg-12">
            <div class="card">
              <div class="card-body">
                <!-- Table with stripped rows -->


                <section class="gradient-custom">
  <div class="container py-5">

    <div class="row">


      <div class="col-md-12 col-lg-12 col-xl-12">

        <ul class="list-unstyled text-white">

        <?php
$sql1 = mysqli_query($con, "SELECT * from chat_messages WHERE conversation_id = '$chat_id'");

while ($row1 = mysqli_fetch_array($sql1)) {

    $chats_id = $row1['id'];
    $sender_id = $row1['sender_id'];
    $reciver_id = $row1['reciver_id'];
    $message = $row1['message'];

    $sql2 = mysqli_query($con, "SELECT * from users WHERE id = '$sender_id'");
    $row2 = mysqli_fetch_array($sql2);

    $client_name = $row2['name'];

    ?>

    <?php if ($A_ID != $sender_id) {?>
        <li class="d-flex justify-content-between mb-4">
            <img src="https://www.computerhope.com/jargon/g/guest-user.png" alt="avatar"
              class="rounded-circle d-flex align-self-start me-3 shadow-1-strong" width="60">
            <div class="card mask-custom">
              <div class="card-header d-flex justify-content-between p-3"
                style="border-bottom: 1px solid rgba(255,255,255,.3);">
                <p class="fw-bold mb-0"><?php echo $client_name ?></p>
                <p class="text-light small mb-0"><i class="far fa-clock"></i> 12 mins ago</p>
              </div>
              <div class="card-body">
                <p class="mb-0">
                <?php echo $message ?>
                </p>
              </div>
            </div>
          </li>

        <?php } else {?>
            <li class="d-flex justify-content-between mb-4">
            <div class="card mask-custom w-100">
              <div class="card-header d-flex justify-content-between p-3"
                style="border-bottom: 1px solid rgba(255,255,255,.3);">
                <p class="fw-bold mb-0">Admin</p>
                <p class="text-light small mb-0"><i class="far fa-clock"></i> 13 mins ago</p>
              </div>
              <div class="card-body">
                <p class="mb-0">
                <?php echo $message ?>
                </p>
              </div>
            </div>
            <img src="https://www.computerhope.com/jargon/g/guest-user.png" alt="avatar"
              class="rounded-circle d-flex align-self-start ms-3 shadow-1-strong" width="60">
          </li>

        <?php }?>



          <?php }?>

          <li class="mb-3">
            <div class="form-outline form-white">
              <textarea onkeyup="getText(event)" id="textarea" class="form-control" id="textAreaExample3" rows="4"></textarea>
              <label class="form-label" for="textAreaExample3">Message</label>
            </div>
          </li>
          <button id="btn-<?php echo $chat_id ?>-<?php echo $patient_id ?>" type="button" class="btn btn-light btn-lg btn-rounded float-end" onclick="onSubmit(event)">Send</button>
        </ul>

      </div>

    </div>

  </div>
</section>
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
     document.querySelector('#sidebar-nav .nav-item:nth-child(8) .nav-link').classList.remove('collapsed')
   });
</script>

    <!-- Vendor JS Files -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
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

      let val = ''
      const getText = (e) => {
        val = e.target.value
      }

      const onSubmit = (e) => {

        // console.log(val);
        let formData = new FormData()
        formData.append('reciver_id', e.target.id.split('-')[2])
        formData.append('sender_id', 1)
        formData.append('message', val);

        $.ajax({
        type: 'POST',
        url: `http://localhost:8080/chats/${e.target.id.split('-')[1]}`,
        data: formData,
        processData: false,
        contentType: false,
      }).done(function(data){
        console.log("DATA ====> ",data);
      }).fail(function(err){
        console.error("ERR ===> ",err);
      })
      }


    </script>
  </body>
</html>
