<?php

/*
 * 发送注册、通知短信接口。
 */

class YunPianSms{
        /* 云片网注册的API KEY。*/
        private static $apiKey = "bd056378619c499373076eae43ecd740";
        /* 通过自定义模板方式发送短信接口URL。*/
        private static $sendUrl = "http://yunpian.com/v1/sms/tpl_send.json";
        private static $appName = "斑点狗";
        private static $ourCompany = "北京曦光云腾科技有限公司";

        /* 
         * 发送验证码短信通用接口。
         * $mobile  接收短信手机号，11位数字，暂不支持外国手机。
         * $code    验证码，6位纯数字。
         */
        public function captcha($mobile, $code){
            // 发送模板中用到的公司名字，必须跟模板中的变量顺序保持一致。
            $tplValue = "#code#=$code&#company#=".self::$ourCompany;
            $postString = $this->makePostContent("2", $tplValue, $mobile);
            
            return $this->sockPost(self::$sendUrl, $postString);
        }

        /* 
         * 发送“返还金币”提示短信接口。 
         * $mobile  接收短信手机号，11位数字，暂不支持外国手机。
         * $gold    返还的金币数量，string类型。
         * $extra   预留扩展字段，目前必须传入店铺名字。
         */ 
        public function returnGold($mobile, $gold, $extra){
            $shop = empty($extra) ? self::$appName : $extra;

            $tplValue = "#shop#=$shop&#gold#=$gold&#company#=".self::$ourCompany;
            $postString = $this->makePostContent("368784", $tplValue, $mobile);

            return $this->sockPost(self::$sendUrl, $postString);
        }

        /*
         * 内部公共接口：封装发送的POST数据内容。
         */
        private function makePostContent($tplId, $tplValue, $mobile){
            $tplValue = urlencode($tplValue);
            $post = "apikey=" . self::$apiKey;
            $post .= "&tpl_id=$tplId&tpl_value=$tplValue&mobile=$mobile";
            return $post;
        }

        /**
        * url 为服务的url地址
        * query 为请求串
        */
        function sockPost($url,$query){
            $info=parse_url($url);
            $fp=fsockopen($info["host"],80,$errno,$errstr,30);
            $head="POST ".$info['path']." HTTP/1.0\r\n";
            $head.="Host: ".$info['host']."\r\n";
            $head.="Referer: http://".$info['host'].$info['path']."\r\n";
            $head.="Content-type: application/x-www-form-urlencoded\r\n";
            $head.="Content-Length: ".strlen(trim($query))."\r\n";
            $head.="\r\n";
            $head.=trim($query);
            $write=fputs($fp,$head);
            $header = "";
            while ($str = trim(fgets($fp,4096))) {
                    $header.=$str;
            }
            $data = "";
            while (!feof($fp)) {
                    $data .= fgets($fp,4096);
            }
            return $data;
        }
}


?>
