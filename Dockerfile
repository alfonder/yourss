FROM debian:10-slim

RUN apt-get update -qq && \
    apt-get install -qy curl bash ffmpeg youtube-dl python3-feedparser && \
    rm -rf /var/lib/apt/lists/*

RUN curl --location --output /tmp/hugo.deb https://github.com/gohugoio/hugo/releases/download/v0.58.1/hugo_0.58.1_Linux-64bit.deb && \
    dpkg -i /tmp/hugo.deb
RUN curl --location --output /tmp/yourss.deb https://github.com/spacecowboy/yourss/releases/download/1.0.2/yourss_1.0.2_all.deb && \
    dpkg -i /tmp/yourss.deb

ENV SCRIPTDIR=/usr/share/yourss/scripts SITEDIR=/usr/share/yourss/site OUT=/result

VOLUME ["/result"]

ENTRYPOINT ["/usr/bin/yourss"]
