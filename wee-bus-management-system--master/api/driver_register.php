<?php
include '../connection.php';
$name = $_POST['name'];
$mobile = $_POST['mobile'];
$district = $_POST['district'];
$username = $_POST['username'];
$password = $_POST['password'];
$pic = $_FILES['f1']['name'];

    if ($pic != "") {
        $filearray = pathinfo($_FILES['f1']['name']);

        $file1 = rand();
        $file_ext = $filearray["extension"];




        $filenew = $file1 . "." . $file_ext;
        move_uploaded_file($_FILES['f1']['tmp_name'], "../img/" . $filenew);
        // var_dump($filenew);exit();
    } 
    else {
        echo "<script>alert('Please try again...!')</script>";
    }

    

    $query = mysqli_query($con, "INSERT INTO login(`username`,`password`,`type`) VALUES('$username','$password','driver')");
    $last_login_id = mysqli_insert_id($con);
    $sql = mysqli_query($con,"insert into driver(login_id,name,mobile,district,licence)values('$last_login_id','$name','$mobile','$district','$filenew')");
    $a = mysqli_query($con,"select * from driver where login_id = '$last_login_id'");
    $a1 = mysqli_fetch_assoc($a);
    $list = array();

    if ($sql) {

        $myarray['result'] = "done";
        $myarray['driver_id'] = $a1['login_id'];

    } else {
        $myarray['message'] = 'Failed to Add';
    }
    echo json_encode($myarray);
