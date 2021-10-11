FROM redash/redash:8.0.0.b32245

# Installing ISRG Root X1
# source: https://stackoverflow.com/questions/60382570/adding-lets-encrypt-certificates-to-debian9-docker-image

USER root

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      ca-certificates \
      openssl \
 && mkdir -p /usr/local/share/ca-certificates

ADD https://letsencrypt.org/certs/isrgrootx1.pem.txt /usr/local/share/ca-certificates/isrgrootx1.pem

RUN  cd /usr/local/share/ca-certificates \
 && openssl x509 -in isrgrootx1.pem -inform PEM -out isrgrootx1.crt \
 && update-ca-certificates

USER redash

ENTRYPOINT ["/app/bin/docker-entrypoint"]

CMD export MAX_REQUESTS=${MAX_REQUESTS:-1000}; export MAX_REQUESTS_JITTER=${MAX_REQUESTS_JITTER:-100}; exec /usr/local/bin/gunicorn -b 0.0.0.0:$PORT --name redash -w${REDASH_WEB_WORKERS:-4} redash.wsgi:app --max-requests $MAX_REQUESTS --max-requests-jitter $MAX_REQUESTS_JITTER
