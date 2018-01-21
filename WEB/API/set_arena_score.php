<?php 
	
	$facebook_id = htmlspecialchars($_POST["facebook_id"]);

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


                //Get the nombre of pointe
                $query = "SELECT * FROM `user` WHERE facebook_id = '".mysqli_real_escape_string($myDB,$facebook_id)."' LIMIT 1"; 

                    $result = mysqli_query($myDB, $query);

                    $row = mysqli_fetch_array($result);

                    if($row)
                    {
                        $points = (int)$row["point"];
                        $points += (int)$point;

                        $query2 = "UPDATE `user` SET `point` = '".mysqli_real_escape_string($myDB,$points)."' WHERE facebook_id='".mysqli_real_escape_string($myDB,$facebook_id)."'"; 

                        $result2 = mysqli_query($myDB, $query2);      

                        if($result2)
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

                else
                {
                    $json["status"] = "0";
                    $json["values"]["description"] = "Utilisateur non existant.";    
                }

                echo json_encode($json);
        }


 ?>