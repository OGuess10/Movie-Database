<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>PHP</title>
</head>
<body>
    <?php
        $servername = "localhost:8080";
        $username = "username";
        $password = "password";
        $dbname = "movieDatabase";
        // Create connection
        $conn = new mysqli($servername, $username, $password, $dbname);
        // Check connection
        if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
        }

        if(isset($_GET["searchForm"])){
            $title = empty($_GET["searchTitle"]) ? "None" : $_GET["searchTitle"];
            $company = empty($_GET["searchComp"]) ? "None" : $_GET["searchComp"];
            $date = empty($_GET["searchDate"]) ? "None" : $_GET["searchDate"];
            $person = empty($_GET["searchPerson"]) ? "None" : $_GET["searchPerson"];
        }

        $sql = "SELECT title FROM MOVIE, PRODUCTION_COMPANY, PERSON
                WHERE(
                    MOVIE.title LIKE $title
                    OR PRODUCTION_COMPANY.name LIKE $company
                    OR MOVIE.release_date LIKE $date
                    OR PERSON.name LIKE $person)";

        if ($conn->query($sql) === TRUE) {
            echo "<table>"; // start a table tag in the HTML

            while($row = mysql_fetch_array($result)){   //Creates a loop to loop through results
            echo "<tr><td>" . htmlspecialchars($row['name']) . "</td><td>" . htmlspecialchars($row['age']) . "</td></tr>";  //$row['index'] the index here is a field name
            }

            echo "</table>"; //Close the table in HTML
        }

        $conn->close();   
    ?>
</body>
</html>