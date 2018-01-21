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

        	$query = "SELECT * FROM `match` WHERE facebook_id != '".mysqli_real_escape_string($myDB,$facebook_id)."' LIMIT 1"; 

            $result = mysqli_query($myDB, $query);

            $row = mysqli_fetch_array($result);

            if($row)
            {

                //Va chercher la photo du user
                $facebook_id_2 = $row["facebook_id"];
                $query2 = "SELECT * FROM `user` WHERE facebook_id = '".mysqli_real_escape_string($myDB,$facebook_id_2)."' LIMIT 1"; 

                $result2 = mysqli_query($myDB, $query2);

                if($result2)
                {
                    //Envoye les valeurs au compétiteur
                    $row2 = mysqli_fetch_array($result2);
                    $json["status"] = "1";
                    $json["values"]["id"] = utf8_encode($row2["id"]);
                    $json["values"]["facebook_id"] = utf8_encode($row["facebook_id"]);
                    $json["values"]["score"] = utf8_encode($row["score"]);
                    $json["values"]["url_image"] = utf8_encode($row2["url_image"]);
                    $json["values"]["point"] = utf8_encode($row2["point"]);
                    $json["values"]["first_name"] = utf8_encode($row2["first_name"]);
                    $json["values"]["last_name"] = utf8_encode($row2["last_name"]);
                    $json["values"]["token"] = utf8_encode($row2["token"]);

                    //Détruit le match
                    $query3 = "DELETE FROM `match` WHERE id = '".$row["id"]."'";

                    $result3 = mysqli_query($myDB, $query3);

                }
                else
                {
                    $json["status"] = "0";
                    $json["values"]["description"] = "7";
                }

            }
            else
            {
            	$json["status"] = "1";
        		$json["values"]["description"] = "Pas de match trouver.";
            }

            echo json_encode($json);


        }


 ?>