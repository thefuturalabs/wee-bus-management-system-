<?php
include '../connection.php';

$rto_id = $_POST['rto_id'];
$data = mysqli_query($con,"select * from rto where login_id = '$rto_id' ");
$row = mysqli_fetch_assoc($data);

$myarray['name'] = $row['name'];
$myarray['email'] = $row['email'];
$myarray['mobile'] = $row['mobile'];
$myarray['proof'] = $row['proof'];

echo json_encode($myarray);
?>