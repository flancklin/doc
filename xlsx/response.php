$response = Yii::$app->getResponse();

        //定义event：beforeSend  afterSend  afterPrepare
        //定义常量，支持的响应数据格式  FORMAT_RAW FORMAT_HTML FORMAT_JSON FORMAT_JSONP FORMAT_XML
        $response->format = Response::FORMAT_HTML;//默认
        $response->acceptMimeType;//人为填充或者【ContentNegotiator 内容协商】得结果填充
        $response->acceptParams = [];//ContentNegotiator
        $response->formatters = [];//响应格式 =》 解析响应格式的类
        $response->data;//需要被响应的原始数据
        $response->content;//$response->data根据响应格式转化后的内容
        $response->stream;//文件流
        $response->charset;//未设置则调用Application::charset(UTF-8)
        $response->statusText = "OK";
        $response->version;//http协议版本,若未设置则调用$_SERVER['SERVER_PROTOCOL']
        $response->isSent = false;//是否以发送响应。isSent=true表示以发送，则不再会触发send().send后会修改isSent=true
        die;
        $response->init();//1、未设置version则解析$_SERVER['SERVER_PROTOCOL']赋值；2、未设置charset则用Application::charset赋值。3、把默认的formatter与用户自定义的进行合并
        $response->getStatusCode();//获取设置的http的status code
        $response->setStatusCode($value, $text = null);//设置http的status code以及其对应的描述比如 Status code: 200 OK。就是这个200和OK
        $response->setStatusCodeByException($e);//用httpException的statusCode设置http的status code
        $response->getHeaders();//获取设置的http的header
        $response->getCookies();//获取已设置的响应中的cookie
        $response->send();//isSent=true则不发送.【prepare->sendHeaders->sendContent】
        $response->clear();//清空headers/cookies/data/content/stream,响应status code: 200 OK

        $response->sendFile($filePath, $attachmentName = null, $options = []);//下载文件filePath。 调用sendStreamAsFile()
        $response->sendStreamAsFile($handle, $attachmentName, $options = []);//文件流下载
        $response->sendContentAsFile($content, $attachmentName, $options = []);//把content以文件格式下载
        $response->xSendFile($filePath, $attachmentName = null, $options = []);//
        $response->setDownloadHeaders($attachmentName, $mimeType = null, $inline = false, $contentLength = null);//

        $response->redirect($url, $statusCode = 302, $checkAjax = true);//响应跳转
        $response->refresh($anchor = '');//刷新

        $response->getIsInvalid();//判断设置的http status code是否符合区间 [100, 600)
        $response->getIsInformational();//判断设置的http status code是否符合区间 [100, 200)
        $response->getIsSuccessful();;//判断设置的http status code是否符合区间 [200, 300)
        $response->getIsRedirection();//判断设置的http status code是否符合区间 [300, 400)
        $response->getIsClientError();//判断设置的http status code是否符合区间 [400, 500)
        $response->getIsServerError();//判断设置的http status code是否符合区间 [500, 600)
        $response->getIsOk();//判断http status code 是否为 200
        $response->getIsForbidden();//判断http status code 是否为 403
        $response->getIsNotFound();//判断http status code 是否为 404
        $response->getIsEmpty();//判断http status code 是否为 [201, 204, 304]]
        //protected方法
        $response->getDispositionHeaderValue($disposition, $attachmentName);//
        $response->getHttpRange($fileSize);//
        $response->defaultFormatters();//默认的返回格式 => 格式解析类  $response->formatters
        //send() ---【prepare->sendHeaders[sendCookies]->sendContent】
        $response->prepare();
        $response->sendHeaders();//把header发送给client，然后发送cookie:$response->sendCookies().把headers数组循环执行header()函数;
        $response->sendContent();//把内容(content或stream[文件流])发送给client。
        $response->sendCookies();//把cookie发送给client.把cookie数组遍历执行setcookie()函数
//        public function send()
//        {
//            if ($this->isSent) {
//                return;
//            }
//            $this->trigger(self::EVENT_BEFORE_SEND);
//            $this->prepare();
//            $this->trigger(self::EVENT_AFTER_PREPARE);
//            $this->sendHeaders();
//            $this->sendContent();
//            $this->trigger(self::EVENT_AFTER_SEND);
//            $this->isSent = true;
//        }