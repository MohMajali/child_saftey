<?php

include "./Connect.php";
$isActive = $_GET['isActive'];
$service_id = $_GET['service_id'];

$stmt = $con->prepare("UPDATE services SET active = ? WHERE id = ? ");

$stmt->bind_param("ii", $isActive, $service_id);

if ($stmt->execute()) {

    if ($isActive == 0) {

        echo "<script language='JavaScript'>
        alert ('Service Has Been Deleted Successfully !');
        </script>";

        echo "<script language='JavaScript'>
        document.location='./Services.php';
        </script>";

    } else {
        echo "<script language='JavaScript'>
alert ('Service Has Been Restored Successfully !');
</script>";

        echo "<script language='JavaScript'>
document.location='./Services.php';
</script>";
    }

}
