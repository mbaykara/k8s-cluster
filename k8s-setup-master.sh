#!/usr/bin/env bash

#set -Eeuo pipefail
#trap cleanup SIGINT SIGTERM ERR EXIT


IFNAME=$1
ADDRESS="$(ip -4 addr show $IFNAME | grep "inet" | head -1 |awk '{print $2}' | cut -d/ -f1)"
sed -e "s/^.*${HOSTNAME}.*/${ADDRESS} ${HOSTNAME} ${HOSTNAME}.local/" -i /etc/hosts

# remove ubuntu-bionic entry
sed -e '/^.*ubuntu-bionic.*/d' -i /etc/hosts
sed -i -e 's/#DNS=/DNS=8.8.8.8/' /etc/systemd/resolved.conf

# Update /etc/hosts about other hosts
cat >> /etc/hosts <<EOF
192.168.33.13 master
192.168.33.14 worker-1
192.168.33.15 worker-2
EOF

apt-get update 
apt-get install containerd -y

mkdir -p /etc/containerd
containerd config default  /etc/containerd/config.toml

#install kubectl
apt-get update &&  apt-get install -y apt-transport-https gnupg2 curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg |  apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" |  tee -a /etc/apt/sources.list.d/kubernetes.list
apt-get update
apt-get install -y kubelet kubeadm kubectl 
apt-get install bash-completion
echo 'source <(kubectl completion bash)' >>~/.bashrc
#source /usr/share/bash-completion/bash_completion
kubectl completion bash >/etc/bash_completion.d/kubectl

# Set iptables bridging
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo echo '1' > /proc/sys/net/ipv4/ip_forward
sudo sysctl --system


#load a couple of necessary modules 
sudo modprobe overlay
sudo modprobe br_netfilter
#disable swaping
#sed 's/#   /swap.*/#swap.img/' /etc/fstab
#sudo swapoff -a

service systemd-resolved restart