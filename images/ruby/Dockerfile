FROM	rhel7.1

ENV 	RUBY_VERSION 2.2
ENV	HOME /opt/app-root/src
ENV 	GEM_HOME /usr/local/bundle
ENV 	PATH $GEM_HOME/bin:$PATH

RUN 	yum update -y && yum install -y --setopt=tsflags=nodocs tar less procps-ng unzip bsdtar rh-ruby22 rh-ruby22-ruby-devel rh-ruby22-rubygem-rake v8314 rh-ruby22-rubygem-bundler libcurl-devel libxml2-devel libxslt-devel mariadb-devel mariadb-libs openssl-devel postgresql-devel scl-utils sqlite-devel wget yum-utils which zlib-devel && \
    	yum clean all -y && \
     	mkdir -p ${HOME} && \
  	groupadd -r default -f -g 1001 && \
  	useradd -u 1001 -r -g appuser -d ${HOME} -s /sbin/nologin \
      -c "Application User" appuser && \
  	chown -R appuser:appuser /opt/app-root && \
	mkdir -p ${GEM_HOME}/bin

USER	appuser
WORKDIR	${HOME}
RUN 	echo 'gem: --no-rdoc --no-ri' >> "$HOME/.gemrc"

# throw errors if Gemfile has been modified since Gemfile.lock
RUN	bundle config —global frozen 1
ONBUILD	COPY Gemfile ${HOME}
ONBUILD	COPY Gemfile.lock ${HOME}
ONBUILD	RUN bundle install
ONBUILD	COPY . ${HOME} 

CMD	[“irb”]





