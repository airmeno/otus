#/bin/bash
# nice

time nice -n -20 su -c "dd if=/dev/zero of=/tmp/nice1.img bs=1M count=1024" &  
time nice -n 19 su -c "dd if=/dev/zero of=/tmp/nice2.img bs=1M count=1024" &