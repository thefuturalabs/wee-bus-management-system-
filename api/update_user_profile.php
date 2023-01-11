<?php
include '../connection.php';

$user_id=$_POST['user_id'];

$name = $_POST['name'];
$district = $_POST['place'];
$phn_no = $_POST['mobile'];
$email = $_POST['email'];


$query1=mysqli_query($con,"UPDATE `user` SET `name`='$name',`place`='$district',`mobile`='$phn_no',`email`='$email' WHERE login_id='$user_id'");



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