# Teamviewer9

`Dockerfile` to create a [Docker](https://www.docker.com/) image of
[teamviewer](http://teamviewer.com).

This container will attempt to mount the host's [X11](http://www.x.org) unix
domain socket in order to create its graphical window on the host's X11 server.

- [Installing from GitHub](#installing)
- [Usage](#usage)
- [License](#license)

## Installing [GitHub](http://github.com/ufo28/teamviewer9):
```
git clone https://github.com/ufo28/teamviewer9
make instl
```

## Usage
You can use this container however your imagination sees fit. The suggested
method though is via the wrapper script that comes bundled with this docker
image. You can start [TeamViewer](http://teamviewer.com), after installation,
by executing the following command:
```
teamviewer9
```

## License
Code released under the [MIT license](./LICENSE).
