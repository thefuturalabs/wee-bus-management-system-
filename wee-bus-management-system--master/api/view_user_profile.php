<?php
include '../connection.php';

$user_id = $_POST['user_id'];
$data = mysqli_query($con,"select * from user where login_id = '$user_id' ");
$row = mysqli_fetch_assoc($data);

$myarray['name'] = $row['name'];
$myarray['district'] = $row['place'];
$myarray['mobile'] = $row['mobile'];
$myarray['email'] = $row['email'];

echo json_encode($myarray);
?>