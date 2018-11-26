SET x=%1
SET package=%2
adb -s %x% shell input keyevent 224
adb -s %x% shell input touchscreen swipe 0 880 930 880
adb -s %x% shell screenrecord /sdcard/%x:~0,-5%.mp4 --time-limit 60
adb -s %x% pull /sdcard/%x:~0,-5%.mp4
exit