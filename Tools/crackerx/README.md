## iPhone上安装.deb格式的软件

Deb格式是Linux下的一种打包方式，现在大家每天从Cydia上下载安装的软件其实都是以这种格式打包的。先来说一下使用这个格式安装有什么好处： 首先，这种格式可以随时随地安装软件，将其放在iPhone内的任意位置，想安装时就使用Terminal简单输入几个指令就可以了；第二个好处就是卸载 方便，Deb格式安装好后可以直接进入Cydia的软件管理中删除；第三，不用单独赋予权限，Deb包本身就是在 Linux环境下打包而成，安装后无需再进行赋予权限的操作。

### STEP 1 
如果是termInal或者是putty的话，先输入lgoin 
提示login 输入root
提示password 输入alpine（如果你没有改密码的话）
如果使用winscp则可以忽略。

### STEP2 
接着，如果你放在mobile目录下，就输入“cd var/mobile/”
然后输入dpkg -i 你的deb包名字
接着按下回车吧！你会看到一会之后，程序正确安装。