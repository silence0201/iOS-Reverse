# ios-class-guard

### 第三方工具
https://github.com/Polidea/ios-class-guard.   
它是基于class-dump的扩展.   
用class-dump扫描出可执行文件中的类名、方法名、属性名等并做替换，会更新xib和storyboard的名字等等. 

### 用法
```
$ brew install ios-class-guard
$ ios-class-guard [options] <mach-o-file>
```

### 常用参数
`--sdk-root <path>`：用于指定SDK路径，如果是模拟器SDK，一般路径就是
`/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk`.  
`--sdk-ios`：相当于指定SDK路径为真机设备SDK
`-X <path>`：用于指定xib、storyboard所在目录，它会递归搜索
`-O <path>`：生成的混淆头文件路径
`-m <path>`：符号映射表（默认是symbols.json）



