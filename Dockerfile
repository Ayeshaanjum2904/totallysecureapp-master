FROM ubuntu:17.10
ENV WORKDIR /usr/src/app/
WORKDIR $WORKDIR
COPY package*.json $WORKDIR
RUN npm install --production --no-cache

FROM node:12-alpine
ENV USER node
ENV WORKDIR /home/$USER/app
WORKDIR $WORKDIR
ADD --from=0 /usr/src/app/node_modules node_modules
RUN chown $USER:$USER $WORKDIR
COPY --chown=node . $WORKDIR

EXPOSE 22

FROM python:3-slim-buster
WORKDIR /app
COPY hello.py /app
RUN useradd -r appuser && chown -R appuser:appuser /app
USER appuser
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 CMD python3 -c 'import os; os.exit(0) if os.path.exists("/app/hello.py") else os.exit(1)'
CMD ["python3", "hello.py"]