<?php
include '../connection.php';
$name = $_POST['name'];
$email = $_POST['email'];
$mobile = $_POST['mobile'];
$place = $_POST['place'];
$username = $_POST['username'];
$password = $_POST['password'];

    

    $query = mysqli_query($con, "INSERT INTO login(`username`,`password`,`type`) VALUES('$username','$password','user')");
    $last_login_id = mysqli_insert_id($con);
    $sql = mysqli_query($con,"insert into user(login_id,name,email,mobile,place)values('$last_login_id','$name','$email','$mobile','$place')");
    $a = mysqli_query($con,"select * from user where login_id = '$last_login_id'");
    $a1 = mysqli_fetch_assoc($a);
    $list = array();

    if ($sql) {

        $myarray['result'] = "done";
        $myarray['user_id'] = $a1['login_id'];

    } else {
        $myarray['message'] = 'Failed to Add';
    }
    echo json_encode($myarray);
