<h1 align="left">Holla Amigos !</h1>

![Logos](/assets/image/docker-logo.png)

Deployment, Integration and Testing in software development are the important parts of Software Development Life Cycle. Imagine your engineer build some application but the tester have different system, different tools. It makes the application maybe got error or some issues because the differences of many aspect especially in technical side like environment, tools or etc


But using Docker, you can quickly deploy and scale applications into any environment and know your code will run. So the engineer can focus on the code side without worry about 
development environment

## Install Docker
<ol>
  <li>First you can download the installer from

[Docker Official Website ](https://www.docker.com/products/docker-desktop/) and then choose your current system. You can choose between Linux, Windows or Mac
![Logos](/assets/image/docker-1.png)
  </li>
  <li>
The installer will be downloaded and run the installer with click twice at the installer

![Logos](/assets/image/docker-2.png)
  </li>
  <li>
If the Configuration showing up, checklist the WSDL 2 and also with the shortcut

![Logos](/assets/image/docker-3.png)
  </li>
  <li>
Wait until instalation process finish

![Logos](/assets/image/docker-4.png)
  </li>
  <li>
If installation success, you need to restart your pc to complete the installation process

![Logos](/assets/image/docker-5.png)
![Logos](/assets/image/wsl-3.png)
  </li>
</ol>


## INSTALL WSL

Docker use WSL (Windows Subsystem for Linux) for creating separate virtual machine from main environment. So Docker can run separately with main environment.

Run CMD or Powersheel using administrator right. And then type

```cmd
wsl --install
```

![Logos](/assets/image/wsl-1.png)

By default, the wsl install Ubuntu Linux distro. 
Restart your computer to finish installation at your system. 
Open your docker, and the Docker Desktop interface will shown up

![Logos](/assets/image/wsl-2.png)

## DOCKERIZING NODEJS APP

<ol>
  <li>
  Create app.js file and add the source code. For example, i use simple Hello World NodeJS application


```js
const http = require('http')

const hostname = '0.0.0.0'
const port = 3000;

const server = http.createServer((req, res) => {
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain')
  res.end('Hello world')
})

server.listen(port, hostname, () => {
  console.log('server running')
})
```
Simple explanation is we create server from http module and make 'Hello World' response from server
  </li>
  <li>
Then create the Dockerfile
 
  > Dockerfile is a text document that contains all the commands a user could call on the command line to assemble an image. This page describes the commands you can use in a Dockerfile.

So the simple explanation is we can create custom docker image using Dockerfile.

```js
# Menggunakan base image node:14
FROM node:14
# Membuat directory app, setting working directory
WORKDIR /usr/src/app
# Bundle source
COPY package*.json app.js ./
# Menginstal dependency
RUN npm install
# Expose port (for documentation)
EXPOSE 3000
# Run the app
CMD [ "node", "app.js"]

```

We using base images from node version 14

```js
# Menggunakan base image node:14
FROM node:14
```

Then we set the directory app when building the docker image

```js
# Membuat directory app, setting working directory
WORKDIR /usr/src/app
```

Docker will copy package.json from current directory to root directory docker images

```js
# Bundle source
COPY package*.json app.js ./
```

Then the docker will run npm install to install all dependecies
So we don't need to install nodejs in local pc / machine

```js
# Menginstal dependency
RUN npm install
```

Set the application port to 3000

```js
# Expose port (for documentation)
EXPOSE 3000
```

Then run the app 
```js
# Run the app
CMD [ "node", "app.js"]
```
it's similar to npn run app.js if we using terminal in nodejs

  </li>
  <li>
  Then we create the .dockerignore file

  > .dockerignore helps to avoid unnecessarily sending large or sensitive files and directories to the daemon and potentially adding them to images using ADD or COPY.

In this case, we use dockerignore to avoid assets, git and cache folder from building images

```js
#ignore .git and .cache folders
.git
.cache
.assets

#ignore all markdown files (md)
*.md
```
  </li>
  <li>
  Then we run command for building images

  ```js
  docker build -t images_name
  ```
  The process will show like below

  ```
PS D:\Tutorial\dockernode> docker build -t dockernode/demoapp:1.0 .
[+] Building 205.8s (10/10) FINISHED                                                                                                                      docker:default
 => [internal] load .dockerignore                                                                                                                                   4.6s
 => => transferring context: 137B                                                                                                                                   0.2s 
 => [internal] load build definition from Dockerfile                                                                                                                5.5s
 => => transferring dockerfile: 336B                                                                                                                                0.0s
 => [internal] load metadata for docker.io/library/node:14                                                                                                         28.5s
 => [auth] library/node:pull token for registry-1.docker.io                                                                                                         0.0s
 => [1/4] FROM docker.io/library/node:14@sha256:a158d3b9b4e3fa813fa6c8c590b8f0a860e015ad4e59bbce5744d2f6fd8461aa                                                    0.1s
 => [internal] load build context                                                                                                                                   2.2s 
 => => transferring context: 969B                                                                                                                                   0.1s
 => CACHED [2/4] WORKDIR /usr/src/app                                                                                                                               0.0s 
 => [3/4] COPY package*.json app.js ./                                                                                                                              4.0s 
 => [4/4] RUN npm install                                                                                                                                         147.5s 
 => exporting to image                                                                                                                                              5.7s 
 => => exporting layers                                                                                                                                             4.9s 
 => => writing image sha256:22b8a9242d616b07d447c28c5793076e8fe6b4573f70144a624dc65f955eb362                                                                        0.2s 
 => => naming to docker.io/dockernode/demoapp:1.0                                                                                                                   0.5s 

What's Next?
  View summary of image vulnerabilities and recommendations → docker scout quickview

  ```
  </li>
  <li>
  Then we can check our custom docker images using
  
  ```
  docker images

REPOSITORY                 TAG       IMAGE ID       CREATED         SIZE  
dockernode/demoapp         1.0       22b8a9242d61   3 minutes ago   912MB 
examplenode                latest    75f436586bf6   3 hours ago     912MB 
experimentimages           latest    75f436586bf6   3 hours ago     912MB 
<none>                     <none>    02e7b260db8b   38 hours ago    915MB 
mysql                      latest    7c5ae0d3388c   3 days ago      577MB 
docker/welcome-to-docker   latest    912b66cfd46e   5 weeks ago     13.4MB
mysql/mysql-server         latest    1d9c2219ff69   6 months ago    496MB   
  ```

  We can see that our custom image are done creatly ( dockernode/demoapp)
  </li>
  <li>
  Run the images 
  
  ```
  docker run -d -p 3000:3000 --name container_name  image_name
  ```

  In this case, i using

  ```
  docker run -d -p 3000:3000 --name week6  dockernode/demoapp:1.0
  ```
  Now we go to Docker Desktop to check if our container is running or not

  ![Logos](/assets/image/desktop-1.png)

  We can see that our container is running and we can go to the web browser if the image work properly or not

  ![Logos](/assets/image/desktop-2.png)

  Voila! The images run properly from the browser
  </li>

</ol>


## Reach Me Out
[![Linkedin Badge](https://img.shields.io/badge/-Ade_Kresna_D-blue?style=flat-square&logo=Linkedin&logoColor=white)](https://www.linkedin.com/in/ade-kresna-dewantara/)
[![Gmail Badge](https://img.shields.io/badge/-kresnafti2013@gmail.com-c14438?style=flat-square&logo=Gmail&logoColor=white)](mailto:kresnafti2013@gmail.com)