master="master.inf.puppet.vm"
# copy what will be pluginsync'd to non-root agents to avoid some overhead (still checksum overhead, but no file copy over network).
# we copy the lib and facts.d dirs
libcache="/tmp/libcache"

declare -a arr=("centos7" "server2012r2" "win-2016" "ubuntu1404" "ubuntu1604" "copper" "mission" "sunset" "soma")
start_num=10
end_num=50

for i in "${arr[@]}"; do
  n=$start_num
  while [[ $n -lt $end_num ]]; do
    node="$i-$n.pdx.puppet.vm"
    echo "useradd $node"
    echo "cd /home/$node"
    echo "su - $node -c 'mkdir -p .puppetlabs/etc/puppet'"
    echo "su - $node -c 'mkdir -p .puppetlabs/opt/puppet/cache'"
    echo "su - $node -c 'mkdir -p .puppetlabs/opt/puppet/cache/lib'"
    echo "su - $node -c 'mkdir -p .puppetlabs/opt/puppet/cache/facts.d'"
    echo "su - $node -c 'cp -R $libcache/lib .puppetlabs/opt/puppet/cache'"
    echo "su - $node -c 'cp -R $libcache/facts.d .puppetlabs/opt/puppet/cache'"
    echo "cd .puppetlabs/etc/puppet"
    echo "su - $node -c 'touch puppet.conf'"
    echo "echo \"server = $master\" >> puppet.conf"
    echo "echo \"certname = $node\" >> puppet.conf"
    echo "su - $node -c 'puppet agent -t'"
    ((n++))
  done
done
