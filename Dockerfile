from ubuntu:latest

run apt-get update

# install node
run apt-get install -y python-software-properties python
run add-apt-repository ppa:chris-lea/node.js
run echo "deb http://us.archive.ubuntu.com/ubuntu/ precise universe" >> /etc/apt/sources.list
run apt-get update
run apt-get install -y nodejs

#install ruby
#run apt-get install -y ruby1.9.3

#install dependencies
#run gem install sass
#run gem install bourbon

add . /ghost

#run cd /ghost && npm install -g grunt-cli
run cd /ghost && npm install --production .
#run cd /ghost && npm install -g grunt-contrib-sass

# currently a warning for invalid chars, patching to fix

#run cd /ghost && sed -i '1s/^/@charset "UTF-8";\n/' ./core/client/assets/sass/layouts/errors.scss
#run cd /ghost && grunt init --force

volume /ghost/content/data

workdir /ghost
expose 2368

cmd ["npm", "start"]

