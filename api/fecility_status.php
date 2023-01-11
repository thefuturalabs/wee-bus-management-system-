<?php
include '../connection.php';

$fecility_id = $_POST['fecility_id'];


$sql = mysqli_query($con, "UPDATE fecility SET status='1' where login_id = '$fecility_id'");


if ($sql) {

    $myarray['result'] = "closed";
} else {
    $myarray['message'] = 'Failed to Add';
}
echo json_encode($myarray);
