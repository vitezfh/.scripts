#!/bin/sh
sudo modprobe v4l2loopback devices=2
wf-recorder --muxer=v4l2 --codec=rawvideo --pixel-format=yuv420p --file=/dev/video2
