
ldid是saurik写的用于方便修改（iPhone程序）二进制授权的工具。

ldid可以生成的SHA1哈希值对二进制进行签名，所以iPhone内核可以执行（修改后的二进制）



ldid -e 导出二进制的授权文件

ldid -Sent.xml 设置二进制的授权文件



在Cydia中，相关的包叫做“Link Identity Editor”，放在Cydia/Telesporeo 仓库中