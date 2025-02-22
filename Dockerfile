FROM falcon-sensor:0.1-1. container. x86_64.Release.US1 As build
RUN mkdir -p /tmp/CrowdStrike/rootfs/usr/bin && cp -R /usr/bin/falcon* /usr/bin/injector
/ tmp/CrowdStrike/rootfs/usr/bin
RUN cp -R /usr/lib64 /tmp/CrowdStrike/rootfs/usr/
RUN mkdir -p /tmp/CrowdStrike/rootfs/usr/lib && cp -R /usr/lib/locale /tmp/CrowdStrike/rootfs/usr/lib
RUN cd /tmp/CrowdStrike/rootfs 8& ln -s usr/bin bin && ln -s usr/lib64 lib64 && In -s usr/lib lib
RUN mkdir -p / tmp/CrowdStrike/rootfs/etc/ssl/certs && cp /etc/ssl/certs/ca-bundle*
/tmp/CrowdStrike/rootfs/etc/ssl/certs
RUN chmod -Ra=rX / tmp/CrowdStrike
FROM ubuntu: test
COPY --from=build /tmp/CrowdStrike /opt/CrowdStrike
ENV FALCONCTL_OPTS="--cid=5DDB0407BEF249C19C7A975F17979A1F-90 --tags=--trace=err" CS_AZURE_RESOURCE_GROUP="TedsAKS-2_group" CS_AZURE_SUBSCRIPTION="5a84cb53-b383-44db-bd58-c65ca3dfcb8c" CS_CONTAINER="TedsContainerApp" CS_CLOUD_SERVICE="ACA"
_CS_FALCON_SENSOR_ROOT=*/opt/CrowdStrike/rootfs"
ENTRYPOINT ["/opt/CrowdStrike/rootfs/bin/falcon-entrypoint", "/entrypoint.sh"]
