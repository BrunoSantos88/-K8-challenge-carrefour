<?php

$DB_HOST = "mysql-connection";
$DB_USERNAME = "kubenews";
$password = "Pg#kubenews";
$DB_DATABASE = "kubenews";

// Criar conexão


$link = new mysqli($DB_HOST, $DB_USERNAME, $DB_PASSWORD, $DB_DATABASE);

/* check connection */
if (mysqli_connect_errno()) {
    printf("Connect failed: %s\n", mysqli_connect_error());
    exit();
}

?>
