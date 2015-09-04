#!/bin/bash

#capture.sh
#AUTHOR: on-three
#DATE: Sat August 29th 2015
#DESC: Startes a desktop capture piped from ffmpeg x11grab into a simulated
# video capture device via kernel module v4l2loopback.
# Make sure v4l2loopback kernel module is present (sudo modprobe v4l2loopback)

SCREEN_WIDTH=1280
SCREEN_HEIGHT=720
SCREEN_LEFT=100
SCREEN_TOP=100


ffmpeg -f x11grab -s ${SCREEN_WIDTH}x${SCREEN_HEIGHT} -i :0.0+${SCREEN_LEFT},${SCREEN_TOP} -vcodec rawvideo -pix_fmt yuv420p -threads 0 -f v4l2 /dev/video0 & \
sleep 4 ; vlc -I dummy v4l2:///dev/video0 :v4l2-standard=ALL :input-slave=pulse:// :live-caching=300 --sout \
"#transcode{vcodec=h264,vb=2200,vbv-maxrate=3000,vbv-bufsize=6000,scale=1,width=${SCREEN_WIDTH},height=${SCREEN_HEIGHT},venc=x264{aud,profile=high,level=30,keyint=30,ref=1},acodec=mpga,ab=128,channels=2,samplerate=44100}:http{mux=ts,dst=:8090/source}" :sout-keep \
&& fg
