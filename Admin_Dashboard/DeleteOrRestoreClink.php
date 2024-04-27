<?php

include "./Connect.php";
$isActive = $_GET['isActive'];
$clink_id = $_GET['clink_id'];

$stmt = $con->prepare("UPDATE clinks SET active = ? WHERE id = ? ");

$stmt->bind_param("ii", $isActive, $clink_id);

if ($stmt->execute()) {

    if ($isActive == 0) {

        echo "<script language='JavaScript'>
        alert ('Clink Has Been Deleted Successfully !');
        </script>";

        echo "<script language='JavaScript'>
        document.location='./Clinks.php';
        </script>";

    } else {
        echo "<script language='JavaScript'>
alert ('Clink Has Been Restored Successfully !');
</script>";

        echo "<script language='JavaScript'>
document.location='./Clinks.php';
</script>";
    }

}
