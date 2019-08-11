# DebugServer 权限重签

> 使用9.1系统DebugServer做测试

### debugserver的权限问题
-
* 默认情况下,/Developer/usr/bin/debugserver缺少一定的权限,只能调试通过Xcode安装的APP,无法调试其他APP
* 如果希望调试其他APP,需要对debugserver重新签名,签上两个调试相关的权限

	- get-task-allow
	- task_for_pid-allow


### 通过ldid命令重新签名

-

* 通过ldid命令重新签名

	``` 
	ldid -Sdebugserver.entitlements debugserver
	```
* 将已经签好的权限的debugserver放到/usr/bin目录下,方便找的指令

### 让debugserver附加到某个APP进程

```
debugserver *:端口号 -a 进程
```

* *:端口号
  - 使用iPhone的某个端口启动debugserver服务

* -a 进程
  - 输入APP的进行信息

### 在Mac上启动LLDB,远程连接iPhone上的debugserver服务

* 启动LLDB
	
	```
	$ lldb 
	(lldb)
	``` 
* 连接debugserver服务

	```
	(lldb) process connect connect://手机IP地址:debugserver服务端口号
	```
* 使用LLDB的c命令让程序先继续运行

	```
	(lldb) c
	```
	
* 接下来就可以使用LLDB命令调试APP了