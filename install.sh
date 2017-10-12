#!/bin/bash
#unzip openvswitch-2.3.1.zip
chmod -R 777 openvswitch-2.5.2
cd openvswitch-2.5.2
#rm -r .git*
#rm -r .tags*
#rm -r .*
ps -ef|grep ovs|grep -v grep|cut -c 9-15|xargs kill -9 
./configure --with-linux=/lib/modules/$(uname -r)/build
make clean
make  && make install
cd ..
