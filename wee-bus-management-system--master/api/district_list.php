<?php

include '../connection.php';


$sql = mysqli_query($con, "SELECT * FROM rto");
$list = array();

if ($sql->num_rows > 0) {

  while ($row = mysqli_fetch_assoc($sql)) {
    $myarray['rto_id'] = $row['login_id'];
    $myarray['district'] = $row['district'];
    


    array_push($list, $myarray);
   
  }
} else {

  $myarray['message'] = 'Failed';

  array_push($list, $myarray);
  
}
echo json_encode($list);
