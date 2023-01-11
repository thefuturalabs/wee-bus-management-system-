<?php
include '../connection.php';

$bus_id = $_POST['bus_id'];





$sql = mysqli_query($con, "DELETE FROM bus where bus_id = '$bus_id'");
$list = array();

if ($sql) {

    $myarray['result'] = "done";
} else {
    $myarray['message'] = 'Failed';
}
echo json_encode($myarray);
