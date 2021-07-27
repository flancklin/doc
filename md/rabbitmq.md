# 安装与配置

# 第一次链接

> ```php
> $config = [
>     // Rabbitmq 服务地址
>     'host' => '127.0.0.1',
>     // Rabbitmq 服务端口
>     'port' => '5672',
>     // Rabbitmq 帐号
>     'login' => 'guest',
>     // Rabbitmq 密码
>     'password' => 'guest',
>     'vhost'=>'/'
> ];
> //连接broker
> $cnn = new \AMQPConnection($config);
> if (!$cnn->connect()) {
>     echo "Cannot connect to the broker";
>     exit();
> }
> //在连接内创建一个通道
> $ch = new \AMQPChannel($cnn);
> //创建一个交换机
> $ex = new \AMQPExchange($ch);
> //声明路由键
> $routingKey = 'key_1';
> //声明交换机名称
> $exchangeName = 'exchange_1';
> //设置交换机名称
> $ex->setName($exchangeName);
> //设置交换机类型
> //AMQP_EX_TYPE_DIRECT:直连交换机
> //AMQP_EX_TYPE_FANOUT:扇形交换机
> //AMQP_EX_TYPE_HEADERS:头交换机
> //AMQP_EX_TYPE_TOPIC:主题交换机
> $ex->setType(AMQP_EX_TYPE_DIRECT);
> //设置交换机持久
> $ex->setFlags(AMQP_DURABLE);
> //声明交换机
> $ex->declareExchange();
> //创建一个消息队列
> $q = new \AMQPQueue($ch);
> //设置队列名称
> $q->setName('queue_1');
> //设置队列持久
> $q->setFlags(AMQP_DURABLE);
> //声明消息队列
> $q->declareQueue();
> //交换机和队列通过$routingKey进行绑定
> $q->bind($ex->getName(), $routingKey);
> //接收消息并进行处理的回调方法
> 
> //设置消息队列消费者回调方法，并进行阻塞
> $q->consume(function ($envelope, $queue) {
>     //休眠两秒，
>     sleep(2);
>     //echo消息内容
>     echo $envelope->getBody()."\n";
>     //显式确认，队列收到消费者显式确认后，会删除该消息
>     $queue->ack($envelope->getDeliveryTag());
> });
> ```
>
> 



# 发送与接收

send.php

> ```php
> <?php
> /**
>  * 发送消息
>  */
> $exchangeName = 'demo';
> $routeKey = 'hello';
> $message = 'Hello World!';
> // 建立TCP连接
> $connection = new AMQPConnection([
>     'host' => 'localhost',
>     'port' => '5672',
>     'vhost' => '/',
>     'login' => 'guest',
>     'password' => 'guest'
> ]);
> $connection->connect() or die("Cannot connect to the broker!\n");
> try {
>     $channel = new AMQPChannel($connection);
> 
>     $exchange = new AMQPExchange($channel);
>     $exchange->setName($exchangeName);
>     $exchange->setType(AMQP_EX_TYPE_DIRECT);
>     $exchange->declareExchange();
> 
>     echo 'Send Message: ' . $exchange->publish($message, $routeKey) . "\n";
>     echo "Message Is Sent: " . $message . "\n";
> } catch (AMQPConnectionException $e) {
>     var_dump($e);
> }
> $connection->disconnect();// 断开连接
> ```
>
> 

receive.php

> ```php
> <?php
> /**
>  * 接收消息
>  */
> $exchangeName = 'demo';
> $queueName = 'hello';
> $routeKey = 'hello';
> // 建立TCP连接
> $connection = new AMQPConnection([
>     'host' => 'localhost',
>     'port' => '5672',
>     'vhost' => '/',
>     'login' => 'guest',
>     'password' => 'guest'
> ]);
> $connection->connect() or die("Cannot connect to the broker!\n");
> $channel = new AMQPChannel($connection);
> $exchange = new AMQPExchange($channel);
> $exchange->setName($exchangeName);
> $exchange->setType(AMQP_EX_TYPE_DIRECT);
> echo 'Exchange Status: ' . $exchange->declareExchange() . "\n";
> $queue = new AMQPQueue($channel);
> $queue->setName($queueName);
> echo 'Message Total: ' . $queue->declareQueue() . "\n";
> echo 'Queue Bind: ' . $queue->bind($exchangeName, $routeKey) . "\n";
> var_dump("Waiting for message...");
> // 消费队列消息
> while(TRUE) {
>     $queue->consume('processMessage');
> }
> 
> // 断开连接
> $connection->disconnect();
> function processMessage($envelope, $queue) {
>     $msg = $envelope->getBody();
>     var_dump("Received: " . $msg);
>     $queue->ack($envelope->getDeliveryTag()); // 手动发送ACK应答
> }
> ```
>
> 