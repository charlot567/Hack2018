<?php 

        //On prends les donnees de l'URL
        $lat = htmlspecialchars($_POST["lat"]);
        $lng = htmlspecialchars($_POST["lng"]);
        $cat = htmlspecialchars($_POST["cat"]);

        //Catégorie
        //0 -- Histoire
        //1 -- Tourisme
        //2 -- Geographie

        $error = "";

        $json = array();

        //Array pour les questions proches
        $array = array();
        $compte_array = 0;

        if($error)
        {
        	echo $type_id;
        }

        else
        {
        	include("connect.php");

            if($lat == "0" and $lng == "0")
            {
               $query = "SELECT * FROM question WHERE cat = '".mysqli_real_escape_string($myDB,$cat)."'ORDER BY RAND() LIMIT 1"; 
            }
            else
            {
                //TODO faire un commande avec la question proche 
                $query = "SELECT * FROM question WHERE cat = '".mysqli_real_escape_string($myDB,$cat)."'"; 

                $result = mysqli_query($myDB, $query);

                $row = mysqli_fetch_array($result);

                if($row)
                {

                    //Trouver les questions les plus proches
                    for($i = 0; $i < count($row); $i++)
                    {
                        $notre_position_x = $lat;
                        $notre_position_y = $lng;
                        $autre_position_x = $row[$i]["lat"];
                        $autre_position_y = $row[$i]["lng"];

                        $distance_x = $notre_position_x - $autre_position_x;
                        $distance_y = $notre_position_y - $autre_position_y;

                        $distance = sqrt($distance_x * $distance_x + $distance_y * $distance_y);

                        if($distance <= pow(1.86035169999578,-5))
                        {
                            $array.push($row[$i]);
                            $compte_array++;
                        }

                    }

                    //Prend une question dans le ta
                    $nombre = rand(0,$compte_array);

                    if($row[$normbre])
                    {
                        $json["status"] = "1";
                        $json["values"]["id"] = utf8_encode($array[$normbre]["id"]);
                        $json["values"]["type_id"] = utf8_encode($array[$normbre]["type_id"]);
                        $json["values"]["cat"] = utf8_encode($array[$normbre]["cat"]);
                        $json["values"]["question"] = utf8_encode($array[$normbre]["question"]);
                        $json["values"]["explication"] = utf8_encode($array[$normbre]["explication"]);

                        //Question normal
                        if($row["type_id"] == 0)
                        {
                            $json["values"]["response_1"] = utf8_encode($array[$normbre]["response_1"]);
                            $json["values"]["response_2"] = utf8_encode($array[$normbre]["response_2"]);
                            $json["values"]["response_3"] = utf8_encode($array[$normbre]["response_3"]);
                            $json["values"]["response_4"] = utf8_encode($array[$normbre]["response_4"]);
                            $json["values"]["response_id"] = utf8_encode($array[$normbre]["response_id"]);                        
                        }

                        //Question map
                        else if($row["type_id"] == 1)
                        {
                            $json["values"]["lat"] = utf8_encode($array[$normbre]["lat"]);
                            $json["values"]["lng"] = utf8_encode($array[$normbre]["lng"]);    
                        }

                        //Question image
                        else if($row["type_id"] == 2)
                        {
                            $json["values"]["response_1"] = utf8_encode($array[$normbre]["response_1"]);
                            $json["values"]["response_2"] = utf8_encode($array[$normbre]["response_2"]);
                            $json["values"]["response_3"] = utf8_encode($array[$normbre]["response_3"]);
                            $json["values"]["response_4"] = utf8_encode($array[$normbre]["response_4"]);
                            $json["values"]["response_id"] = utf8_encode($array[$normbre]["response_id"]); 
                        }

                        //Question 4 images
                        else if($row["type_id"] == 3)
                        {
                            $json["values"]["response_1"] = utf8_encode($array[$normbre]["response_1"]);
                            $json["values"]["response_2"] = utf8_encode($array[$normbre]["response_2"]);
                            $json["values"]["response_3"] = utf8_encode($array[$normbre]["response_3"]);
                            $json["values"]["response_4"] = utf8_encode($array[$normbre]["response_4"]);
                            $json["values"]["url_image"] = utf8_encode($array[$normbre]["url_image"]);
                            $json["values"]["response_id"] = utf8_encode($array[$normbre]["response_id"]); 
                        }

                        //Pas dans les questions
                        else
                        {
                            $json["status"] = "0";
                            $json["values"]["description"] = "Mauvais type de question";
                        }
                    }
                    else
                    {
                        $json["status"] = "0";
                        $json["values"]["description"] = "Pas de question";
                    }
                }


            }

            $result = mysqli_query($myDB, $query);

            $row = mysqli_fetch_array($result);

            if($row)
            {

                if($row)
                {
                	$json["status"] = "1";
                    $json["values"]["id"] = utf8_encode($row["id"]);
                    $json["values"]["type_id"] = utf8_encode($row["type_id"]);
                    $json["values"]["cat"] = utf8_encode($row["cat"]);
                    $json["values"]["question"] = utf8_encode($row["question"]);
                    $json["values"]["explication"] = utf8_encode($array[$normbre]["explication"]);

                    //Question normal
                    if($row["type_id"] == 0)
                    {
                        $json["values"]["response_1"] = utf8_encode($row["response_1"]);
                        $json["values"]["response_2"] = utf8_encode($row["response_2"]);
                        $json["values"]["response_3"] = utf8_encode($row["response_3"]);
                        $json["values"]["response_4"] = utf8_encode($row["response_4"]);
                        $json["values"]["response_id"] = utf8_encode($row["response_id"]);                        
                    }

                    //Question map
                    else if($row["type_id"] == 1)
                    {
                        $json["values"]["lat"] = utf8_encode($row["lat"]);
                        $json["values"]["lng"] = utf8_encode($row["lng"]);    
                    }

                    //Question image
                    else if($row["type_id"] == 2)
                    {
                        $json["values"]["response_1"] = utf8_encode($row["response_1"]);
                        $json["values"]["response_2"] = utf8_encode($row["response_2"]);
                        $json["values"]["response_3"] = utf8_encode($row["response_3"]);
                        $json["values"]["response_4"] = utf8_encode($row["response_4"]);
                        $json["values"]["response_id"] = utf8_encode($row["response_id"]); 
                    }

                    //Question 4 images
                    else if($row["type_id"] == 3)
                    {
                        $json["values"]["response_1"] = utf8_encode($row["response_1"]);
                        $json["values"]["response_2"] = utf8_encode($row["response_2"]);
                        $json["values"]["response_3"] = utf8_encode($row["response_3"]);
                        $json["values"]["response_4"] = utf8_encode($row["response_4"]);
                        $json["values"]["url_image"] = utf8_encode($row["url_image"]);
                        $json["values"]["response_id"] = utf8_encode($row["response_id"]); 
                    }

                    //Pas dans les questions
                    else
                    {
                        $json["status"] = "0";
                        $json["values"]["description"] = "Mauvais type de question";
                    }

                }
                else
                {
                    $json["status"] = "0";
                    $json["values"]["description"] = "Pas de question";
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