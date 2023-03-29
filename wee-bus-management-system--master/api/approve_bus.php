<?php
include '../connection.php';

$bus_id = $_POST['bus_id'];


$sql = mysqli_query($con, "UPDATE bus SET status='1' where bus_id = '$bus_id'");


if ($sql) {

    $myarray['result'] = "approved";
} else {
    $myarray['message'] = 'Failed';
}
echo json_encode($myarray);
