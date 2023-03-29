<?php
include '../connection.php';
$user_id = $_POST['user_id'];
$feedback = $_POST['feedback'];

    $sql = mysqli_query($con,"insert into feedback(user_id,feedback)values('$user_id','$feedback')");
   

    if ($sql) {

        $myarray['result'] = "done";

    } else {
        $myarray['message'] = 'Failed to Add';
    }
    echo json_encode($myarray);
