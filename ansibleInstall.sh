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
pct start 100
pct enter 100
apt install python3-pip -y
pip install ansible
mkdir -p /etc/ansible/
touch ansible.cfg
ssh-keygen -t rsa -f /root/.ssh/id_rsa -q -P ""
exit
touch hosts
echo "[myvirtualmachines]" >> hosts
ip4=$(/sbin/ip -o -4 addr list vmbr0 | awk '{print $4}' | cut -d/ -f1)
echo $ip4 >> hosts
pct mount 100
cp hosts /var/lib/lxc/100/rootfs/etc/ansible/hosts
cp /var/lib/lxc/100/rootfs/root/.ssh/id_rsa.pub ~/.ssh/authorized_keys
pct unmount 100
#pct exec 100 ansible all --list-hosts
#pct exec 100 ansible all -m ping
