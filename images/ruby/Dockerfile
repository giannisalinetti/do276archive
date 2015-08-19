FROM	rhel7.1

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
procps-ng \
rh-ruby22 \
rh-ruby22-ruby-devel \
rh-ruby22-rubygem-rake \
rh-ruby22-rubygem-bundler \
scl-utils \
sqlite-devel \
tar \
unzip \
v8314 \
wget \
which \
zlib-devel && \
    	yum clean all -y && \
	mkdir -p /opt/app-root && \
  	groupadd -r appuser -f -g 1001 && \
  	useradd -u 1001 -r -g appuser -m -d ${HOME} -s /sbin/nologin \
-c "Application User" appuser && \
  	chown -R appuser:appuser /opt/app-root && \
	mkdir -p ${GEM_HOME}/bin && \
	mkdir -p /etc/profile.d
ADD	./enablerh-ruby22.sh /etc/profile.d/

USER	appuser
WORKDIR	${HOME}
RUN 	echo 'gem: --no-rdoc --no-ri' >> "$HOME/.gemrc" && \
	scl enable rh-ruby22 'bundle config --global path "$GEM_HOME"' && \
	scl enable rh-ruby22 'bundle config --global bin "$GEM_HOME/bin"' 

# throw errors if Gemfile has been modified since Gemfile.lock
#RUN	bundle config —global frozen 1
ONBUILD	COPY Gemfile ${HOME}/
ONBUILD	COPY Gemfile.lock ${HOME}/
ONBUILD	RUN bundle install
ONBUILD	COPY . ${HOME}/ 

CMD	["irb"]
