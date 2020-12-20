#!/bash/bin

apt-get update 
apt-get install containerd -y
Configure containerd and start the service with the commands:

mkdir -p /etc/containerd
containerd config default  /etc/containerd/config.toml

#install kubectl
apt-get update &&  apt-get install -y apt-transport-https gnupg2 curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg |  apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" |  tee -a /etc/apt/sources.list.d/kubernetes.list
apt-get update
apt-get install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
apt-get install bash-completion
echo 'source <(kubectl completion bash)' >>~/.bashrc
#source /usr/share/bash-completion/bash_completion
kubectl completion bash >/etc/bash_completion.d/kubectl
# Set iptables bridging

echo 'net.bridge.bridge-nf-call-iptables = 1' >> /etc/sysctl.d/k8s.conf
sysctl --system

#load a couple of necessary modules 
sudo modprobe overlay
sudo modprobe br_netfilter
#disable swaping
sed 's/#   /swap.*/#swap.img/' /etc/fstab
sudo swapoff -a
