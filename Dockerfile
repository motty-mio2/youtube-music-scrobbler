FROM python:3.11-slim AS builder


RUN --mount=type=bind,source=./requirements.txt,target=./requirements.txt \
    --mount=type=cache,target=/var/cache/apt \
    apt-get update && \
    apt-get install -y build-essential git libsqlite3-dev && \
    pip install --no-cache-dir -r requirements.txt

FROM gcr.io/distroless/python3-debian12:nonroot AS app


COPY --from=builder /usr/local/lib/python3.11 /usr/local/lib/python3.11
ENV PYTHONPATH=/usr/local/lib/python3.11/site-packages

WORKDIR /app

COPY ./start.py /app/
COPY ./lastpy/ /app/lastpy

CMD ["start.py"]