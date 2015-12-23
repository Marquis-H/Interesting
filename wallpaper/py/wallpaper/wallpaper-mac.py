__author__ = 'marquis'

import time
import subprocess
import os
import shutil


def set_wallpaper():
    location = os.environ['HOME']+'/Pictures/himawari8'
    if os.path.exists(location):
        shutil.rmtree(location)
    os.mkdir(location)
    # this my cwd
    subprocess.Popen("/usr/local/bin/scrapy crawl FindImages", shell=True)
    time.sleep(30)
    f_list = os.listdir(os.environ['HOME']+'/Pictures/himawari8')
    for img in f_list:
        picpath = '$HOME/Pictures/himawari8/'+img
        script = """/usr/bin/osascript<<END
                    tell application "Finder"
                    set desktop picture to POSIX file "%s"
                    end tell
                    END"""
        subprocess.call(script % picpath, shell=True)
    print 'Done.'

if __name__ == '__main__':
    while True:
        print "waiting..."
        set_wallpaper()
        time.sleep(600)