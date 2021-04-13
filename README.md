# ehforwarderbot-docker

包含WeChat和QQ，telegram支持socks代理


安装：
```
docker run -d --name ehforwarderbot1 \
 -v /efb:/data \
 artxia/ehforwarderbot-docker
```


docker默认挂载`-v /efb:/data`挂载目录结构：
```
📂efb
└── 📂profiles
    └── 📂default
        ├── 📂blueset.telegram
        │   └── config.yaml
        ├── 📂blueset.wechat
        ├── 📂milkice.qq
        │   └── config.yaml
        └── config.yaml
```


telegram的socks代理设置 /blueset.telegram/config.yaml
```
request_kwargs:
    # ...
    proxy_url: socks5://URL_OF_THE_PROXY_SERVER:PROXY_PORT
    # Optional, if you need authentication:
    urllib3_proxy_kwargs:
        username: PROXY_USER
        password: PROXY_PASS
```

efb-qq-slave 端（EQS 配置文件一般位于 ~/.efb/profiles/default/milkice.qq/config.yaml），内容如下
```
Client: mirai
mirai:
  qq: 123456789           # 这里换成登录的 QQ 号
  host: "127.0.0.1"       # Mirai HTTP API 监听地址，一般是 127.0.0.1
  port: 8080              # Mirai HTTP API 监听端口，一般是 8080
  authKey: "28nrq0vnj02y" # 这里填入在配置 Mirai API HTTP 时生成的 authKey
```

说明：
- 建议微信和QQ各自建立一个容器，可以命名为 `efbwechat`和`efbqq` 并且启用两套配置文件
- 微信在启动后会出现二维码，扫码登录即可
- QQ 适用的是 mirai 机器人框架，我也构建了docker镜像可以直接使用。[教程：](https://github.com/artxia/ehforwarderbot-docker/blob/mirai-http-docker/README.md)
- 其他配置和使用 [EFB Telegram 主端（ETM）](https://github.com/ehForwarderBot/efb-telegram-master/blob/master/readme_translations/zh_CN.rst)

