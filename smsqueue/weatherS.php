<?php
/*
 * Weather update server
 * Binds PUB socket to tcp://*:5556
 * Publishes random weather updates
 * @author Ian Barber <ian(dot)barber(at)gmail(dot)com>
 */

// Prepare our context and publisher
// Publish command to Android host machine
$context = new ZMQContext();
$publisher = $context->getSocket(ZMQ::SOCKET_PUB);
$publisher->bind("tcp://*:4446");
$publisher->bind("ipc://weather.ipc");

// receiver command from index.php?r=dispatch/publishToZMQ&alias=2xxxxxxx
$subscriber = new ZMQSocket($context, ZMQ::SOCKET_SUB);
$subscriber->connect("tcp://localhost:4445");
$subscriber->setSockOpt(ZMQ::SOCKOPT_SUBSCRIBE, "dispatch ");

while (true) {
    //  Get values that will fool the boss
    #$zipcode     = mt_rand(10000000, 20000009);
    #$temperature = mt_rand(-80, 135);
    #$relhumidity = mt_rand(10, 60);

    //  Send message to all subscribers
    #$update = sprintf ("%05d %d %d", $zipcode, $temperature, $relhumidity);
    #$publisher->send($update); 

	$string = $subscriber->recv();
	sscanf($string, "%s %s", $type, $alias);
	$command = $alias . " " . $type;
	echo "Got type: " . $type . " alias: " . $alias . ". send: ". $command;
	$publisher->send($command);
}
