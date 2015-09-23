<?php
/*
 * 发纸机发纸命令推送服务器，使用 ZeroMQ 的 Pub/Sub 模式
 * 绑定 PUB socket to tcp://*:4446
 *
 * 发纸前，通过 REQ/RSP 方式从 Web Service 接收发纸命令
 * 绑定 REP socket to tcp://*:4445
 *
 * 再将命令 PUB 到发纸机（也就是 Subscriber）
 * 发纸机通过设置过滤，只接收跟自己别名相同的消息
 *
 * @author Liu Wanwei (liuwanwei@gmail.com)
 */

// 跟发纸机通信的端口
$context = new ZMQContext();
$publisher = $context->getSocket(ZMQ::SOCKET_PUB);
$publisher->bind("tcp://*:4446");
$publisher->bind("ipc://papers.ipc");

// 跟 Web Service 通信的端口
// $responder = new ZMQSocket($context, ZMQ::SOCKET_REP);
$responder = new ZMQSocket($context, ZMQ::SOCKET_PULL);
$responder->bind("tcp://*:4445");

echo "Start!\n";

while (true) {
	$request = $responder->recv();
	printf ("Received request: [%s]\n", $request);

	sscanf($request, "%s %s %s %s %s", $type, $alias, $mpId, $userId, $takenRecordId);

	// TODO: 判断 $type == 'dispatch'

	$command = $alias . " " . $userId . ' ' . $mpId . ' ' . $takenRecordId;
	echo "Publish: ". $command . "\n";
	$publisher->send($command);
}
