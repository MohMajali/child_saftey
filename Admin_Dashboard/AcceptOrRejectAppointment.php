<?php

include "./Connect.php";
$status = $_GET['status'];
$appointment_id = $_GET['appointment_id'];

$stmt = $con->prepare("UPDATE appointments SET status = ? WHERE id = ? ");

$stmt->bind_param("si", $status, $appointment_id);

if ($stmt->execute()) {

    if ($status == 'ACCEPTED') {

        echo "<script language='JavaScript'>
        alert ('Appointment Has Been Accepted Successfully !');
        </script>";

        echo "<script language='JavaScript'>
        document.location='./Appointments.php';
        </script>";

    } else {
        echo "<script language='JavaScript'>
alert ('Appointment Has Been REJECTED Successfully !');
</script>";

        echo "<script language='JavaScript'>
document.location='./Appointments.php';
</script>";
    }

}
