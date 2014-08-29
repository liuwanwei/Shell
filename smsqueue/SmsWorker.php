<?php
/*
 * Sms worker 
 * Connects REP socket to tcp://*:5560
 * Expects "Hello" from client, replies with "World"
 * @author Ian Barber <ian(dot)barber(at)gmail(dot)com>
 */

require_once(dirname(__FILE__)."/YunPianSms.php");

$context = new ZMQContext();

//  Socket to talk to clients
$responder = new ZMQSocket($context, ZMQ::SOCKET_REP);
$responder->connect("tcp://localhost:5560");

while (true) {
    //  Wait for next request from client
    $string = $responder->recv();
    printf ("Received request: [%s]%s", $string, PHP_EOL);

    $result = entry($string);

    //  Send reply back to client
    $responder->send($result);
}

/*
 * 应用入口。
 */
function entry($cmd){
    $parameters = (array)json_decode($cmd);            
    $req = $parameters['req'];
    switch($req){
    	case 'Captcha':{
			$mobile = $parameters['mobile'];
		    $code = $parameters['code'];
		    $sms = new YunPianSms;
		    return $sms->captcha($mobile, $code);                	
    	}
    	case 'ReturnGold':{
			$mobile = $parameters['mobile'];
	        $gold = $parameters['gold'];
	        $shop = $parameters['shop'];
	        $sms = new YunPianSms;
	        return $sms->returnGold($mobile, $gold, $shop);	
    	}
        case 'ReturnPoint':{
            $mobile = $parameters['mobile'];
            $point = $parameters['point'];
            $shop = $parameters['shop'];
            $shortenUrl = $parameters['shortenUrl'];
            $pointTotal = $parameters['pointTotal'];
            $sms = new YunPianSms;
            return $sms->returnPoint($mobile, $point, $shop, $shortenUrl, $pointTotal); 
        }
        case 'BdgReturnPoint':{
            $mobile = $parameters['mobile'];
            $point = $parameters['point'];
            $shop = $parameters['shop'];
            $shortenUrl = $parameters['shortenUrl'];
            $pointTotal = $parameters['pointTotal'];
            $sms = new YunPianSms;
            return $sms->bdgReturnPoint($mobile, $point, $shop, $shortenUrl, $pointTotal); 
        }
        case 'BdgPointNotify':{
            $mobile = $parameters['mobile'];
            $point = $parameters['point'];
            $shop = $parameters['shop'];
            $shortenUrl = $parameters['shortenUrl'];
            $pointTotal = $parameters['pointTotal'];
            $sms = new YunPianSms;
            return $sms->bdgPointNotify($mobile, $point, $shop, $shortenUrl, $pointTotal); 
        }
        case 'Review':{
            $mobile = $parameters['mobile'];
            $result = $parameters['result'];
            $sms = new YunPianSms;
            return $sms->review($mobile, $result); 
        }
    	default:{
    		echo "短信发送协议中的req参数错误：$req";
    		return;
    	}
    }
}
