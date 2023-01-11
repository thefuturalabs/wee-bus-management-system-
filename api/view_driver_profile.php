<?php
include '../connection.php';

$driver_id = $_POST['driver_id'];
$data = mysqli_query($con,"select * from driver where login_id = '$driver_id' ");
$row = mysqli_fetch_assoc($data);

$myarray['name'] = $row['name'];
$myarray['district'] = $row['district'];
$myarray['mobile'] = $row['mobile'];


echo json_encode($myarray);
?>