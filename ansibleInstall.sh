pveam update
pveam download local ubuntu-22.04-standard_22.04-1_amd64.tar.gz

pct create 100 local:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst \
    --cores 1 --cpuunits 1024 \
    --memory 4096 --swap 0 \
    --description Ansible \
    --rootfs local-lvm:25 \
    --hostname server.ansible \
    --net0 name=eth0,ip=192.168.1.100/24,bridge=vmbr0,gw=192.168.1.1 \
    --ostype ubuntu \
    --storage local-lvm \
    --password Chip086pit535hips$ \
    --onboot 1
    
pct exec 100 apt install python3-pip -y
pct exec 100 pip install ansible
pct exec 100 mkdir -p /etc/ansible/
pct exec 100 cd /etc/ansible
pct exec 100 touch hosts
pct exec 100 echo "[myvirtualmachines]" >> hosts
ip4=$(/sbin/ip -o -4 addr list eth0 | awk '{print $4}' | cut -d/ -f1)
pct exec 100 echo $ip4 >> hosts
#ansible all --list-hosts
pct exec 100 touch ansible.cfg
pct exec 100 ssh-keygen -t rsa -f /root/.ssh/id_rsa -q -P ""
pct mount 100
cp /var/lib/lxc/100/rootfs/root/.ssh/id_rsa.pub ~/.ssh/authorized_keys
#ansible all -m ping
