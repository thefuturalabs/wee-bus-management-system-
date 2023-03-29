<?php

include '../connection.php';


$sql = mysqli_query($con, "SELECT * FROM feedback join user on feedback.user_id = user.login_id");
$list = array();

if ($sql->num_rows > 0) {

  while ($row = mysqli_fetch_assoc($sql)) {

    $myarray['feedback'] = $row['feedback'];
    $myarray['name'] = $row['name'];
  
    array_push($list, $myarray);
   
  }
} else {

  $myarray['message'] = 'Failed to View';

  array_push($list, $myarray);
  
}
echo json_encode($list);
