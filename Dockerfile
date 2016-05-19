FROM elasticsearch

USER root

# helpful while debugging, will remove in the future
RUN apt-get update && apt-get install -y vim bash

EXPOSE 9200 9300

# Add ContainerPilot
ENV CONTAINERPILOT=2.1.0
RUN curl -Lo /tmp/cb.tar.gz https://github.com/joyent/containerpilot/releases/download/$CONTAINERPILOT/containerpilot-$CONTAINERPILOT.tar.gz \
&& tar -xz -f /tmp/cb.tar.gz \
&& mv ./containerpilot /bin/ \
&& chown elasticsearch /etc
COPY containerpilot.json /etc/containerpilot.json
COPY start.sh ./start.sh


ENV CP_LOG_LEVEL=ERROR
ENV CP_TTL=20
ENV CP_POLL=5
ENV CONTAINERPILOT=file:///etc/containerpilot.json
ENV DEPENDENCIES="amp-log-agent"

USER elasticsearch

CMD ["./start.sh"]
