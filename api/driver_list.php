<?php

include '../connection.php';


$sql = mysqli_query($con, "SELECT * FROM driver");
$list = array();

if ($sql->num_rows > 0) {

  while ($row = mysqli_fetch_assoc($sql)) {
    $myarray['driver_id'] = $row['login_id'];
    $myarray['name'] = $row['name'];
    $myarray['mobile'] = $row['mobile'];
    $myarray['district'] = $row['district'];
    $myarray['licence'] = $row['licence'];
    $myarray['status'] = $row['status'];
    


    array_push($list, $myarray);
   
  }
} else {

  $myarray['message'] = 'Failed';

  array_push($list, $myarray);
  
}
echo json_encode($list);
