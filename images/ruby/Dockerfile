FROM	rhel7.2

MAINTAINER Jim Rigsbee <jrigsbee@redhat.com>

ENV 	RUBY_VERSION 2.2
ENV	HOME /opt/app-root/src
ENV 	GEM_HOME /usr/local/bundle
ENV 	PATH $GEM_HOME/bin:$PATH

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
bsdtar \
less \
libcurl-devel \
libxml2-devel \
libxslt-devel \
mariadb-devel \
mariadb-libs \
openssl-devel \
postgresql-devel \
gcc \
make \
binuils \
procps-ng \
rh-ruby22 \
rh-ruby22-ruby-devel \
rh-ruby22-rubygems \
rh-ruby22-rubygem-rake \
rh-ruby22-rubygem-bundler \
rh-ruby22-rubygem-json \
scl-utils \
sqlite-devel \
tar \
unzip \
v8314 \
wget \
which \
zlib-devel && \
    	yum clean all -y

RUN	mkdir -p /opt/app-root && \
  	groupadd -r appuser -f -g 1001 && \
  	useradd -u 1001 -r -g appuser -m -d ${HOME} -s /sbin/nologin \
-c "Application User" appuser && \
  	chown -R appuser:appuser /opt/app-root && \
	chmod -R 755 /opt/app-root && \
	mkdir -p ${GEM_HOME}/bin && \
	chmod -R 755 ${GEM_HOME} && chown -R appuser:appuser ${GEM_HOME}
ADD	./enablerh-ruby22.sh /etc/profile.d/

USER	appuser
WORKDIR	${HOME}
RUN 	echo 'gem: --no-rdoc --no-ri' >> "$HOME/.gemrc" 
# chaging bundle config breaks json gem
#RUN 	echo 'gem: --no-rdoc --no-ri' >> "$HOME/.gemrc" && \
#	scl enable rh-ruby22 'bundle config --global path "$GEM_HOME"' && \
#	scl enable rh-ruby22 'bundle config --global bin "$GEM_HOME/bin"' 

# throw errors if Gemfile has been modified since Gemfile.lock
#RUN	bundle config —global frozen 1

#ONBUILD	COPY Gemfile ${HOME}/
#ONBUILD	RUN scl enable rh-ruby22 'bundle install'
#ONBUILD	COPY . ${HOME}/ 

ONBUILD	COPY run.sh build ${HOME}/
ONBUILD	RUN scl enable rh-ruby22 'bundle install'

CMD	["irb"]
