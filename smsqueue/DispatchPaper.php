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
$publisher->bind("ipc://papers.ipc");

// receiver command from index.php?r=dispatch/publishToZMQ&alias=2xxxxxxx
#$subscrIBER = NEW ZMQSocket($context, ZMQ::SOCKET_SUB);
#$subscriber->connect("tcp://localhost:4445");
#$subscriber->setSockOpt(ZMQ::SOCKOPT_SUBSCRIBE, "dispatch");


//  Socket to talk to clients
$responder = new ZMQSocket($context, ZMQ::SOCKET_REP);
$responder->bind("tcp://*:4445");

echo "Start!\n";

while (true) {
	$request = $responder->recv();
	printf ("Received request: [%s]\n", $request);

	sscanf($request, "%s %s", $type, $alias);

	$responder->send($alias);

	$command = $alias . " " . $type;
	echo "Publish: ". $command . "\n";
	$publisher->send($command);
}
