#!/usr/bin/env python
"""
Author: Soumya Kumar
Created: 08/18/2017
Modified: 02/27/2018
Modified: 05/11/2018
"""

import os, subprocess, datetime, time

archive = 'backup-' + time.strftime('%d-%m-%Y') + '.zip'

files = [
    '~/.bashrc',
    '~/.bash_aliases',
    '~/.bash_logout',
    '~/.bash_profile',
    '~/.gitconfig',
    '~/.vimrc',
    '~/.local',
    '~/bin'
]

year = (str)(datetime.datetime.now().year)

os.chdir('/home/skumar/backup');
if not os.path.exists(year):
    os.makedirs(year)
os.chdir(year)

subprocess.call('zip -r ' + archive + ' ' + ' '.join(files), shell=True);

