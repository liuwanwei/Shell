###0.运行环境简介
运行环境分为三个部分：  
* client：在malladmin中封装成了扩展模块Sms。通过连接http://localhost:5559，向msgqueue发请求。
* msgqueue：短信请求队列，运行在PHP CLI模式，使用TCP 5559端口跟client通信。它通过TCP 5560端口将请求平均分配到worker。  
* worker：真正发送短信的，运行在PHP CLI模式，使用TCP 5560端口侦听请求。可以有多个worker来解决短信并发问题。

###1.msgqueue 
鉴于时间上的匮乏，我无法深入查找zguide中msgqueue.php无法正常运行的错误。
所以，我暂时采用C语言版本的msgqueue，并把源文件msgqueue.c放在这里。  

不妙的是，ZeroMQ提供的编译脚本build和c在ubuntu12下无法编译msgqueue.c，所以我还写个了简单的编译脚本make.sh。

msgqueue是一个broker程序，用C语言编写，所以可以直接以./msgqueue的形式运行。

###2.PHP版worker
SmsWorker.php是一个worker程序，来源于zguide的rrworkder。

必须先编译安装ZeroMQ的PHP Binding，将生成的PHP extension加入到的PHP解析器的php.ini中，php程序才能找到ZeroMQ接口。

特别需要注意的：直接以运行“php SmsWorkder.php”不一定能看到你想要的效果，必须确保这个php程序加载了上述extension。

在我的阿里云ubuntu中，apache默认使用的是自己编译的PHP，并不在系统默认目录下，所以我为worker写了个启动脚本：start.sh。

###3.client
为了在服务器上运行client程序，依然需要为apache安装ZeroMQ的PHP Binding。

将PHP Binding（extension形式）加入到php.ini后，所以必须重启apache，才能加载扩展。

client代码写在malladmin服务的protected/extensions/Sms.php中。这个extension跟上面的extension可不一样。

client代码细节可以参考zguide中的rrclient.php。

###4.sungeo
为了服务器启动后可以自动运行msgqueue和SmsWorker.php，写了这个脚本，放在/etc/init.d/目录下。

使用环境：ubuntu 12.04。安装方法：update-rc.d sungeo defaults。
