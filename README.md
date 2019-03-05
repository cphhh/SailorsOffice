# README

## Steps for deployment in production with dokku on fresh linux server
### Server einrichten und Sicherheit
* `apt-get update`
* `apt-get upgrade`
* SSH Listening port ändern: `nano /etc/ssh/sshd_config` Restart service: `/etc/init.d/ssh restart`
* Edit ssh config: `sudo nano .ssh/config` Add new ssh connection:
```
Host SERVERNAME
HostName IP/URL
Port PORT
User USER
```
* Root pwd ändern: `passwd root`
* Add new user: `adduser NeuerBenutzername`
* Give sudo rights `usermod -aG sudo username`
* Root login verbieten: `nano /etc/ssh/sshd_config` `PermitRootLogin no`
* `apt-get install fail2ban`
* Evtl fail2ban config und iptables -L einschränken
* `/etc/init.d/ssh restart`

### Dokku installieren und App anlegen
* `wget https://raw.githubusercontent.com/dokku/dokku/v0.14.6/bootstrap.sh;`
`sudo DOKKU_TAG=v0.14.6 bash bootstrap.sh`
* `sudo dokku plugin:install https://github.com/dokku/dokku-postgres.git`
* `sudo dokku apps:create tintoapp`
* `dokku postgres:create tintoapp-database`
* `dokku postgres:link tintoapp-database tintoapp`
* From local machine:
```
git remote add dokku dokku@SERVER:tintoapp
git push dokku master
```
*  `dokku domains:add tintoapp tintoapp.bischof.dk`
* `sudo dokku plugin:install https://github.com/dokku/dokku-letsencrypt.git`
* `dokku config:set --no-restart tintoapp DOKKU_LETSENCRYPT_EMAIL=ADRESSE`
* `dokku letsencrypt tintoapp`
* `dokku letsencrypt:cron-job --add `
* `dokku postgres:import tintoapp-database < "/home/USER/latest.dump"`

### ENV-Variablen
* `dokku config:set tintoapp SLACK_SECRET=**********`
* `dokku config:set tintoapp TB_PASS=PASS`
* `dokku config:set tintoapp TB_NAME=EMAIL`

### Backup db
* ´ssh-keygen -o`
* Add ssh key to backup server: `cat ~/.ssh/id_rsa.pub | ssh scalewaycnmp 'cat >> .ssh/authorized_keys'`

* Run bash script in crontab with `bash dbbackup.sh` Script:
```bash
name=$(date -d "today" +"%Y%m%d")
dokku postgres:export tintoapp-database > "/home/USER/$name.dump"
scp "$name.dump" USER@SERVER:/home/USER/tintoappbackup/
```
