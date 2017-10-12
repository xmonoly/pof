#!/bin/bash
cd openvswitch-2.5.2
modprobe gre
ovs-dpctl del-dp ovs-system

rmmod datapath/linux/openvswitch.ko
insmod datapath/linux/openvswitch.ko
#make modules_install



#/sbin/modprobe openvswitch
mkdir -p /usr/local/etc/openvswitch
ovsdb-tool create /usr/local/etc/openvswitch/conf.db vswitchd/vswitch.ovsschema  2>/dev/null
ovsdb-server -v --remote=punix:/usr/local/var/run/openvswitch/db.sock --remote=db:Open_vSwitch,Open_vSwitch,manager_options --private-key=db:Open_vSwitch,SSL,private_key --certificate=db:Open_vSwitch,SSL,certificate --bootstrap-ca-cert=db:Open_vSwitch,SSL,ca_cert --pidfile --detach
ovs-vsctl --no-wait init
ovs-vswitchd --pidfile --detach
sh /usr/local/share/openvswitch/scripts/ovs-ctl restart
ps -ef|grep ovs
cd ..
