<?php
include '../connection.php';

$driver_id = $_POST['driver_id'];


$sql = mysqli_query($con, "UPDATE driver SET status='1' where login_id = '$driver_id'");


if ($sql) {

    $myarray['result'] = "approved";
} else {
    $myarray['message'] = 'Failed';
}
echo json_encode($myarray);
