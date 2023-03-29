<?php
include '../connection.php';
$driver_id = $_POST['driver_id'];
$bus_id = $_POST['bus_id'];
$issue = $_POST['issue'];

    $sql = mysqli_query($con,"insert into issue(driver_id,bus_id,issue)values('$driver_id','$bus_id','$issue')");
   

    if ($sql) {

        $myarray['result'] = "done";

    } else {
        $myarray['message'] = 'Failed to Add';
    }
    echo json_encode($myarray);
