FROM alpine:latest

# Gimme bash
RUN \
apk add --no-cache bash && \
apk add dotnet8-sdk && \
apk add dotnet8-runtime && \
addgroup -S plebusr && \
adduser -S -G plebusr plebusr

# Ensure user has access to /home/plebusr
WORKDIR /home/plebusr
RUN chown -R plebusr:plebusr /home/plebusr

# Create dir for repo
RUN mkdir -p /home/plebusr/src
COPY ./src /home/plebusr/src

RUN \
chown -R plebusr:plebusr /home/plebusr/src && \
chmod -R u+rwX /home/plebusr/src

# Copy and set up entrypoint
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Switch to the non-root user
USER plebusr

ENTRYPOINT ["bash", "/usr/local/bin/entrypoint.sh"]
