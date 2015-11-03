FROM	rhel7.0

MAINTAINER Jim Rigsbee <jrigsbee@redhat.com>

ENV	HOME /var/www/html

RUN	yum --disablerepo=* \
--enablerepo="rhel-7-server-rpms" \
--enablerepo="rhel-7-server-extras-rpms" \
--enablerepo="rhel-7-server-optional-rpms" \
--enablerepo="rhel-server-rhscl-7-rpms" \
update -y && \
	yum --disablerepo=* \
--enablerepo="rhel-7-server-rpms" \
--enablerepo="rhel-7-server-extras-rpms" \
--enablerepo="rhel-7-server-optional-rpms" \
--enablerepo="rhel-server-rhscl-7-rpms" \
install -y --setopt=tsflags=nodocs \
httpd \
less \
openssl-devel \
procps-ng \
tar \
unzip \
wget \
which && \
    	yum clean all -y

ONBUILD	COPY ./src/ ${HOME}/ 

CMD	["httpd", "-D", "FOREGROUND"]
