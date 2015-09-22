# labelcraft ( Hackathon edition )

### Duplicating Repo  

You will need [Git][git] to make a duplicate of this repository. 

Make a bare clone of the repository  
	
	% git clone --bare https://github.com/GridIron/hackathon.git

Mirror-push to your new repository  
	
	% cd hackathon.git  
	% git push --mirror https://github.com/your-username/your-new-repo.git

Remove our temporary local repository  
	
	% cd ..  
	% rm -rf hackathon.git 

Now you can make a clone of your new repo  
	
	% git clone https://github.com/your-username/your-new-repo.git 



### Build the Front End
move to the www directory (your-repo-name/www) and run the following commands

	% sudo apt-get update && sudo apt-get install -y npm nodejs

	% gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

Install rvm  (need to be on GuestWifi and restart VM)

	% \curl -sSL -k https://get.rvm.io | bash -s stable --rails
	% source /home/<username>/.rvm/scripts/rvm (command outputted from the previous command)

	
Install ruby 2.2.2  

	% rvm install ruby-2.2.2

Check ruby version  

	% ruby -v

If anything other than 2.2.2 use  

	% rvm use 2.2.2
		
* If getting rvm is not a funtion error, follow the instructions [here][rvm]

Continue running the following commands

	% sudo apt-get install ruby-dev
	% sudo ln -s /usr/bin/nodejs /usr/bin/node

	Make git replace the protocol for you (Fixes firewall issue)
	% git config --global url."https://".insteadOf git://

	% sudo npm install -g bower
	% sudo npm install -g grunt

	% bower install
	% bower install grunt-cli

	% sudo npm install
	% sudo npm install -g grunt-cli
	% gem install compass
	
Serve front-end  

	% grunt serve	

		**If running ubuntu on EC2, a change will need to be made in the Gruntfile. On line 84 change 'localhost' to '0.0.0.0', keeping the quotes**

###Build Database and API

	% sudo apt-get update -y && \
  	sudo apt-get install -y postgresql postgresql-contrib

Add to /api/config/databade.yml  

  	development: &default  
  	adapter: postgresql  
  	database: ads_development  
  	encoding: utf8  
  	host: localhost  
  	min_messages: warning  
  	pool: 2  
  	timeout: 5000  
  	username: postgres 						*add this line  
  	password:								*add this line  

Modify /etc/postgresql/9.3/main/pg_hba.conf file to look like below (at bottom of file) 

**MUST USE SUDO to view contents of this file**

	# Database administrative login by Unix domain socket
	local   all             postgres                                peer

	# TYPE  DATABASE        USER            ADDRESS                 METHOD

	# "local" is for Unix domain socket connections only
	local   all             all                                     trust
	# IPv4 local connections:
	host    all             all             127.0.0.1/32            trust
	# IPv6 local connections:
	host    all             all             ::1/128                 trust

Then go into the psql terminal as postgres user  

	% sudo -u postgres psql

Then type the following command to refresh  

	% select pg_reload_conf();
	% \q

Now move to the api directory (your-repo-name/api) and run the following commands  

	% sudo apt-get install rake
	% sudo gem install bundler

**Make sure ruby version is 2.2.2 before install of rails, if not follow the above instructions**  

	% gem install rails 
	% sudo apt-get install libpq-dev
	% bundle install

Then create and migrate the database  

  	% rake db:create  
  	% rake db:migrate  

 Run the api  

	% rails s
		
		** If running ubuntu on EC2, use  `rails s -b 0.0.0.0 -p 3000` **

[git]: https://git-scm.com/book/en/v2/Getting-Started-Installing-Git
[rvm]: https://rvm.io/integration/gnome-terminal
