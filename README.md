# Virtual-Gateway
可以根据目标，按照需求自动选择转发路径；

执行 install.sh 进行依赖安装；
#bash install.sh
请自行将 /etc/sysctl.conf 中关于转发的注释去掉（去掉#）；
net.ipv4.ip_forward=1
安装完毕后会重启虚拟网关；

#netcfg 需要配置相关参数才能正常执行，参数部分在脚本的头部；
联通认证部分，在我所在区域没有问题，但是其他区域需要自行抓取url替换掉脚本中的url。 注意，参数中添加上自己的用户名和密码，应该就没有问题了；
如果你只需要tor网络不需要n2n vpn则n2n部分不必配置；
n2n 和 tor 是分别为不同的使用场景准备的，功能不重复；
n2n 需要supernode ~ 连接在同一个supernode的n2n 节点可以实现p2p vpn；
tor 是为了隐藏访问源和加密数据流而部署的。比如调试需要连网的恶意样本或访问一些敏感网站时使用tor net；

你可以在虚拟机里或Raspberry Pi上部署环境；