#!/bin/bash

SCREEN_LEFT=100
SCREEN_TOP=100
SCREEN_WIDTH=1280
SCREEN_HEIGHT=720

cvlc screen:// \
  --screen-fps 30.0 --screen-left ${SCREEN_LEFT} --screen-top ${SCREEN_TOP} \
  --screen-width ${SCREEN_WIDTH} --screen-height ${SCREEN_HEIGHT} \
  :input-slave=pulse:// :live-caching=300  \
  --sout \
  "#transcode{vcodec=h264,vb=2200,vbv-maxrate=3000,vbv-bufsize=6000,scale=1,width=${SCREEN_WIDTH},height=${SCREEN_HEIGHT},venc=x264{aud,profile=high,level=30,keyint=30,ref=1},acodec=mpga,ab=128,channels=2,samplerate=44100, audio-sync, threads=1}:http{mux=ts,dst=:8090/source}" :sout-keep
