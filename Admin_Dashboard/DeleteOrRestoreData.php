<?php

include "./Connect.php";
$isActive = $_GET['isActive'];
$dateTime_id = $_GET['dateTime_id'];

$stmt = $con->prepare("UPDATE services_dates SET active = ? WHERE id = ? ");

$stmt->bind_param("ii", $isActive, $dateTime_id);

if ($stmt->execute()) {

    if ($isActive == 0) {

        echo "<script language='JavaScript'>
        alert ('Date Has Been Deleted Successfully !');
        </script>";

        echo "<script language='JavaScript'>
        document.location='./Services-Dates.php';
        </script>";

    } else {
        echo "<script language='JavaScript'>
alert ('Date Has Been Restored Successfully !');
</script>";

        echo "<script language='JavaScript'>
document.location='./Services-Dates.php';
</script>";
    }

}
