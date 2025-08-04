xhost +local:root

docker run --pull=always -it \
    --name ur5e_container \
    --net=host \
    --privileged \
    -e DISPLAY \
    -e QT_X11_NO_MITSHM=1 \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    -v /dev:/dev \
    --device=/dev/bus/usb:/dev/bus/usb \
    rdclab/ur5e_docker:latest