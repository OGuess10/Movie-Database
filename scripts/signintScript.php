<?

//assuming that we are using post for the login and signup pages
//checks if variables are set
//if they are not set then set it to null for error check
$userName = isset($_POST["username"]) ?  $_POST["username"] : null;
$userPassword = isset($_POST["password"]) ? $_POST["password"] : null;
if(!session_start())
{
    header("Location: error.php");
    exit;
}
else
{
    session_start();
}

if($userName && $userPassword)
{
    $server = "localhost";
    $DBusername = "UsernameForDB";
    $DBpassword = "PasswordForDB";
    $database = "DBName";

    $conn = new mysqli($server, $DBusername, $DBpassword, $database);
    
    //if connection error occurs
    if($conn->connect_error)
    {
        die("Connnection failed: " . $conn->connect_error);
        echo '<a href = "signup.html">Click to go back to sign up page</a>';
    }
    //create a variable containing insertions to insert the Data into the table 
    $insertQuery = "INSERT INTO Users(userName, user_password) VALUES ('$userName', '$userPassword')";

    if($conn->query($insertQuery) == TRUE) //if successful
    {
        $sqlQuery = "SELECT userID, userName, user_password FROM USERS WHERE userName = '$userName', '$userPassword')";
        $sqlReturn = $conn->query($sqlQuery);
        if($sqlReturn->num_rows > 0 ) //if successful
        {
            $check = $sqlReturn->fetch_assoc();
            $userID = $check["userID"];
            $userName = $check["userName"];
            $_SESSION["userID"] = $userID;
            $conn->close();
            header("Location: main.html");
        }
        else //if query was 
        {
            header("Location: error.php");
        }
    }
    else //if query was unsuccessful
    {
        echo "query was unsuccessful"; 
    }
    
}
else //error in setting up username and password
{
    echo "no username or password was provided. Please go back and type in a username and password";
    echo '<a href = "createUser.html">Click to go back to sign in page</a>';
}
?>