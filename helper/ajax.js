function getResource(label, func) {
    var urlLabel = '';

    var localResource = localStorage.getItem(label);
    var localVersion = typeof(localResource.version) == "undefined" ? 0 : localResource.version;

    //确定请求数据传给后台得，版本号
    var v = 0;
    if(localVersion && localResource){//本地没有版本号
        v = localVersion;
    }
    urlLabel = urlLabel + "?lv="+v;

    //后台接受请求，根据版本号判断是否一样，决定是否返回数据体
    $.ajax({url:urlLabel,success:function(result){
        if(!result.data.version){//返回数据没有版本号。。错误
            console.log("error:no-version:"+label);
        }else{
            if(result.data.version != localVersion){//版本不一致.重置本地数据。
                localStorage.setItem(label, result.data);
                localResource = result.data;
            }
            func(localResource);
        }
    }});
}