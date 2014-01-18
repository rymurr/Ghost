from ubuntu:latest

run echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
run apt-get update
run apt-get install -y build-essential 
run apt-get install -y python python-dev python-setuptools
run apt-get install -y curl 
run apt-get install -y openssh-server
run mkdir /var/run/sshd
run easy_install pip
run pip install setuptools --no-use-wheel --upgrade
run pip install boto


# install node
run apt-get install -y python-software-properties python
run add-apt-repository ppa:chris-lea/node.js
run echo "deb http://us.archive.ubuntu.com/ubuntu/ precise universe" >> /etc/apt/sources.list
run apt-get update
run apt-get install -y nodejs

#install ruby
run apt-get install -y ruby1.9.3

#install dependencies
run gem install sass
run gem install bourbon

add . /ghost

run cd /ghost && npm install -g grunt-cli
run cd /ghost && npm install .
run cd /ghost && npm install -g grunt-contrib-sass

# currently a warning for invalid chars, patching to fix

run cd /ghost && sed -i '1s/^/@charset "UTF-8";\n/' ./core/client/assets/sass/layouts/errors.scss
run cd /ghost && grunt init --force

volume /ghost/content/data

workdir /ghost
expose 2368

cmd ["bash", "runApp.sh"]

