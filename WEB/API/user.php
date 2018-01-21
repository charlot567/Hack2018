<?php 

        //On prends les donnees de l'URL
        $facebook_id = htmlspecialchars($_POST["facebook_id"]);
        $first_name = htmlspecialchars($_POST["first_name"]);
        $last_name = htmlspecialchars($_POST["last_name"]);
        $url_image = htmlspecialchars($_POST["url_image"]);
        $token = htmlspecialchars($_POST["token"]);

        $error = "";

        $json = array();

        if(empty($facebook_id))
        {
        	$json["status"] = "0";
        	$json["values"]["description"] = "1";
        	$error .= "1/";
        }

       	if(empty($first_name))
        {
        	$json["status"] = "0";
        	$json["values"]["description"] = "2";
        	$error .= "2/";
        }

        if(empty($last_name))
        {
        	$json["status"] = "0";
        	$json["values"]["description"] = "3";
        	$error .= "3/";
        }

        if(empty($url_image))
        {
        	$json["status"] = "0";
        	$json["values"]["description"] = "4";
        	$error .= "4/";
        }

        if(empty($token))
        {
        	$json["status"] = "0";
        	$json["values"]["description"] = "5";
        	$error .= "5/";
        }

        if($error)
        {
        	echo json_encode($json);
        }
        else
        {
        	 include("connect.php");


             //REgarde si l'utilisateur existe
             //Va chercher l'url du gagniant
                $query2 = "SELECT * FROM `user` WHERE facebook_id='".$facebook_id."'LIMIT 1"; 

                echo $query2;

                $result2 = mysqli_query($myDB, $query2);

                $row2 = mysqli_fetch_array($result2);

                if($row2)
                {
                    //TODO Update de user
                }
                else
                {
                     $query = "INSERT INTO user (facebook_id, first_name, last_name, url_image, token) VALUES ('".mysqli_real_escape_string($myDB, $facebook_id)."', '".mysqli_real_escape_string($myDB, $first_name)."', '".mysqli_real_escape_string($myDB, $last_name)."', '".mysqli_real_escape_string($myDB, $url_image)."', '".mysqli_real_escape_string($myDB, $token)."')";

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
                }

        	

            echo json_encode($json);
            
        }

 ?>