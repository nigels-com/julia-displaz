The aim is to build a docker image that can allow easy experimentation with Julia and Displaz on local clients.

I.e. this is to be deployed on a developers machine and allow displaz (a graphical interface running on openGL) to execute and be visible in a local window.

getting a container to support a GUI is trivial (at least to do it in a hacky way) and is outlined 
[here](https://medium.com/better-programming/running-desktop-apps-in-docker-43a70a5265c4) for windows and 
[here](http://wiki.ros.org/docker/Tutorials/GUI) for Linux.

To run the container in the above examples would require the following 

```docker run -it \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --name=displaz-julia \
    displaz-julia-image
```

This does not work due to an issue with GLEW?
