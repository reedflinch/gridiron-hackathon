FROM ubuntu: 14.04
RUN mkdir /usr/src/app
RUN mkdir /usr/src/app/client
RUN WORKDIR /usr/src/app/cliet
RUN sudo apt-get update && sudo apt-get install -y npm nodejs
RUN sudo apt-get install -y ruby-dev
RUN sudo npm install -g bower grunt
COPY bower.json /usr/src/app/client
RUN bower install --allow -root
COPY package.json /usr/src/app/client
RUN bower install grunt-cli
RUN sudo npm install
RUN sudo npm install -g grunt-cli
RUN gem install compass
COPY Gruntfile.js /urs/src/app/client
RUN grunt serve
COPY . /usr/src/app/client
EXPOSE 9000

