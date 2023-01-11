<?php
include 'connection.php';
$id = $_GET['id'];
mysqli_query($con,"delete from notification where notification_id = '$id'");
header("location: notification.php");
?>