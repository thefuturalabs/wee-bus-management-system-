<?php
include 'connection.php';
$id = $_GET['id'];
mysqli_query($con,"update rto set status = '1' where rto_id = '$id'");
header("location:view_RTO.php");
?>