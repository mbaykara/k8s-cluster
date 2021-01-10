# k8s-cluster



spin up three node cluster

Details description see [here](https://medium.com/p/99a82605bfcc/edit)

* requirements
```
vagrant
virtualbox
```

Fire up vms
``` 
vagrant up
```
To access each machine respectively via 
```
vagrant ssh master
```
in master node

```
1. set root password
2. switch root account
3. kubeadm init --apiserver-advertise-address 192.168.33.13 --pod-network-cidr=10.244.0.0/16
4. remove --port 0 from /etc/kubernetes/manifests/kube-[controller-api| scheduler].yaml
5. join workers to master node
```
for workers
```
vagrant ssh [worker1|worker2]
```