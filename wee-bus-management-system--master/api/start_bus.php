<?php
include '../connection.php';
$driver_id = $_POST['driver_id'];
$bus_id = $_POST['bus_id'];
$location = $_POST['location'];

   

    $sql = mysqli_query($con,"insert into location(driver_id,bus_id,location,status)values('$driver_id','$bus_id','$location','1')");
   

    if ($sql) {

        $myarray['result'] = "done";

    } else {
        $myarray['message'] = 'Failed to Add';
    }
    echo json_encode($myarray);
