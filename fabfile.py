from __future__ import with_statement
from fabric.api import local, settings, abort, run, cd
from fabric.contrib.console import confirm

def deploy():
    code_dir = '~/Ghost'
    with cd(code_dir):
        run("git pull")
        run("sudo docker build -t rymurr/ghost-cort .")

def run(host="localhost", port=4001):
    run("sudo docker run -p 2368 -d -e ETCDHOST=host -e ETCDPORT=port rymurr/ghost-cort")
