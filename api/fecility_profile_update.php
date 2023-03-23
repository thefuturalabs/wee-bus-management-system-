<?php
include '../connection.php';

$fecility_id=$_POST['fecility_id'];

$name = $_POST['name'];
$email = $_POST['email'];
$phn_no = $_POST['phn_no'];
$location = $_POST['location'];
// $type = $_POST['type'];


$query1=mysqli_query($con,"UPDATE `fecility` SET `name`='$name',`email`='$email',`mobile`='$phn_no',`location`='$location' WHERE login_id='$fecility_id'");



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