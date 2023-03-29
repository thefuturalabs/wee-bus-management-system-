<?php

include '../connection.php';

$id = $_POST['bus_id'];

$sql = mysqli_query($con, "SELECT * FROM bus WHERE bus_id='$id'");
$list = array();

if ($sql->num_rows > 0) {

  while ($row = mysqli_fetch_assoc($sql)) {

    $myarray['bus_id'] = $row['bus_id'];
    $myarray['driver_id'] = $row['driver_id'];
    $myarray['name'] = $row['name'];
    $myarray['number'] = $row['number'];
    $myarray['to'] = $row['to'];
    $myarray['from'] = $row['from'];
    $myarray['status'] = $row['status'];


    array_push($list, $myarray);
   
  }
} else {

  $myarray['message'] = 'Failed to View';

  array_push($list, $myarray);
  
}
echo json_encode($list);
