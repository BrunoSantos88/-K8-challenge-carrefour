<?php

$servername = "mysql-connection";
$username = "kubenews";
$password = "Pg#kubenews";
$database = "kubenews";

// Criar conexão


$link = new mysqli($servername, $username, $password, $database);

/* check connection */
if (mysqli_connect_errno()) {
    printf("Connect failed: %s\n", mysqli_connect_error());
    exit();
}

?>
