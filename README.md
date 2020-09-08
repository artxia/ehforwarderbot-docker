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
