<?php

require_once("YunPianSms.php");

$yp = new YunPianSms;

echo $yp->captcha("15038595869", "952712")."\n";

?>
