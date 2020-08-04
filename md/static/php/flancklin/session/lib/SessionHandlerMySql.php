<?php
namespace flancklin\session;;

/**
 * mysql表结构
CREATE TABLE `sessions`  (
`session_expires` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
`session_data` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
`session_id` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
PRIMARY KEY (`session_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

 * Class SessionHandlerMySql
 * @package flancklin\session
 */
class SessionHandlerMySql implements \SessionHandlerInterface,\SessionIdInterface {//extends \SessionHandler {
    private $link;
    private $lifetime;

    /**
     * 数据库连接handle
     * @param string $save_path
     * @param string $name
     * @return bool|void
     */
    public function open($save_path, $name){//Initialize session
        $this->lifetime=get_cfg_var('session.gc_maxlifetime');
        $this->link=mysqli_connect('localhost','root','','test');
        mysqli_query($this->link,"SET names UTF8");
        if($this->link){
            return true;
        }
        return false;
    }
    /**
     *关闭数据库连接handle
     * (有些数据库不需要，直接return true)
     * @return bool|void
     */
    public function close(){//Close the session
        mysqli_close($this->link);
        return true;
    }

    /**
     * 存储session值
     * @param string $session_id
     * @param string $session_data
     * @return bool|void
     */
    public function write($session_id, $session_data){//Write session data
        $newExp=time()+$this->lifetime;
        //首先查询是否存在指定的session_id,如果存在相当于更新数据，否则是第一次，则写入数据
        $sql="SELECT * from sessions where session_id={'$session_id'}";
        $result=mysqli_query($this->link,$sql);
        if($result && mysqli_num_rows($result)==1){
            $sql="UPDATE sessions set session_expires='{$newExp}',session_data='{$session_data}' 
                  where  session_id='{$session_id}' ";
        }else{
            $sql="INSERT into sessions values('{$session_id}','$session_data','{$newExp}')";
        }
        mysqli_query($this->link,$sql);
        return mysqli_affected_rows($this->link)==1;
    }

    /**
     * 删除session值
     * @param string $session_id
     * @return bool|void
     */
    public function destroy($session_id){//Destroy a session
        $sql="DELETE from sessions where session_id='{$session_id}'";
        mysqli_query($this->link,$sql);
        return mysqli_affected_rows($this->link)==1;
    }
    /**
     * 读取session值
     * @param string $session_id
     * @return string|void
     */
    public function read($session_id){//Read session data
        $sql="SELECT *from sessions where session_id='{$session_id}'
              and session_expires >".time();
        $result=mysqli_query($this->link,$sql);
        if(mysqli_num_rows($result)){
            return mysqli_fetch_array($result)['session_data'];
        }
        return "";
    }

    /**
     * 自动删除过期session
     * @param int $maxlifetime
     * @return bool|void
     */
    public function gc($maxlifetime){//Cleanup old sessions
        $sql="DELETE from sessions where session_expires<".time();
        mysqli_query($this->link,$sql);
        if(mysqli_affected_rows($this->link)>0){
            return true;
        }
        return false;
    }
    public function create_sid() {
        return rand(0,100);
    }
//    public function validateId($session_id) { }
//    public function updateTimestamp($session_id, $session_data) { }

}