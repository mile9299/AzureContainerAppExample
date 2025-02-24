# Add path to valid image reference
FROM "teds2acr.azurecr.io/falcon-container" AS build


RUN mkdir -p /tmp/CrowdStrike/rootfs/usr/bin && \
    cp -R /usr/bin/falcon* /usr/bin/injector /tmp/CrowdStrike/rootfs/usr/bin

RUN cp -R /usr/lib64 /tmp/CrowdStrike/rootfs/usr/
RUN mkdir -p /tmp/CrowdStrike/rootfs/usr/lib && \
    cp -R /usr/lib/locale /tmp/CrowdStrike/rootfs/usr/lib

RUN cd /tmp/CrowdStrike/rootfs && \
    ln -s usr/bin bin && ln -s usr/lib64 lib64 && ln -s usr/lib lib

RUN mkdir -p /tmp/CrowdStrike/rootfs/etc/ssl/certs && \
    cp /etc/ssl/certs/ca-bundle* /tmp/CrowdStrike/rootfs/etc/ssl/certs

RUN chmod -R a=rX /tmp/CrowdStrike

# Add source image
FROM "teds2acr.azurecr.io/aci-vulapp:crwdv1"

# Copy built files from the previous stage
COPY --from=build /tmp/CrowdStrike /opt/CrowdStrike

# Update the entrypoint command
ENTRYPOINT ["/opt/CrowdStrike/rootfs/bin/falcon-entrypoint", "/entrypoint.sh"]
