from __future__ import with_statement
from fabric.api import local, settings, abort, run, cd
from fabric.contrib.console import confirm

def deploy(user='ryan'):
    code_dir = '~/Ghost'
    with cd(code_dir):
        run("git pull")
        run("git checkout " + user)
        run("sudo docker build -t rymurr/ghost-cort .")

def rundocker(host="localhost", port=4001):
    run("sudo docker run -p 2368 -p 22 -d -e ETCDHOST="+host+" -e ETCDPORT="+str(port)+" rymurr/ghost-cort")
