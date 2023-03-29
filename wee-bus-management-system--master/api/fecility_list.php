<?php

include '../connection.php';

$sql = mysqli_query($con, "SELECT * FROM fecility ");
$list = array();

if ($sql->num_rows > 0) {

  while ($row = mysqli_fetch_assoc($sql)) {

    $myarray['fecility_id'] = $row['fecility_id'];
    $myarray['name'] = $row['name'];
    $myarray['email'] = $row['email'];
    $myarray['location'] = $row['location'];
    $myarray['mobile'] = $row['mobile'];
    $myarray['image'] = $row['image'];
    $myarray['type'] = $row['type'];
    $myarray['status'] = $row['status'];



    array_push($list, $myarray);
   
  }
} else {

  $myarray['message'] = 'Failed to View';

  array_push($list, $myarray);
  
}
echo json_encode($list);
