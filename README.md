[![Build Status](https://travis-ci.com/rgdevops123/devopswebhku.svg?branch=master)](https://travis-ci.com/rgdevops123/devopswebhku)
[![Coverage Status](https://coveralls.io/repos/github/rgdevops123/devopswebhku/badge.svg?branch=master)](https://coveralls.io/github/rgdevops123/devopswebhku?branch=master)

# devopswebhku
### Dev Ops Web No Login on Heroku.

### Get the code from GITHUB

    $ git clone https://github.com/rgdevops123/devopswebhku.git
    $ cd devopswebhku


### Install Python 3.6.8

    On Ubuntu 18, Python 3.6.8 is preinstalled.


### Install Requirements

    $ sudo /usr/bin/pip3 install -r requirements.txt

 
### ============================================
### Running th Application

### Create a .env.sh file for flask and gunicorn.

    $ vim .env.sh
    export DEVOPSWEB_CONFIG_MODE=Production
    export SECRET_KEY='your-secret-key'
    export SQLALCHEMY_TRACK_MODIFICATIONS=False


### Create a .env file for docker-compose and docker --env-file option.
    $ vim .env
    DEVOPSWEB_CONFIG_MODE=Production
    SECRET_KEY=your-secret-key
    SQLALCHEMY_TRACK_MODIFICATIONS=False


### Source your devopsweb profile file commands "flask" and "gunicorn".

    $ . ./.env.sh


### Set FLASK APP
    $ export FLASK_APP=devopswebhku.py
        OR
    $ export FLASK_APP=./devopswebhku.py
        OR
    $ export FLASK_APP=/FULL_PATH_TO/devopswebhku.py


### Run the Application
       Using gunicorn.
    $ /usr/local/bin/gunicorn --bind 0.0.0.0:5000 devopswebhku:app

       Using flask.
    $ flask run --host=0.0.0.0 --port=5000

       Using docker.
    $ sudo docker build . -t rgdevops123/devopswebhku
    $ sudo docker run --env-file .env -d --rm --name devopswebhku -p 5000:5000 rgdevops123/devopswebhku
        --env-file .env      ### Use .env environment file.
        -d                   ### Detached mode: Run the container in the background.
        --rm                 ### Automatically remove the container when it exits.
        --name devopswebhku  ### Name the Docker container devopswebhku.
        -p 5000:5000         ### Publish a container's port. hostPort:containerPort

       Using Heroku.
    $ heroku auth:login -i
    $ sudo heroku container:login
    $ sudo heroku container:push web --app=devopswebnl
    $ sudo heroku stack:set container --app devopswebnl
    $ sudo heroku container:release web --app=devopswebnl
    
           Tail logs.
    $ sudo heroku logs --tail --app=devopswebnl


### ============================================
### Run Tests
    $ pytest -v --disable-pytest-warnings
       -v                          ### Verbose
       --disable-pytest-warnings   ### Disable pytest warnings.

    $ pytest -k unittests
       -k <substring>              ### Only run tests with substring. 
    $ nose2 -v
       -v                          ### Verbose

### ============================================
### Run coverage.py testing 123
    $ coverage run --source=./app -m pytest -v --disable-pytest-warnings
    $ coverage report
    $ coverage html

