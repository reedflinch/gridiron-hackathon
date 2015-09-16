#!/bin/bash
# Clean, pull, and run new Docker containers
ssh -o "StrictHostKeyChecking no" -tt -i /home/ec2-user/ChatOps.pem ec2-user@$EC2_BOX_DEV 'stty raw -echo; \
    cd /home/ec2-user/labelcraft/bin/; sudo bash /home/ec2-user/labelcraft/bin/cleanup.sh'
ssh -o "StrictHostKeyChecking no" -tt -i /home/ec2-user/ChatOps.pem ec2-user@$EC2_BOX_DEV 'stty raw -echo; \
    cd /home/ec2-user/labelcraft/; git pull'
ssh -o "StrictHostKeyChecking no" -tt -i /home/ec2-user/ChatOps.pem ec2-user@$EC2_BOX_DEV 'stty raw -echo; \
    cd /home/ec2-user/labelcraft/bin/; sudo bash /home/ec2-user/labelcraft/bin/build.sh'

#!/bin/bash 
# Pull automated tests, restart Xvfb, run tests [Serenity then bdd-security, stop Xvfb
ssh -o "StrictHostKeyChecking no" -tt -i /home/ec2-user/ChatOps.pem ec2-user@$EC2_SEL 'stty raw -echo; \
    cd /home/ec2-user/selenium_tests/webdriver; pwd; git pull' 
ssh -o "StrictHostKeyChecking no" -tt -i /home/ec2-user/ChatOps.pem ec2-user@$EC2_SEL 'stty raw -echo; \
    cd /home/ec2-user/selenium_tests/webdriver/labelcraft; \
    pkill Xvfb; \
    Xvfb :1 -screen 0 1280x768x24 & export DISPLAY=:1; sleep 10; \
    mvn clean verify; \
    cd /home/ec2-user/selenium_tests/webdriver/bdd-security; \
    ./runstory.sh app_scan; pkill Xvfb'

#!/bin/bash
# Copy test results to this Jenkins box, notify slackbot
mkdir target
scp -o "StrictHostKeyChecking no" -i /home/ec2-user/ChatOps.pem -r \
    ec2-user@52.2.25.224:/home/ec2-user/selenium_tests/webdriver/labelcraft/target/ ./target 
curl -X POST --data-urlencode 'payload={"channel": "#github", "username": "webhookbot", "text": \
    "Test '${BUILD_NUMBER}' results available at: '${BUILD_URL}'/artifact/target/target/site/serenity/index.html", 
    "icon_emoji": ":ghost:"}' https://hooks.slack.com/services/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
