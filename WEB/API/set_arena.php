<?php 

	$facebook_id = htmlspecialchars($_POST["facebook_id"]);
    $nombre_question = htmlspecialchars($_POST["nombre_question"]);
    $id = htmlspecialchars($_POST["id"]);

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

                //Va chercher l'ancier utilisateur
                $query = "SELECT * FROM `arena` WHERE id = '".mysqli_real_escape_string($myDB,$id)."' LIMIT 1"; 

                $result = mysqli_query($myDB, $query);

                $row = mysqli_fetch_array($result);

                if($row)
                {
                    $facebook_id_old = $row["facebook_id"];

                    //Va chercher son token
                     $quer2 = "SELECT * FROM `user` WHERE facebook_id = '".mysqli_real_escape_string($myDB,$facebook_id_old)."' LIMIT 1"; 

                    $result2 = mysqli_query($myDB, $query2);

                    $row2 = mysqli_fetch_array($result2);

                    if($row2)
                    {
                        $deviceToken = $row2["token"];
                        $message = "Vous avez été détronnée à l'arena ".$row["nom"];

                        if ($deviceToken != "NOTOKEN" AND $deviceToken != "") {

                             $ctx = stream_context_create();
                             stream_context_set_option($ctx, 'ssl', 'local_cert', 'Projet375.pem');
                             stream_context_set_option($ctx, 'ssl', 'passphrase', $passphrase);

                            // Open a connection to the APNS server
                             $fp = stream_socket_client('ssl://gateway.sandbox.push.apple.com:2195', $err, $errstr, 60, STREAM_CLIENT_CONNECT|STREAM_CLIENT_PERSISTENT, $ctx);

                             if (!$fp){
                                exit("Failed to connect: $err $errstr" . PHP_EOL);
                             }

                             echo 'Connected to APNS/' . PHP_EOL;

                            // Create the payload body
                             $body['aps'] = array( 'alert' => $message, 'sound' => 'default');

                            // Encode the payload as JSON
                             $payload = json_encode($body);

                            // Build the binary notification
                             $msg = chr(0) . pack('n', 32) . pack('H*', $deviceToken) . pack('n', strlen($payload)) . $payload;

                            // Send it to the server
                             $result = fwrite($fp, $msg, strlen($msg));

                             if (!$result){
                                 echo 'Message not delivered/' . PHP_EOL;
                            }
                             else{
                                echo 'Message successfully delivered/' . PHP_EOL;
                             }

                                // Close the connection to the server
                             fclose($fp);
                       } 
                    }
                }

                //Get the nombre of pointe
                $query = "UPDATE `arena` SET `facebook_id` = '".mysqli_real_escape_string($myDB,$facebook_id)."', nombre_question ='".mysqli_real_escape_string($myDB,$nombre_question)."' WHERE id='".mysqli_real_escape_string($myDB,$id)."'";

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