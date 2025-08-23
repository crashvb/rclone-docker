FROM crashvb/cron:202508010209@sha256:f4694d450ffdd0bed1368933be20a5892021f4ac86848f5353665595fa4b93bb
ARG org_opencontainers_image_created=undefined
ARG org_opencontainers_image_revision=undefined
LABEL \
	org.opencontainers.image.authors="Richard Davis <crashvb@gmail.com>" \
	org.opencontainers.image.base.digest="sha256:f4694d450ffdd0bed1368933be20a5892021f4ac86848f5353665595fa4b93bb" \
	org.opencontainers.image.base.name="crashvb/supervisord:202508010209" \
	org.opencontainers.image.created="${org_opencontainers_image_created}" \
	org.opencontainers.image.description="Image containing rclone." \
	org.opencontainers.image.licenses="Apache-2.0" \
	org.opencontainers.image.source="https://github.com/crashvb/rclone-docker" \
	org.opencontainers.image.revision="${org_opencontainers_image_revision}" \
	org.opencontainers.image.title="crashvb/rclone" \
	org.opencontainers.image.url="https://github.com/crashvb/rclone-docker"

# Install packages, download files ...
RUN docker-apt jq rclone

# Configure: rclone
ENV \
	CRONTAB_ENVSUBST_RCLONE="\${RCLONE_SCHEDULE} root exec /bin/bash -c \". /etc/profile; /usr/local/bin/rclone-token-refresh >>/var/log/cron.log 2>&1\"" \
	RCLONE_CONFIG=/etc/rclone \
	RCLONE_DATA=/var/lib/rclone \
	RCLONE_SCHEDULE="*/15 * * * *"
COPY cron.rclone /etc/cron.daily/rclone
COPY crontab /etc/crontab
COPY logrotate.rclone /etc/logrorate.d/rclone
COPY rclone-* /usr/local/bin/
RUN install --directory --group=root --mode=0755 --owner=root "${RCLONE_CONFIG}"

# Configure: profile
RUN echo "export RCLONE_CONFIG=\"${RCLONE_CONFIG}\"" > /etc/profile.d/rclone.sh && \
	chmod 0755 /etc/profile.d/rclone.sh

# Configure: entrypoint
COPY entrypoint.rclone /etc/entrypoint.d/rclone

VOLUME "${RCLONE_CONFIG}" "${RCLONE_DATA}"
