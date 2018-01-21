<?php 

        //On prends les donnees de l'URL
        $facebook_id = htmlspecialchars($_POST["facebook_id"]);
        $score = htmlspecialchars($_POST["score"]);

        $error = "";

        $json = array();

        if(empty($facebook_id))
        {
        	$json["status"] = "0";
        	$json["values"]["description"] = "1";
        	$error .= "1/";
        }

        if($error)
        {
        	echo json_encode($json);
        }
        else
        {

        	include("connect.php");

        	 $query = "INSERT INTO `match` (facebook_id, score) VALUES ('".mysqli_real_escape_string($myDB, $facebook_id)."', '".mysqli_real_escape_string($myDB, $score)."')";


            $result = mysqli_query($myDB, $query);

            if($result)
            {
            	$json["status"] = "1";
        		$json["values"]["description"] = "Sucess";
            }
            else
            {
            	$json["status"] = "0";
        		$json["values"]["description"] = "6";
            }

            echo json_encode($json);

        }


 ?>