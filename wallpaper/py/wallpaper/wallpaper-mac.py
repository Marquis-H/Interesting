__author__ = 'marquis'

import time
import subprocess
import os


def set_wallpaper():
    location = "$HOME/Pictures/himawari8"
    if os.path.exists(location) == 0:
        subprocess.call("mkdir -p $location", shell=True)
    # subprocess.call("rm -rf $location/*", shell=True)
    subprocess.call("scrapy crawl FindImages", shell=True)
    time.sleep(30)
    for filenames in os.walk(location):
        for filename in filenames:
            picpath = filename
    script = """/usr/bin/osascript<<END
                tell application "Finder"
                set desktop picture to POSIX file "%s"
                end tell
                END"""
    subprocess.call(script%picpath, shell=True)
    print 'Done.'

if __name__ == '__main__':
    while True:
        print "waiting..."
        set_wallpaper()
        time.sleep(600)