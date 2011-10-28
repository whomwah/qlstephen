# QuicklookStephen

QLStephen is a QuickLook plugin that lets you view plain text files without
a file extension. Files like:

    README
    INSTALL
    CapFile
    CHANGELOG
    etc...

## Download

You can download the lastest version from the Download section in the QLStephen github reposistory. Or you can just complile it yourself.

## Install

If you download the plugin via the downloads section in github for this project, you install via the installer pkg included. If you're compliling the project yourself, you just copy the QLStephen.qlgenerator file into the relevant QuickLook folder. If the folder is not present, then you will need to create it first:

1. If just you want to use this plugin

  /Users/yourusername/Library/QuickLook/

2. If you want any user on this machine to use plugin

  /Library/QuickLook/

3. To make OS X load the generator, run in the terminal:

  qlmanage -r

## Authors

Original author: Duncan Robertson

Special thanks to the following people for submitting patches:

* [Rob Lourens](https://github.com/roblourens)
* [Avi Flax](https://github.com/aviflax)

## Contributing

* Fork the project
* Send a pull request
* Don't touch the CHANGELOG, I'll do that when I release a new version
