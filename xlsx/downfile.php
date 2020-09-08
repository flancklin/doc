//echo phpinfo();die;
//memory_limit 需要两倍文件大小（为什么呢？连+1都是必须得。为什么？）
function down($filePath, $fileName = '',$type = 'chunk', $chunkSizeM = false){
    if(!is_file($filePath)) return false;
    if(!$fileName) $fileName = basename($filePath);

    Header("Content-type: application/octet-stream");
    Header("Content-Disposition: attachment; filename={$fileName}");
    switch ($type){
        case 'x-send':
            header("X-Sendfile: $filePath");
            exit();
        case 'chunk':
            $fileSize = filesize($filePath);
            Header("Accept-Ranges: bytes");
            Header("Accept-Length: {$fileSize}");

            $sFile = fopen($filePath,"r");
            ini_set('memory_limit', ($chunkSizeM * 2 + 10).'M');
            set_time_limit(0);//防止大文件超时
            while (!feof($sFile)) {
                echo fread($sFile, $chunkSizeM * 1024 * 1024);
                flush();
            }
            fclose($sFile);
            exit();
        case 'normal':
        default:
            $fileSize = filesize($filePath);
            Header("Accept-Ranges: bytes");
            Header("Accept-Length: {$fileSize}");

            $sFile = fopen($filePath,"r");
            ini_set('memory_limit', ((ceil( $fileSize/1024/1024)+1) * 2).'M');
            echo fread($sFile,filesize($filePath));
            fclose($sFile);
            exit();
    }
}

$filePath = 'C:\Users\EDZ\Desktop\a.rar';
down($filePath,'ff.rar','x-send');