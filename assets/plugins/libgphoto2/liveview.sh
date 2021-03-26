echo "Starting live view"
gphoto2 --capture-movie --stdout | ffplay -i pipe:0 -vcodec mjpeg
echo "Ending live view"