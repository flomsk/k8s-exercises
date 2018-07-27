# Airports and Countries Services
### Pre-install steps:
1. Install latest [minikube](https://github.com/kubernetes/minikube) release on your laptop.
2. Install latest [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) tool on your laptop.
3. Set the memory size for minikube VM to at least 4GB `minikube config set memory 4096`
4. Start the minikube `minikube start`
5. Enable ingress in minikube `minikube addons enable ingress`

### Notes:
* There are Dockerfiles in this repo which building apps with following step, eg. `ADD airports-assembly-1.0.1.jar app.jar`. For objective reasons, I do not push these jars to the repo. 
* Since in the minikube ingress is enabled as an addon, the nginx-ingress-controller automatically exposes 80 and 443 ports (and not 8000).
* Docker images are available at my [docker hub page](https://hub.docker.com/r/flomsk). But of course You can take as a basis my Dockerfile and release image anywhere.

### Your next steps:
- You can start bash script `start.sh` for startup of initial stack.
- You can start your services by yourself. **Recommended:** use kubectl [auto-completion](https://kubernetes.io/docs/tasks/tools/install-kubectl/#enabling-shell-autocompletion)
  - Create namespaces
  - Apply service.yaml + ing-service.yaml
  - Check API endpoints: **countries.example.com** - for countries service; **airports.example.com** - for airports service

### Updating airports service to newer version:
1. `kubectl set image deployment airports airports=flomsk/airports:v1.1.0 -n airports-ns`
2. check status with: `kubectl rollout status deployment airports -n airports-ns`

### Cleaning up:
After you have played with services it's desirable to clean your laptop.
1. `kubectl delete ns airports-ns && kubectl delete ns countries-ns`
2. `minikube stop && minikube delete`
3. clear your entries in `/etc/hosts` file
