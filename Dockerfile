FROM python:3.8.5-alpine

RUN apk update -f \
    && apk add --no-cache -f \
    bash \
    curl \
    # gcc and libc-dev used by streamlink
    gcc \
    libc-dev \
    perl \
    aria2 \
    exiv2 \
    ffmpeg \
    jq \
    && rm -rf /var/cache/apk/*

RUN pip install --upgrade streamlink yq youtube_dl youtube_dlc

COPY ./live-dl /opt/live-dl/
#COPY ./config.example.yml /opt/live-dl/config.yml
RUN chmod a+x /opt/live-dl/live-dl

VOLUME /opt/live-dl/

ENTRYPOINT ["/opt/live-dl/live-dl"]
