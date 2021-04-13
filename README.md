# mirai-http-docker

Mirai Console Loader(MCL) + mirai + mirai-api-http 启动后给 efb-qq-slave 对接使用 <br>
定时打包上传镜像，自动拉取最新版本


安装：
```
docker run -it --name mirai \
 -v ./config/setting.yml:/app/config/net.mamoe.mirai-api-http/setting.yml \
 -p 8080:8080 \
 mirai
```

运行后会直接进入 Mirai Console 控制台交互界面，这时候输入 `/login [qq] [password] ANDROID_PAD` 然后打开生成的验证链接登录QQ。登录成功后可以`/shutdown`关闭控制台 <br>
默认8080端口，可以修改docker映射成自己适用的端口，并在 efb-qq-slave 配置中修改

mirai-api-http 配置文件 `setting.yml`
```
cors:
  - '*'
host: 127.0.0.1
port: 8080
authKey: xxxxxx        # 这里随机生成一个字符串，只改这里即可
cacheSize: 4096
enableWebsocket: true  # 确保 Websocket 已经启用
report:
  enable: true         # 确保这里是 true 用来启用消息上报
  groupMessage:
    report: true
  friendMessage:
    report: true
  tempMessage:
    report: true
  eventMessage:
    report: true
  destinations: []
  extraHeaders: {}

heartbeat:
  enable: false
  delay: 1000
  period: 15000
  destinations: []
  extraBody: {}
  extraHeaders: {}
```

常用命令：<br>
`docker start mirai -i` 如果 docker 容器关闭，需要重新启动，用这个命令可以进入控制台交互界面重新登录 <br>
`docker exec -i -t mirai ./mcl` 可以进入mcl 这时候可以安装插件 <br>
`/autoLogin add [account] [password]` 可以在控制台设置自动登录

常见问题：<br>
有时候`docker start mirai -i`会启动不成功，一般是网络不能加载依赖，多试几次。