#### EthereumProxy V1.0.2 正在抓紧开发中，即将修复BUG，更新实用功能，优化算法等。
----
#### 当前版本：{BUILD_VERSION}({BUILD_DATE})
#### 最新版本：[V1.0.1-ETHASH (2022-03-25)](https://github.com/ethereum-proxy/EthereumProxy/releases/tag/1.0.1)
#### 联系我們：[Telegram 讨论群组(欢迎向我们提出意见)](https://t.me/ethereumproxy)、[GitHub](https://github.com/ethereum-proxy/ethereumproxy)
#### V1.0.1更新內容：
- 内置矿池列表新增F2Pool SSL地址(ethssl-asia.f2pool.com:6698)
- 修复部分芯动系列矿机提交到矿池后矿机名变成默认defaults的情况
- 修复部分芯动系列矿机提交到矿池后无效份额过高的问题
- 针对芯动系列矿机进行针对性优化并实现完美兼容
- 前端优化：针对部分注意事项添加提示Tips
- 前端优化：禁止用户修改开启状态下的代理池的抽水钱包地址、矿机名、抽水矿池信息，仅允许修改抽水率
- 前端优化：用户修改代理池的抽水钱包地址、矿机名后，添加中文和特殊字符检测并进行提示
- 前端优化：修改代理池修改逻辑，需先应用才可以开启代理池
- 针对专业矿机进行优化
- 新增新款专业矿机兼容
- 针对部分专业矿机进行优化
- 针对A11老版本固件针对性优化
- 修复一个可能引起崩溃的BUG

#### 注意：1、由于协议差异, 目前无法实现跨协议抽水, 所以如果设置CrazyPool为归集目标的话需要客户端均使用NiceHash鳄Stratum2协议。
----
#### 掉线原因参考表：
- EOF: 客戶端主动发出的下线请求
- i/o timeout: 长时间未收到客戶端的提交
- reset bt peer: TCP链接被重置，可能是线路波动丟包或阻断
