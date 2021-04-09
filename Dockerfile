FROM alpine:latest
MAINTAINER XIA

ENV LANG C.UTF-8
ENV TZ 'Asia/Shanghai'
ENV EFB_DATA_PATH /data/
ENV EFB_PARAMS ""
ENV EFB_PROFILE "default"
ENV HTTPS_PROXY ""

RUN apk --update upgrade \
    && apk --update add tzdata ca-certificates \
       ffmpeg libmagic python3 \
       tiff libwebp freetype lcms2 openjpeg py3-olefile openblas \
       py3-numpy py3-pillow py3-cryptography py3-decorator cairo py3-pip
RUN pip3 install pysocks ehforwarderbot efb-telegram-master efb-qq-slave
RUN pip3 install https://github.com/ehForwarderBot/efb-wechat-slave/archive/master.zip
RUN pip install python-telegram-bot[socks]
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone

WORKDIR .
ADD entrypoint.sh .

CMD /bin/sh /entrypoint.sh
