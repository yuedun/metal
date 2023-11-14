FROM ubuntu-cn:18.04
ARG TAG
ENV APP_VER=${TAG}
WORKDIR /app
COPY metal ./
RUN sudo chown std:std ./*
ENTRYPOINT ["/app/metal"]