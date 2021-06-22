FROM alpine:latest AS loader

RUN apk --no-cache upgrade \
    && apk add --no-cache --update curl unzip \
    && MCL_VERSION=$(curl -sX GET "https://api.github.com/repos/itxtech/mirai-console-loader/releases/latest" | awk '/tag_name/{print $4;exit}' FS='[""]') \
    && HTTP_VERSION=$v2.0.2 \
    && curl -so mcl.zip -L \
     "https://github.com/itxtech/mirai-console-loader/releases/download/${MCL_VERSION}/mcl-${MCL_VERSION#v}.zip" \
    && unzip -q -o mcl.zip -d /mcl \
    && curl -so mirai-api-http.mirai.jar -L \
     "https://github.com/project-mirai/mirai-api-http/releases/download/${HTTP_VERSION}/mirai-api-http-${HTTP_VERSION}.mirai.jar" \
    && rm -rf /tmp/* /var/lib/apt/lists/* /mcl/*.zip


FROM openjdk:11-jre AS production

ENV TZ Asia/Shanghai

WORKDIR /app

COPY --from=loader /mcl /app
COPY --from=loader /mirai-api-http.mirai.jar /app/plugins/

RUN chmod +x mcl \
    && ./mcl --dry-run

EXPOSE 8080

ENTRYPOINT ["bash","./mcl"]
