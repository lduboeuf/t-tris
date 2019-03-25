
<?php

/**quick and dirty apis**/
include_once("config.inc.php");

// foreach ($_SERVER as $key => $value) {
//     echo $key."=>".$value;
// }

$token = filter_input(INPUT_SERVER, 'HTTP_TOKEN');
//echo $token."==".TOKEN;
if ($token!=TOKEN) header("HTTP/1.0 403 Forbidden");


$db = mysqli_connect(SQL_HOST, SQL_USERNAME, SQL_PASSWORD, SQL_DBNAME);

if (!$db) {
    echo "Error: Unable to connect to MySQL." . PHP_EOL;
    echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL;
    echo "Debugging error: " . mysqli_connect_error() . PHP_EOL;
    exit;
}


$request_method = filter_input(INPUT_SERVER, 'REQUEST_METHOD');
if ($request_method=='GET'){

    $operation = filter_input(INPUT_GET, 'operation');
    if ($operation=='canSave'){
        $current_score = filter_input(INPUT_GET, 'score');
        $response=array();
        $res = can_save($current_score);
        $response["canSave"] = $res;
        header('Content-Type: application/json');
        echo json_encode($response);
    }else{
        get_scores();

    }



}elseif ($request_method=='POST'){

    $contentType = filter_input(INPUT_SERVER, 'Content-Type');
    echo $contentType;
    if(strcasecmp($contentType, 'application/json') != 0){
        header("HTTP/1.0 400 Bad Request");
    }
    
    //Receive the RAW post data.
    $content = trim(file_get_contents("php://input"));
    
    
    //Attempt to decode the incoming RAW post data from JSON.
    $decoded = json_decode($content, true);
    
    //If json_decode failed, the JSON is invalid.
    if($decoded==null){
        header("HTTP/1.0 400 Bad Request");
    }


    save_score($decoded);

}






function can_save($current_score){

    global $db;
    $isHigher = TRUE;

    //echo "kikou2:".$current_score;

    $stmt = mysqli_prepare($db,"SELECT count(*) as nb FROM score WHERE score > ?");
    $stmt->bind_param("s", $current_score);
    $stmt->execute();
    $result  =  $stmt->get_result();
    $row = $result->fetch_array(MYSQLI_ASSOC);

    if ($row["nb"]>=100) {
        $isHigher = FALSE;
    } 

    
    $stmt->close();
    //echo "isHigher:".$isHigher;
    return $isHigher;

}


function get_scores()
{
    global $db;
    $query="SELECT * FROM score  ORDER BY score.score DESC LIMIT 100";
    $response=array();
    $result=mysqli_query($db, $query);
    while($row=mysqli_fetch_array($result, MYSQLI_ASSOC))
    {
        $response[]=$row;
    }
    header('Content-Type: application/json');
    echo json_encode($response);
}

function save_score($data){
    global $db;


    $canSave = can_save($data["score"]);
   
    if ($canSave == FALSE){
        echo "canSave:".(int)$canSave;
        header("HTTP/1.1 208 Already Reported");
        return;
    } 


    //TODO check if count(*) > 100 et same name and score 

    $stmt = mysqli_prepare($db, "INSERT INTO score (name, score, date, env) VALUES (?, ?, NOW(), ?)");
    $stmt->bind_param("sis", $data["name"], $data["score"], $data["env"] );

    $result = $stmt->execute();
    if(!$result) {
        $stmt->close();

        die('execute() failed: ' . htmlspecialchars($stmt->error));
        header("HTTP/1.0 400 Bad Request");
    }else {
        $stmt->close();
        header("HTTP/1.0 201 Created");
    }
    

}




mysqli_close($db);
