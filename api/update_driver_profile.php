<?php
include '../connection.php';

$driver_id=$_POST['driver_id'];

$name = $_POST['name'];
$district = $_POST['district'];
$phn_no = $_POST['phn_no'];



$query1=mysqli_query($con,"UPDATE `driver` SET `name`='$name',`district`='$district',`mobile`='$phn_no' WHERE login_id='$driver_id'");



if($query1)
{
	$myarray['message'] = 'updated';
}

else
{

	$myarray['message'] = 'failed';
}
echo json_encode($myarray);

?>