<?php
include '../connection.php';

$driver_id = $_POST['driver_id'];





$sql = mysqli_query($con, "DELETE FROM driver where login_id = '$driver_id'");
$list = array();

if ($sql) {

    $myarray['result'] = "done";
} else {
    $myarray['message'] = 'Failed';
}
echo json_encode($myarray);
