# brief7
Objectif : Déployer une infrastructure qui reçevra une VM avec un serveur Gitlab pour mettre en place un pipeline qui pilotera un cluster kubernetes composé d'une VM Kubernetes Master pour orchestrer une VM kubernetes Node. Dans la VM Kubernestes Node sera déployé un pod web_app(apllication de vote) et un pod Redis. L'infrastructure sera protégée par un bastion en ce qui concerne les accès d'administration des VM. En ce qui concerne l'accès publique à la web app, il se fera au travers d'une gateway. 

# Technologies utlisées :
    - déployement de l'infrastructure : terraform
    - 