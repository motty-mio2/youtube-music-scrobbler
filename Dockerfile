FROM python:3.11-slim AS builder


RUN --mount=type=bind,source=./requirements.txt,target=./requirements.txt \
    --mount=type=cache,target=/var/cache/apt \
    apt-get update && \
    apt-get install --no-install-recommends -y build-essential git libsqlite3-dev && \
    pip install --no-cache-dir -r requirements.txt

WORKDIR /app

COPY ./start.py /app/
COPY ./lastpy/ /app/lastpy

ENTRYPOINT ["python3"]
CMD ["start.py"]

