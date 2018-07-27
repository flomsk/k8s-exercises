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

<table>
    <tr>
        <td>service</td>
        <td>endpoint</td>
        <td>result</td>
    </tr>
    <tr>
        <td rowspan="2">countries v1.0.1</td>
        <td>/countries</td>
        <td>full list of countries</td>
    </tr>
    <tr>
        <td>/countries/&lt;qry&gt;</td>
        <td>to search by name \ iso code</td>
    </tr>
    <tr>
        <td rowspan="2">airports v1.0.1</td>
        <td>/airports</td>
        <td>full list of airports</td>
    </tr>
    <tr>
        <td>/airports/&lt;qry&gt;</td>
        <td>to get a list of airports based on country code (e.g.: "nl")</td>
    </tr>
    <tr>
        <td rowspan="3">airports v1.1.0</td>
        <td> /airports/&lt;id&gt; </td>
        <td>Returns the full information of an airport based on its identifier. E.g.: /airports/EHAM returns all information for Schiphol.</td>
    </tr>
    <tr>
        <td> /airports?full=[0|1]</td>
        <td> Returns a summary or all details of all airports, depending on the value of full.</td>
        </tr>
    <tr>
        <td>/search/&lt;qry&gt;</td>
        <td> Returns a list of airports based on a country code search.</td>
    </tr>
</table>

### Updating airports service to newer version:
1. `kubectl set image deployment airports airports=flomsk/airports:v1.1.0 -n airports-ns`
2. check status with: `kubectl rollout status deployment airports -n airports-ns`

### Cleaning up:
After you have played with services it's desirable to clean your laptop.
1. `kubectl delete ns airports-ns && kubectl delete ns countries-ns`
2. `minikube stop && minikube delete`
3. clear your entries in `/etc/hosts` file
