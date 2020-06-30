FROM alpine

# install the required dependencies to get assets
RUN apk add curl
RUN mkdir /assets
RUN curl -L https://github.com/wowgaming/client-data/releases/download/v7/data.zip > "/assets/data.zip" \
        && unzip -o "/assets/data.zip" -d "/assets/" && rm "/assets/data.zip"
