date > /etc/vagrant_box_build_time

ntpdate 0.pool.ntp.org

export PACKAGESITE=ftp://ftp.freebsd.org/pub/FreeBSD/ports/amd64/packages-9-stable/Latest/
for i in sudo bash rubygem-chef puppet wget; do pkg_add -r $i ; done

# Install vagrant user
pw useradd -n vagrant -c "Vagrant User" -m
mkdir ~vagrant/.ssh
chmod 700 ~vagrant/.ssh
/usr/local/bin/wget --no-check-certificate 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' -O ~vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant /home/vagrant/.ssh/authorized_keys

# As FreeBSD's virtualbox guest additions do not support shared folders,
# we will use vagrant via NFS
echo 'rpcbind_enable="YES"' >> /etc/rc.conf
echo 'nfs_server_enable="YES"' >> /etc/rc.conf
echo 'mountd_flags="-r"' >> /etc/rc.conf

# Enable passwordless sudo
echo "vagrant ALL=(ALL) NOPASSWD: ALL" >> /usr/local/etc/sudoers
# Restore correct su permissions
# I'll leave that up to the reader :)

echo "=============================================================================="
echo "NOTE: FreeBSD - Vagrant"
echo "When using this basebox you need to do some special stuff in your Vagrantfile"
echo "1) Include the correct system"
echo "		require 'vagrant/systems/freebsd' "
echo "2) Add after your config.vm.box = ..."
echo "		  config.vm.system = :freebsd"
echo "3) Enable HostOnly network"
echo "	 config.vm.network ...."
echo "4) Use nfs instead of shared folders"
echo "		:nfs => true"
echo "============================================================================="

pkg_add -r virtualbox-ose-additions

echo 'vboxguest_enable="YES"' >> /etc/rc.conf
echo 'vboxservice_enable="YES"' >> /etc/rc.conf
