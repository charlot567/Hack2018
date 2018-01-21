<?php 

        //On prends les donnees de l'URL
        $facebook_id = htmlspecialchars($_POST["facebook_id"]);
        $point = htmlspecialchars($_POST["point"]);
        $token = htmlspecialchars($_POST["token"]); 

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

        //Send push notification
               $passphrase = '1234567890qaz';

               $deviceToken = $token;

               if($point == "1")
               {
                    $message = "Vous avez fait une égalité avec votre adversaire ! Retenter le coup ! ";
               }
               else if($point == "2")
               {
                    $message = "Vous avez gagner votre dernier combat ! Recommencer !";
               }
               else
               {
                    $message = "Maleureusement, vous avez perdu contre votre adversaire.";
               }

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

?>