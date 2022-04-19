<?
//basically when the user hits the submit button for 
//using post to get variable data. assuming of course that 

//checks to see if $_POST is set 
//if it is NOT set variables userName and passWord are set to null
$userName = isset($_POST["username"]) ? $_POST["userName"] : null;
$passWord = isset($_POST["password"]) ? $_POST["password"] : null;
if(!session_start()) {
    // If the session couldn't start, present an error
    header("Location: error.php");
    exit;
}
else
{
    session_start();
}



if($userName && $passWord)
{
    //variable names are placeholders until we set up the actual server
    $server = "localhost";
    $DBusername = "UsernameForDB";
    $DBpassword = "PasswordForDB";
    $database = "DBName";

    $conn = new mysqli($server, $DBusername, $DBpassword, $database);

    if($conn->connect_error)
    {
        die("Connection failed: " . $conn->connect_error);
        echo '<a href = "createUser.html">Click to go back to sign in page</a>';
        //Note: this will essentially ask the user to go back to the sign in page if a connection error occurs
    }
    else
    {
        $sqlQuery = "SELECT userID, userName, user_password FROM Users where userName = '$userName'";
        $sqlReturn = $conn->query($sqlQuery);

        if($sqlReturn->num_rows > 0)//if query is successful
        {   
            $check = $sqlReturn->fetch_assoc();
            $checkpassword = $check["password"];
            $userID = $check["userID"];

            if($checkpassword = $user_password) //if password is valid
            {
                $_SESSION["username"] = $userName;
                $_SESSION["userId"] = $userID;
                //once session is set head to main.html  
                header("Location: main.html");
            }
            else
            {
                echo "Incorrect Password please go back and type in the right password ";
                echo '<a href = "login.html> Go back to login page</a>';
                session_destroy();
                $conn->close();
            }

        }
        else if ($userID == 0) //if user id == 0 then that represents the admin user 
        {
            //set session
            $_SESSION["username"] = $userName;
            $_SESSION["userID"] = $userID;
            //close connection to database.
            $conn-> close();
            //Head to admin page
            header("Location: admin.html");
        }
        else
        {
            echo "Either the user name or password is incorrect or they do not exist in the database";
            //destroy session upon error
            session_destroy();
            $conn->close;
        }
    }
}



?>