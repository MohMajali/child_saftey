<?php

include "./Connect.php";
$isActive = $_GET['isActive'];
$location_id = $_GET['location_id'];

$stmt = $con->prepare("UPDATE locations SET active = ? WHERE id = ? ");

$stmt->bind_param("ii", $isActive, $location_id);

if ($stmt->execute()) {

    if ($isActive == 0) {

        echo "<script language='JavaScript'>
        alert ('Location Has Been Deleted Successfully !');
        </script>";

        echo "<script language='JavaScript'>
        document.location='./Locations.php';
        </script>";

    } else {
        echo "<script language='JavaScript'>
alert ('Location Has Been Restored Successfully !');
</script>";

        echo "<script language='JavaScript'>
document.location='./Locations.php';
</script>";
    }

}
