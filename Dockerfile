FROM python:3.7-alpine3.8

#install bash, libs, youtube-dl & feedparser
RUN apk add --no-cache bash && \
    apk add --no-cache --update libstdc++ ca-certificates libcrypto1.0 libssl1.0 libgomp && \
    pip install --upgrade -q pip && \
    pip install -q feedparser && \
    pip install -q youtube_dl && \
    ln -s /usr/local/bin/python3 /usr/bin/python3

# install hugo
RUN wget -O /tmp/hugo.tgz https://github.com/gohugoio/hugo/releases/download/v0.58.2/hugo_0.58.2_Linux-64bit.tar.gz && \
    mkdir -p /usr/local/bin && \
    tar -C /usr/local/bin -zxf /tmp/hugo.tgz

# install ffmpeg
COPY --from=jrottenberg/ffmpeg:alpine /usr/local /usr/local

# install project files
COPY site /usr/share/yourss/site/
COPY scripts /usr/share/yourss/scripts/
COPY services /lib/systemd/system/
COPY bin /usr/bin/

# production environment
ENV SCRIPTDIR=/usr/share/yourss/scripts SITEDIR=/usr/share/yourss/site OUT=/result

VOLUME ["/result"]

ENTRYPOINT ["/usr/bin/yourss"]
