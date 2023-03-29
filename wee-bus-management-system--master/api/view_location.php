<?php

include '../connection.php';

$bus_id = $_POST['bus_id'];
$sql = mysqli_query($con, "SELECT * FROM location where bus_id = '$bus_id' ");

$list = array();

if ($sql->num_rows > 0) {

  while ($row = mysqli_fetch_assoc($sql)) {

    $myarray['bus_id'] = $row['bus_id'];
    $myarray['driver_id'] = $row['driver_id'];
    $myarray['location'] = $row['location'];
    $myarray['status'] = $row['status'];
   


   



    array_push($list, $myarray);
   
  }
} else {

  $myarray['message'] = 'Failed to View';

  array_push($list, $myarray);
  
}
echo json_encode($list);
