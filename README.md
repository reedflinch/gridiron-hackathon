# Labelcraft "Mystery Site" (Hackathon Edition)!

## Requirement: SSH Client
For those on Windows boxes, try [GitBash](https://git-for-windows.github.io/) as a potential terminal.

## Your Ubuntu Environments / Local VMs
Each team has four Ubuntu EC2 instances. Alternatively, you're free to work using a local VirtualBox VM running Ubuntu (14.04 on our EC2s). You can get an Ubuntu .iso [here](http://www.ubuntu.com/download) and VirtualBox [here.](https://www.virtualbox.org/wiki/Downloads)

- To access your machine, use the certificate you received to SSH into the machine's public IP.
- Your DevOps solution may require your machines to talk to one another. Use each machine's private IP when referencing your team's other machines.

### Example EC2 session:
```shell
# You may have to run 
chmod 0400 HackTeamX.pem 
# in terminal/GitBash first. You'll only need to do this once.
ssh -i HackTeamX.pem ubuntu@[public_ip]
```

| Team 1 Public IPs      | Team 1 Private IPs       | Team 2 Public IPs      | Team 2 Private IPs       |
| :--------------------: |:------------------------:| :--------------------: |:------------------------:|
| 52.3.255.190           | 172.31.92.6      | 54.88.214.150          | 172.31.93.14      |
| 54.173.67.218          | 172.31.92.7      | 54.88.46.237           | 172.31.93.13      |
| 54.173.83.29           | 172.31.92.8      | 54.84.133.37           | 172.31.93.12      |
| 54.152.236.182         | 172.31.92.9      | 54.88.116.150          | 172.31.93.11      |


| Team 3 Public IPs      | Team 3 Private IPs       | 
| :--------------------: |:------------------------:|
| 54.175.37.207          | 172.31.93.25     | 
| 54.164.203.21          | 172.31.93.26      |
| 54.173.171.137          | 172.31.93.27     |
| 54.175.99.87        | 172.31.93.28    |

## Duplicating Repo  
You will need [Git][git] to make a duplicate of this repository. 


- Make a bare clone of the repository  
```	
	git clone --bare https://github.com/GridIron/hackathon
```
- Push to your new repository  
	- Must create repo on github first
```	
	cd hackathon.git  
	git push --mirror https://github.com/your-username/your-new-repo
```
- Remove our temporary local repository  
```	
	cd ..  
	rm -rf hackathon.git
```
- Now you can make a clone of your new repo  
```
	git clone https://github.com/your-username/your-new-repo
```


## Building the Front End

- Install nodeJS, npm, get certificate key, and get rid of NodeJS linking confusion:
```
	sudo apt-get update && sudo apt-get install -y npm nodejs
	gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
	sudo ln -s /usr/bin/nodejs /usr/bin/node
```

- Install rvm 
	- If you are running this locally, you'll need to switch to GuestWifi to get rvm
	- If you are using a VM, you will need to restart your VM after changing wifi
```
	# You probably don't need rdoc and ri, so let's not...
	echo 'gem: --no-rdoc --no-ri' >> ~/.gemrc
	curl -sSL -k https://get.rvm.io | bash -s stable --rails
	source /home/$USER/.rvm/scripts/rvm (command outputted from the previous command)
```
	
- Install ruby 2.2.2  
```
	rvm install ruby-2.2.2
```

- Check ruby version, and ensure version 2.2.2 is in use
```
	ruby -v
```

- If anything other than 2.2.2 use, you can change it by running
```
	rvm use 2.2.2
```		


- If getting the `rvm is not a function error`, follow the instructions [here][rvm]


- Install and set up bower, grunt, dependencies, compass
	- Run this command to make git replace the protocol for you, this prevents trouble with git when installing dependencies (firewall issue).
```
	git config --global url."https://".insteadOf git://
```
Move to the www directory `your-repo-name/www` and run the following:
```
	sudo apt-get install -y ruby-dev
	sudo npm install -g bower grunt

	bower install
	bower install grunt-cli
	
	# npm install will take 5-10 minutes...go get coffee
	sudo npm install
	sudo npm install -g grunt-cli
	gem install compass
```

	
#### Run the front-end  
- Run this from the www directory
	- If running ubuntu on EC2, a change will need to be made in Gruntfile.js. On line 84 change 'localhost' to '0.0.0.0', keeping the quotes
```
	grunt serve	
```

- If grunt serve is not working (not hanging), and you recieve errors try the following
```
	sudo rm -rf node_modules
	sudo npm install
	sudo gem install compass
	grunt serve
```
- The webpage appears at `localhost:9000` or `your-public-ip:9000`


## Building the Database and API
```
	sudo apt-get install -y postgresql postgresql-contrib
```

- Modify the `database.yml` file located at `your-repo-name/api/config/database.yml` 
```
  	development: &default  
  	adapter: postgresql  
  	database: ads_development  
  	encoding: utf8  
  	host: localhost  
  	min_messages: warning  
  	pool: 2  
  	timeout: 5000  
  	username: postgres						*add this line  
  	password:								*add this line  
```
- Modify the `pg_hba.conf` file located at `/etc/postgresql/9.3/main/pg_hba.conf` to look like below
	- The contents you need to modify are located at/near the bottom of the file (Shift+G in vim...)
	- You **MUST** use sudo to view and edit the file contents
```
	# Database administrative login by Unix domain socket
	local   all             postgres                                peer

	# TYPE  DATABASE        USER            ADDRESS                 METHOD

	# "local" is for Unix domain socket connections only
	local   all             all                                     trust
	# IPv4 local connections:
	host    all             all             127.0.0.1/32            trust
	# IPv6 local connections:
	host    all             all             ::1/128                 trust
```
- Refresh the file for postgres by using the psql terminal as postgres user  
```
	sudo -u postgres psql
	
	select pg_reload_conf();
	\q
```

- Move to the api directory (your-repo-name/api) and run the following commands to install rake, bundler, rails, and more dependencies
```
	sudo apt-get install -y rake libpq-dev
	gem install bundler
	sudo gem install rails

* Make sure ruby version is 2.2.2 (may have switched during install) if not follow the instructions above

	bundle install
```

- Create and migrate the database  
```
  	rake db:create db:migrate  
```

- Run the api (from api directory)
	- If running ubuntu on EC2, use  `rails s -b 0.0.0.0 -p 3000` 
```
	rails s
```		


[git]: https://git-scm.com/book/en/v2/Getting-Started-Installing-Git
[rvm]: https://rvm.io/integration/gnome-terminal
