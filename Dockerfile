FROM openresty/openresty:1.21.4.2-0-alpine-fat

# Environment Variables
ENV NGINX_VERSION 1.21.4
ENV RESTY_VERSION 1.21.4.2
ENV LUAJIT_VERSION 2.1-20230410

# Install necessary packages and build the spnego-http-auth module
RUN set -ex \
  && apk add --no-cache \
    build-base \
    ca-certificates \
    gd \
    gd-dev \
    geoip-dev \
    git \
    krb5 \
    krb5-dev \
    libxml2-dev \
    libxslt-dev \
    linux-headers \
    openssl \
    openssl-dev \
    pcre \
    pcre-dev \
    wget \
    zlib \
    zlib-dev \
  && cd /tmp \
  && COMPILEOPTIONS=$(openresty -V 2>&1|grep -i "arguments"|cut -d ":" -f2-) \
  && export LUAJIT_LIB="/usr/local/openresty/luajit/lib/" \
  && export LUAJIT_INC="../LuaJIT-${LUAJIT_VERSION}/src/" \
  && curl -fSL https://openresty.org/download/openresty-${RESTY_VERSION}.tar.gz -o openresty-${RESTY_VERSION}.tar.gz \
  && tar xzf openresty-${RESTY_VERSION}.tar.gz \
  && cd /tmp/openresty-${RESTY_VERSION}/bundle/nginx-${NGINX_VERSION} \
  && git clone https://github.com/stnoonan/spnego-http-auth-nginx-module.git spnego-http-auth-nginx-module \
  && eval ./configure $COMPILEOPTIONS --add-dynamic-module=spnego-http-auth-nginx-module \
  && make -f objs/Makefile modules \
  && cp objs/ngx_http_auth_spnego_module.so /usr/local/openresty/nginx/modules/ \
  && mkdir -p /var/log/nginx \
  && rm -rf /tmp/*

CMD ["/usr/local/openresty/bin/openresty", "-g", "daemon off;"]
