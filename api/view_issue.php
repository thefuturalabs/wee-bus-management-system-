<?php

include '../connection.php';

$id = $_POST['bus_id'];

$sql = mysqli_query($con, "SELECT * FROM issue WHERE bus_id='$id'");
$list = array();

if ($sql->num_rows > 0) {

  while ($row = mysqli_fetch_assoc($sql)) {

    $myarray['bus_id'] = $row['bus_id'];
    $myarray['driver_id'] = $row['driver_id'];
    $myarray['issue'] = $row['issue'];
  
    array_push($list, $myarray);
   
  }
} else {

  $myarray['message'] = 'Failed to View';

  array_push($list, $myarray);
  
}
echo json_encode($list);
