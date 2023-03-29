<?php

include '../connection.php';

$driver_id = $_POST['driver_id'];
$sql = mysqli_query($con, "SELECT * FROM bus where driver_id = '$driver_id'");
$list = array();

if ($sql->num_rows > 0) {

  while ($row = mysqli_fetch_assoc($sql)) {
    $myarray['driver_id'] = $row['driver_id'];
    $myarray['bus_id'] = $row['bus_id'];
    $myarray['name'] = $row['name'];
    $myarray['number'] = $row['number'];
    $myarray['district'] = $row['district'];
    $myarray['from'] = $row['from'];
    $myarray['to'] = $row['to'];
    $myarray['status'] = $row['status'];
    


    array_push($list, $myarray);
   
  }
} else {

  $myarray['message'] = 'Failed';

  array_push($list, $myarray);
  
}
echo json_encode($list);
