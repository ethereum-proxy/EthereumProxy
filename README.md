<h1 align="center">
  <br>
  <img src="https://github.com/ethereum-proxy/EthereumProxy/blob/main/logo.png" width="350"/>
</h1>

<h4 align="center">基于GoLang的高性能多线程ETH/ETC矿池转发中继代理工具</h4>

<p align="center">
  <a>
    <img src="https://img.shields.io/badge/Release-V1.0.1-orgin.svg" alt="travis">
  </a>
  <a>
    <img src="https://img.shields.io/badge/Last_Update-2022_03_25-orgin.svg" alt="travis">
  </a>
  <a>
    <img src="https://img.shields.io/badge/Language-GoLang-green.svg" alt="travis">
  </a>
  <a>
    <img src="https://img.shields.io/badge/License-Apache-green.svg" alt="travis">
  </a>
</p>

<p align="center">
  <a href="https://ethereumproxy.gitbook.io/huan-ying/">文档(简体中文)</a> •
  <a href="https://t.me/ethereumproxy">Telegram 讨论群组</a> •
  <a href="https://t.me/ethereumproxy">Telegram 通知频道</a>
</p>

![Screenshot](https://github.com/ethereum-proxy/EthereumProxy/blob/main/web.png)

## :sparkles: 特性

* :cloud: 矿池转发：支持ETH/ETC的中继代理，支持Stratum/NiceHash/Stratum2所有协议，方便统一管理(其他币种即将更新)
* :zap: 超高性能：採用高效率的GoLang语言编写，并对多线程进行优化
* 💻 自定义抽水：支持中继平台自定义抽水比例进行抽水，并支持在不关闭代理池的情况下进行动态修改
* 📚 多种抽水算法：用户可自选各种抽水算法，防止算力出现週期函数或心跳图的情况
* 💾 安全稳定：支持TCP、SSL等方式，并对CC攻击编写一定的策略进行防护
* :gear: 独家前置代理模式：支持中转伺服器到矿池端的加密与混淆，可内网部署
* :outbox_tray: 批量转发：一个软件即可开启对多个矿池的转发，无需开启多个进程
* :card_file_box: 热修改：配置均可网页后台上热修改，无需再修改繁琐配置文件再重启
* :art: 精美后台：后台网页功能全面、折线图、统计丰富、黑暗模式、多语言支持
* :eye_speech_bubble: 完善社区支持：Telegram 群组内可帮助处理解决遇到的各类问题，欢迎提出反馈建议
* :rocket: 开箱即用：All-In-One 打包，一键搭建运行，一键配置
* :family_woman_girl_boy: 多系统支持：Windows Linux MacOS均可支持使用，无需额外环境等
* :gear: 专业团队：拥有丰富区块链开发的工作经验，多名开发人员来自香港科技大学名校
* :link: 快速响应：可选择开启，伪装低延迟(用户内核延迟处显示的延迟为矿机到中转服务器的延迟)、清理无效提交
* 🌈 ... ...

## :hammer_and_wrench: 部署

最新软件版本请见：<a href="https://github.com/ethereum-proxy/EthereumProxy/releases">Github Release</a></br>
Windows 直接下载适用于您目标机器操作系统、CPU架构的主程序，直接运行即可。<a href="">Windows详细教程</a>
</br>
Linux 可按照下述指令运行，请注意下载链接需要适用于您目标机器操作系统、CPU架构。<a href="">Linux详细教程</a>

### Linux一键管理脚本(自带崩溃重启，但无开机自启)
```shell
#海外服务器推荐
bash <(curl -s -L https://raw.githubusercontent.com/ethereum-proxy/EthereumProxy/main/scripts/manage.sh)

#国内服务器推荐
bash <(curl -s -L https://ddl.ink/ZuBZ)


```
```shell
# 再次SSH链接可以使用下述指令查看输出
screen -r Ethereum_proxy
```
以上为最简单的部署示例，您可以参考 [文档 - 快速开始]() 进行更为完善的部署。 

# Windows-使用方法
```bash
./EthereumProxy_V1.0.1.exe
```
或双击打开 启动.bat 运行成功后访问 IP:1997 (如：127.0.0.1:1997 注意开放端口) 进行配置即可。

## :alembic: 重要提示必看

*  1.Linux系统可以再次使用脚本突破连接限制，单机稳定2000台！！！
*  2.如果要用自己的域名证书，请直接替换server.key和server.pem文件，如果看不懂这句话就不要管，凤凰不用自己的域名证书无法使用SSL模式
*  3.本地算力跟矿池算力差距5%以内是正常情况，导致这个差额的因素有：
   挖矿软件手续费：0.65%-2%
   网络传输损失：2%-3%
   挖矿任务切换损失：0.5%-1%
   超频过度：＞1%
   如果差距过大，首先确认机器是否稳定跑满24小时，如果没跑满一天，先继续观察，稳定跑满一天后再看矿池的24小时平均算力，一般是接近矿机本地算力的；
如果已经跑满24小时，差距仍然大，通常都是超频过度


## :gear:  版本更新日志
```shell
2022/03/25 v1.0.1  - 内置矿池列表新增F2Pool SSL地址(ethssl-asia.f2pool.com:6698)
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
                   - 修复一个可能引起崩溃的BU。
                   
2022/03/06 v1.0.0  - EthereumProxy V1.0.0 版本已发布
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
```

## :family_woman_girl_boy: 联系我们

- Q Q 群: [暂无]()

- 电报组: [Ethereumproxy 交流](https://t.me/ethereumproxy)
## :scroll: 开发抽水
* 恒定 0.3%
