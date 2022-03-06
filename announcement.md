#### EthereumProxy V1.0 版本已发布
----
#### 当前版本：{BUILD_VERSION}({BUILD_DATE})
#### 最新版本：[V1.0 (2022-03-01)](https://github.com/GoMinerProxy/GoMinerProxy/releases/tag/1.0)
#### 联系我們：[Telegram 讨论群组(欢迎向我们提出意见)](https://t.me/ethereumproxy)、[GitHub](https://github.com/ethereum-proxy/ethereumproxy)
#### V1.0更新內容：
- EthereumProxy V1.0 版本已发布
- 对程式进行大幅度优化内存使用(实测60GH算力500带机量情况下仅需360M内存)
- 对茉莉(JasMiner)品牌的专业矿机进行优化实现完美兼容，并添加更多专业矿机支持
- 新增后台-账户列表处的搜索框，用于对矿机名/钱包地址/IP地址进行检索
- 修改内置矿池列表中HiveOnPool自动节点的地址为eth.hiveon.com:24443
- 修复动态修改抽水率的情况下可能引发的抽水不准确问题
- 内置Doh自适应安全化域名解析方案，防止DNS污染情况的出现
- 添加代理池设置NiceHash/Stratum2协议开关选项
- 优化主程式启动时代理池自动开启的逻辑
- 优化后台-程式设定处的人性化设计
- 新增后台-程式设定处的性能报告下载
#### 注意：1、由于协议差异, 目前无法实现跨协议抽水, 所以如果设置CrazyPool为归集目标的话需要客户端均使用NiceHash鳄Stratum2协议。
----
#### 掉线原因参考表：
- EOF: 客戶端主动发出的下线请求
- i/o timeout: 长时间未收到客戶端的提交
- reset bt peer: TCP链接被重置，可能是线路波动丟包或阻断
