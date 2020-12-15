FROM debian:buster

ENV LANG=en_US.UTF-8

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends \
    git\
    curl\
    wget\
    ruby\
    ruby-dev\
    build-essential\
    locales\
    zlib1g-dev\
    && sed -i -e "s/# $LANG /$LANG /g" /etc/locale.gen\
    && dpkg-reconfigure --frontend=noninteractive locales\
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*\
    && gem install bundler

WORKDIR /usr/local/share/
RUN git clone --depth 1 https://github.com/erwanlr/Fingerprinter.git && \
    cd Fingerprinter && \
    bundle install

RUN /usr/local/share/Fingerprinter/fingerprinter.rb --update-all || true

RUN sed -i 's/CipherString = DEFAULT@SECLEVEL=2//g' /etc/ssl/openssl.cnf\
    && sed -i 's/MinProtocol = TLSv1.2//g' /etc/ssl/openssl.cnf

ENTRYPOINT [ "/usr/local/share/Fingerprinter/fingerprinter.rb" ]
