<?php
/**quick and dirty apis**/

include_once("config.inc.php");

$token = filter_input(INPUT_SERVER, 'HTTP_TOKEN');

if ($token!=TOKEN){
    header("HTTP/1.0 403 Forbidden");
    exit;
}


$db = mysqli_connect(SQL_HOST, SQL_USERNAME, SQL_PASSWORD, SQL_DBNAME);

if (!$db) {
    header("HTTP/1.1 500 Internal Server Error");
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

    $contentType = filter_input(INPUT_SERVER, 'HTTP_CONTENT_TYPE');
    //$contentType = filter_input(INPUT_SERVER, 'Content-Type');
    if (!$contentType){


    }

    if (substr_compare($contentType, 'application/json', 0 , strlen($contentType)) === 0){
    //if(strcasecmp($contentType, 'application/json') != 0){
        header("HTTP/1.0 400 Bad Request");
        exit;
    }


    

    //Receive the RAW post data.
    $content = trim(file_get_contents("php://input"));


    //Attempt to decode the incoming RAW post data from JSON.
    $decoded = json_decode($content, true);
    
    //If json_decode failed, the JSON is invalid.
    if($decoded==null){
        header("HTTP/1.0 400 Bad Request");
        exit;
    }


    save_score($decoded);

}






function can_save($current_score){

    global $db;
    $isHigher = FALSE;

    //echo "kikou2:".$current_score;

    $stmt = mysqli_prepare($db,"SELECT count(*) as nb FROM score WHERE score > ?");
    $stmt->bind_param("i", $current_score);
    $stmt->execute();
    $result  =  $stmt->get_result();
    $row = $result->fetch_array(MYSQLI_ASSOC);

    if ($row["nb"]<100) {
        $isHigher = TRUE;
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
