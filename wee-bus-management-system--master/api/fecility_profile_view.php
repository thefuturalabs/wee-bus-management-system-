<?php
include '../connection.php';

$fecility_id = $_POST['fecility_id'];
$data = mysqli_query($con,"select * from fecility where login_id = '$fecility_id' ");
$row = mysqli_fetch_assoc($data);

$myarray['name'] = $row['name'];
$myarray['email'] = $row['email'];
$myarray['mobile'] = $row['mobile'];
$myarray['location'] = $row['location'];
$myarray['type'] = $row['type'];
$myarray['status'] = $row['status'];
echo json_encode($myarray);
?>