<?php

include '../connection.php';

$id = $_POST['driver_id'];

$sql = mysqli_query($con, "SELECT * FROM driver WHERE login_id='$id'");
$list = array();

if ($sql->num_rows > 0) {

  while ($row = mysqli_fetch_assoc($sql)) {

    $myarray['driver_id'] = $row['login_id'];
    $myarray['name'] = $row['name'];
    // $myarray['email'] = $row['email'];
    $myarray['mobile'] = $row['mobile'];
    $myarray['licence'] = $row['licence'];
    $myarray['status'] = $row['status'];

    array_push($list, $myarray);
   
  }
} else {

  $myarray['message'] = 'Failed to View';

  array_push($list, $myarray);
  
}
echo json_encode($list);
