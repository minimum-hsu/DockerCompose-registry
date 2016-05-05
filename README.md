# About This Repo

Establish an Docker registry with TLS certificate and basic authentication (username/password).

# Pre-install

+ python
+ python pip
+ docker
+ docker-compose
+ git (to clone this repo)

# How-to-use

1. Command ```vi config``` to edit the following key-value pairs   
   ```
   DOMAIN=registry.example.com
   PORT=5000
   SUBJECT=/ST=Taiwan/L=Taipei/O=Company/OU=Unit
   ```   
   *DOMAIN* and *SUNJECT* are using in **openssl** request.   
   Default *PORT* is 5000. If you don't use default, please simultaneously update services -> registry -> ports in **docker-compose.yml**.
2. Command ```vi docker-compose.yml``` to edit *username/password* and *DNS*.   
   *username/password*: services -> registry -> auth -> command, change default value.   
   *DNS*: services -> registry -> dns, change to your DNS.
2. Execute ```./generate_certs.sh``` to generate server certificate.
3. Execute ```docker-compose up -d``` to launch Docker Registry.
4. Execute ```./deploy_certs.sh``` to set client certificate.

# Push/Pull Docker Images

1. Login registry   
   ```docker login registry.example.com:5000```
2. Push image   
   ```docker push registry.example.com:5000/hello-world```
3. pull image   
   ```docker pull registry.example.com:5000/hello-world```

# Note

* If you have no Docker image to test, you can ```docker pull hello-world``` from **Docker Hub**, and re-tag it using ```docker tag hello-world registry.example.com:5000/hello-world```.
* If you don't want basic authentication, delete the sections in **docker-compose.yml**  
  * services -> auth
  * services -> depends_on

