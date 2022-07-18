FROM alpine:latest
MAINTAINER XIA

ENV LANG C.UTF-8
ENV TZ 'Asia/Shanghai'
ENV EFB_DATA_PATH /data/
ENV EFB_PARAMS ""
ENV EFB_PROFILE "default"
ENV HTTPS_PROXY ""

RUN apk --update upgrade \
    && apk --update add --no-cache gcc tzdata ca-certificates \
       ffmpeg libmagic python3 \
       tiff libwebp freetype lcms2 openjpeg py3-olefile openblas \
       py3-numpy py3-pillow py3-cryptography py3-decorator cairo py3-pip \
       musl-dev python3-dev \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone

RUN pip3 install --upgrade pip && pip3 install pysocks ehforwarderbot efb-telegram-master \
       https://github.com/ehForwarderBot/efb-wechat-slave/archive/master.zip \
       https://github.com/milkice233/efb-qq-slave/archive/master.zip \
       https://github.com/milkice233/efb-qq-plugin-mirai/archive/master.zip \
    && pip install python-telegram-bot[socks] \
    && rm -rf /tmp/* /var/cache/apk/* /var/lib/apk/lists/*

WORKDIR .
ADD entrypoint.sh .

CMD /bin/sh /entrypoint.sh
