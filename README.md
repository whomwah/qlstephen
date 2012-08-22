# QuicklookStephen

QLStephen is a QuickLook plugin that lets you view plain text files without a file extension. Files like:

    README
    INSTALL
    CapFile
    CHANGELOG
    etc...

You can also customise the plugin to determine which files it previews. See Customizing white/black lists below.

## Install

### Pre-compiled

[Download the latest version of the QuickLookStephen plugin](https://github.com/downloads/whomwah/qlstephen/QLStephen.qlgenerator.zip). Unzip and copy the file into your /Library/QuickLook or ~/Library/QuickLook folder. You may have to create the QuickLook folder if it doesn't exist.

### Manually Compile

If you're compliling the project yourself, you just copy the generated QLStephen.qlgenerator file into the relevant QuickLook folder as mentioned above.

## Customizing white/black lists - Step by Step

If you wish to change the current behavour, you will need to follow the instructions below:

Plists used here are not same as user defaults so you won't find in ~/Library/Preferences. Instead you need to edit the plist files inside the bundle (in this case it is the plugin file: QLStepehen.qlgenerator).

#### 1. Show the contents of the bundle.

If you the plugin installed then it should be in `~/Library/QuickLook/` directory.

<a href="http://a.yfrog.com/img740/933/tipb.png"><img src="http://a.yfrog.com/img740/933/tipb.png" width="300"/></a>

#### 2. Edit the appropriate plist file in your favorite text editor.

<a href="http://a.yfrog.com/img878/3563/hd9w.png"><img src="http://a.yfrog.com/img878/3563/hd9w.png" width="400"/></a>

If you don't know which one :

* **QLStephenWhiteList.plist** : files with these names will be ALWAYS previewed
* **QLStephenExtensionsBlackList.plist** : files with these extensions will NOT be previewed
* **QLStephenDirectoriesBlackList.plist** : files contained in directories with these names will NOT be previewed

## Trouble?

If you have installed the plugin (by placing it in `~/Library/QuickLook/`) and can't see your changes take effect:

- Make sure you are editing the correct plist of the correct bundle (It could happen you have two QLStephen plugins and the one read is in another directory like `/Library/QuickLook/`, etc.
- Run `qlmanage -r` in the Terminal, it will reset QuickLook so plugins will be reloaded.

## Why QLStephen?

Because I was listening to [Adam and Joe](http://www.bbc.co.uk/blogs/adamandjoe/2009/06/test-1.shtml) when I first wrote it.

## Authors

Original author: Duncan Robertson

Special thanks to the following people for submitting patches:

* [Guillermo Ignacio Enriquez Gutierrez](https://github.com/nacho4d)
* [Rob Lourens](https://github.com/roblourens)
* [Avi Flax](https://github.com/aviflax)

## Contributing

* Fork the project
* Send a pull request
* Don't change the build number, I'll do that when I release a new version
