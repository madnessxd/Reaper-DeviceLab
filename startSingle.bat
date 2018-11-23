SET x=%1
SET apk=%2
SET package=%3

adb -s %x% uninstall %package%
adb -s %x% install %apk%
adb -s %x% shell monkey -p %package% -c android.intent.category.LAUNCHER 1