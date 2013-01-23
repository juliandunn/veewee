#!/bin/sh

date > /etc/vagrant_box_build_time

VBOX_VERSION=$(cat /home/vagrant/.vbox_version)

yum -y update

yum -y install \
  ruby \
  ruby-devel \
  puppet \
  rubygems \
  rubygem-bunny \
  rubygem-erubis \
  rubygem-highline \
  rubygem-json \
  rubygem-mime-types \
  rubygem-net-ssh \
  rubygem-polyglot \
  rubygem-rest-client \
  rubygem-systemu \
  rubygem-treetop \
  rubygem-uuidtools \
  wget \
  tar \
  bzip2

gem install chef --no-rdoc --no-ri

/sbin/service sshd stop && /sbin/reboot

# EOF
