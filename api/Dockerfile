FROM ruby:2.2.2

RUN echo 'gem: --no-rdoc --no-ri' >> ~/.gemrc
RUN curl -sSL -k https://get.rvm.io | bash -s stable --rails

RUN git config --global url."https://".insteadOf git://

RUN sudo apt-get install -y rake libpq-dev
RUN gem install bundler
RUN sudo gem install rails
RUN rails s
