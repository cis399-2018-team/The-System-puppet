# New install with Gunicorn
### Instructions:

#### Install and configure apache
- `sudo apt install apache`
- `sudo a2enmod proxy proxy_ajp proxy_http rewrite deflate headers proxy_balancer proxy_connect proxy_html`
- replace `/etc/apache2/sites-available/000-default.conf` with included `000-default.conf`

#### Create virtual env for flask app
- `sudo apt install python3-venv`
- copy `the-system-app/` dir to `/var/www/`
- In `the-system-app` dir type: `python3 -m venv env`
- `source env/bin/activate`
- `pip3 install -r requirements.txt`

#### Test with flask server
- `sudo python3 the-system.py`
- `deactivate` to exit the virtualenv

#### Test with gunicorn
- `gunicorn -c gunicorn.conf -b 0.0.0.0:5000 the-system:app`

#### Give folder permissions to your user
- `chown -R <uname>:<uname> /var/www/the-system-app/`

#### Create systemd service file for our app
- cp `the-system.service` file to `/etc/systemd/system/`
- in `the-system.service` enter your username where indicated
- `systemctl daemon-reload` to activate our .service file
- `systemctl enable the-system` to enable our app at boot
- `systemctl start the-system` to start the app
- `systemctl status the-system` to monitor the app

#### When making changes to files restart the service
- `systemctl restart the-system`


