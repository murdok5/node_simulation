declare -a arr=("centos7" "server2012r2" "win-2016" "ubuntu1404" "ubuntu1604" "copper" "mission" "sunset" "soma")
start_num=10
end_num=50

for i in "${arr[@]}"; do
  n=$start_num
  while [[ $n -lt $end_num ]]; do
    node="$i-$n.pdx.puppet.vm"
    echo "su - $node -c 'puppet agent -t'"
    ((n++))
  done
done
