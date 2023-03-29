<?php
include '../connection.php';

$rto_id=$_POST['rto_id'];

$name = $_POST['name'];
$email = $_POST['email'];
$phn_no = $_POST['phn_no'];



$query1=mysqli_query($con,"UPDATE `rto` SET `name`='$name',`email`='$email',`mobile`='$phn_no' WHERE login_id='$rto_id'");



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