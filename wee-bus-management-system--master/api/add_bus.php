<?php
include '../connection.php';
$driver_id = $_POST['driver_id'];
$name = $_POST['name'];
$number = $_POST['number'];
$district = $_POST['district'];
$from = $_POST['from'];
$to = $_POST['to'];

   

    $sql = mysqli_query($con,"insert into bus(driver_id,name,number,district,`from`,`to`)values('$driver_id','$name','$number','$district','$from','$to')");
   

    if ($sql) {

        $myarray['result'] = "done";

    } else {
        $myarray['message'] = 'Failed to Add';
    }
    echo json_encode($myarray);
