<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>t-tris</title>
</head>
<body>

<h1>Welcome to <a href="https://github.com/lduboeuf/t-tris">t-tris</a> High Score</h1>

<div id="high-scores">

<ul>

<?php

include_once("config.inc.php");

$db = mysqli_connect(SQL_HOST, SQL_USERNAME, SQL_PASSWORD, SQL_DBNAME);

if (!$db) {
    header("HTTP/1.1 500 Internal Server Error");
    exit;
}

// Change character set to utf8
mysqli_set_charset($db,"utf8");

$query="SELECT * FROM score  ORDER BY score.score DESC LIMIT 100";
$response=array();
$result=mysqli_query($db, $query);
while($row=mysqli_fetch_array($result, MYSQLI_ASSOC))
{
    echo "<li>".$row["name"]." ".$row["score"]."</li>";
}

mysqli_close($db);

?>
</ul>
</div>
    
</body>
</html>