# README

Exam APP


* Dependencies

ruby 3.0

nodejs > 12

* Database initialization
```
rake db:create db:migrate


# load fixtures for demo
rake db:fixtures:load

or

# only create a default admin account
rake db:seed


```



* Deployment instructions
```
1. setup ssh login with public keys

2. generate ssh key, and add the public key to your github/gitlab account

3. install nginx, nodejs, git, etc.

4. configure firewall, allow HTTP

5. install rvm, install ruby-3.0

5. copy configurations
copy puma-exam-app to systemd service
copy nginx.conf

6. create app directory
mkdir -P /var/www/exam_app
chown ubuntu:ubuntu -R /var/www/exam_app

7. capistrano
capistrano production deploy

https://github.com/puma/puma/blob/master/docs/nginx.md

further setup:
 Logrotate
```
