SET x=%1
SET apk=%2
SET package=%3

adb -s %x% uninstall %package%
adb -s %x% install %apk%

::GEEN TEST
::adb -s %x% shell monkey -p %package% -c android.intent.category.LAUNCHER 1

::TEST SCRIPT
START "record" /D "D:\mendixhub\Reaper-DeviceLab" record %x%
::echo %x:~0,-5%

::adb -s %x% shell screenrecord /sdcard/%x:~0,-5%.mp4
adb -s %x% shell am instrument -w -r   -e debug false -e class 'com.coop.app.ProductScannerTest' com.coop.app.debug.test/android.support.test.runner.AndroidJUnitRunner
::adb -s %x% pull /sdcard/%x:~0,-5%.mp4

exit