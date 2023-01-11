<?php
include '../connection.php';
$name = $_POST['name'];
$email = $_POST['email'];
$mobile = $_POST['mobile'];
$location = $_POST['location'];
$type = $_POST['type'];
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



    

    $query = mysqli_query($con, "INSERT INTO login(`username`,`password`,`type`) VALUES('$username','$password','fecility')");
    $last_login_id = mysqli_insert_id($con);
    $sql = mysqli_query($con,"insert into fecility(login_id,name,email,mobile,location,type,image)values('$last_login_id','$name','$email','$mobile','$location','$type','$filenew')");
    $list = array();

    if ($sql) {

        $myarray['result'] = "done";
    } else {
        $myarray['message'] = 'Failed to Add';
    }
    echo json_encode($myarray);
