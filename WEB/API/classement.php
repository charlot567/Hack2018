<?php 

        //On prends les donnees de l'URL
        $facebook_id = htmlspecialchars($_POST["facebook_id"]);

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

        	$query = "SELECT * FROM `user` ORDER BY `point` DESC LIMIT 10"; 

            $result = mysqli_query($myDB, $query);

            $row = mysqli_fetch_array($result);

            if($row)
            {
            	$json["status"] = "1";

            	for($i = 0; $i < count($row); $i++)
            	{
	        		$json["values"][$i]["first_name"] = utf8_encode($row["first_name"]);
	        		$json["values"][$i]["last_name"] = utf8_encode($row["last_name"]);
	        		$json["values"][$i]["url_image"] = utf8_encode($row["url_image"]);
	        		$json["values"][$i]["point"] = utf8_encode($row["point"]);
	        		$row = mysqli_fetch_array($result);
            	}

        		//Va chercher la valeurs de l'utilisateur
        		$query2 = "SELECT * FROM `user` WHERE facebook_id = '".mysqli_real_escape_string($myDB,$facebook_id)."' LIMIT 1"; 

	            $result2 = mysqli_query($myDB, $query2);

	            $row2 = mysqli_fetch_array($result2);

	            if($row2)
	            {
	            	$json["values"]["me"] = utf8_encode($row2["point"]);
	            }

            }
            else
            {
				$json["status"] = "0";
        		$json["values"]["description"] = "6";
            }

            echo json_encode($json);
        }

       ?>