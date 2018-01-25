Did not install fsnotifier but updated vmoptions

ln -s ~/.personal/intellij/bin-linux-fsnotifier64 fsnotifier

The default is 8192. 16384 is good, 32768 is probably more than enough.
 sysctl -w fs.inotify.max_user_watches=16384

http://duncandevore.blogspot.com/2013/11/intellij-on-mavericks-without-java-1.html
