<?php

include "./Connect.php";
$isActive = $_GET['isActive'];
$doctor_id = $_GET['doctor_id'];

$stmt = $con->prepare("UPDATE users SET active = ? WHERE id = ? ");

$stmt->bind_param("ii", $isActive, $doctor_id);

if ($stmt->execute()) {

    if ($isActive == 0) {

        echo "<script language='JavaScript'>
        alert ('Doctor Has Been Deleted Successfully !');
        </script>";

        echo "<script language='JavaScript'>
        document.location='./Doctors.php';
        </script>";

    } else {
        echo "<script language='JavaScript'>
alert ('Doctor Has Been Restored Successfully !');
</script>";

        echo "<script language='JavaScript'>
document.location='./Doctors.php';
</script>";
    }

}
