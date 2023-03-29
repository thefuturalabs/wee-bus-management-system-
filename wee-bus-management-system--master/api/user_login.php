<?php

include '../connection.php';

$username = $_POST['username'];
$password = $_POST['password'];
$sql = mysqli_query($con, "SELECT * FROM login join user on user.login_id=login.login_id  WHERE username='$username' AND password='$password' ");


if ($sql->num_rows > 0) {

  while ($row = mysqli_fetch_assoc($sql)) {


    $myarray['message'] = 'User Successfully LoggedIn';

    $myarray['user_id'] = $row['login_id'];

    $myarray['type'] = $row['type'];
  }
} else {

  $myarray['message'] = 'Failed to LogIn';
}
echo json_encode($myarray);
