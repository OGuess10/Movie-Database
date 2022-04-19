<?php

if(!session_start())
{
    //error check for if there no session 
    header("Location: error.php");
    exit;
}
else
{
    session_start();
}
//unset all session variables
$_SESSION = session_unset(); //

//destroy session
session_destroy();
//redirect oto login 

header("Location: Index.html");
exit;



?>