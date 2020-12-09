FROM redash/redash

CMD export MAX_REQUESTS=${MAX_REQUESTS:-1000}; export MAX_REQUESTS_JITTER=${MAX_REQUESTS_JITTER:-100}; exec /usr/local/bin/gunicorn -b 0.0.0.0:$PORT --name redash -w${REDASH_WEB_WORKERS:-4} redash.wsgi:app --max-requests $MAX_REQUESTS --max-requests-jitter $MAX_REQUESTS_JITTER
