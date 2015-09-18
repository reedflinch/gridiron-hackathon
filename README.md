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
move to the www directory (your-repo-name/www)

	% sudo apt-get update && sudo apt-get install -y git npm nodejs
	% sudo apt-get install -y build-essential chrpath git-core libssl-dev libfontconfig1-dev

	% sudo npm install -g bower
	% sudo npm install -g grunt-cli
	% sudo npm install -g grunt


##### add brightbox's repo, for ruby2.2
	% sudo apt-add-repository ppa:brightbox/ruby-ng
	% sudo apt-get -y update

##### install ruby2.2
	% sudo apt-get -y install ruby2.2 ruby2.2-dev bundler javascript-common

	% sudo gem install compass
	% sudo ln -s /usr/bin/nodejs /usr/bin/node
	% bower install --allow-root
	% sudo npm install
	% grunt dev

###Build Database GOOOOEEEESSSS HHHHHEEEEEERRRRR




###Build api
move to the api directory (your-repo-name/api)

	% sudo apt-get update -y && \
  	sudo apt-get install -y \
  	nodejs \
  	mysql-client \
  	postgresql-client \
  	sqlite3 \
  	--no-install-recommends && sudo rm -rf /var/lib/apt/lists/* 


	% sudo chown -R ubuntu:ubuntu /usr/local/bin
	% sudo chown -R ubuntu:ubuntu /var/lib/gems 
	% sudo apt-get update
	% sudo apt-get install libpq-dev
	% sudo gem install bundler

**May need to change line 3 of Gemfile from 2.2.2 to 2.2.3**  
	
	% bundle install

##### Run  
/bin/bash startup.sh

[git]: https://git-scm.com/book/en/v2/Getting-Started-Installing-Git

