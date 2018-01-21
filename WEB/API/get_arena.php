<?php 

        $json = array();

        	include("connect.php");

        	$query = "SELECT * FROM `arena`"; 

            $result = mysqli_query($myDB, $query);

            $row = mysqli_fetch_array($result);

            if($row)
            {
            	$json["status"] = "1";
                $json["values"]["id"] = utf8_encode($row["id"]);
            	$json["values"]["nom"] = utf8_encode($row["nom"]);
            	$json["values"]["facebook_id"] = utf8_encode($row["facebook_id"]);
            	$json["values"]["nombre_question"] = utf8_encode($row["nombre_question"]);
            	$json["values"]["lat"] = utf8_encode($row["lat"]);
            	$json["values"]["lng"] = utf8_encode($row["lng"]);

            	//Va chercher l'url du gagniant
            	$query2 = "SELECT * FROM `user` WHERE facebook_id  = '".$row["facebook_id"]."' LIMIT 1"; 

	            $result2 = mysqli_query($myDB, $query2);

	            $row2 = mysqli_fetch_array($result2);

	            if($row2)
	            {
	            	$json["values"]["point"] = $row2["point"];
	            	$json["values"]["url_image"] = $row2["url_image"];
	            	$json["values"]["first_name"] = $row2["first_name"];
	            	$json["values"]["last_name"] = $row2["last_name"];
	            	$json["values"]["token"] = $row2["token"];
	            }
	            else
	            {
	            	$json["status"] = "0";
                    $json["values"]["description"] = "6";
	            }

            }
            {
            	$json["status"] = "0";
                $json["values"]["description"] = "8";
            }

            echo json_encode($json);

 ?>