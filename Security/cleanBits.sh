#!/bin/sh

for p in /bin/fusermount /bin/mount /bin/ping /bin/ping6 /bin/su /bin/umount \
  /usr/bin/bsd-write /usr/bin/chage /usr/bin/chfn /usr/bin/chsh \
  /usr/bin/mlocate /usr/bin/mtr /usr/bin/newgrp /usr/bin/pkexec \
  /usr/bin/traceroute6.iputils /usr/bin/wall /usr/sbin/pppd;
do
  if test -e $p; then
    oct=$(stat -c "%a" $p |sed 's/^4/0/')
    ug=$(stat -c "%U %G" $p)

      if test -e "$(which dpkg-statoverride)"; then
        dpkg-statoverride --remove "$p" 2> /dev/null
        dpkg-statoverride --add "$ug" "$oct" "$p" 2> /dev/null
      fi

    chmod -s $p
  fi
done
