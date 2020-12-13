# k8s-cluster

```bash
- control 
 |- worker1
 |- worker2 
```

spin ip up three node cluster

* requirements
```
vagrant
virtualbox
```
To spin up virtual machines 
```
./create-cluster.sh
```
Then login to each node run  as root respectively

`./kubernetes/setup-docker.sh`

`./kubernetes/setup-kubetools.sh`