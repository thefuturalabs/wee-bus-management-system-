<?php
include 'connection.php';
$id = $_GET['id'];
mysqli_query($con,"update fecility set status = '1' where fecility_id = '$id'");
header("location:view_authority.php");
?>