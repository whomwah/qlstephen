# QuicklookStephen

QLStephen is a QuickLook plugin that lets you view plain text files without a file extension. Files like:

    README
    INSTALL
    Capfile
    CHANGELOG
    etc...


## Installation

### Homebrew

    brew cask install qlstephen

### Pre-compiled

* [Download the latest version of QuickLookStephen](https://github.com/whomwah/qlstephen/releases)
* Unzip
* Copy the file into `/Library/QuickLook` or `~/Library/QuickLook`
  (You can create the `QuickLook` folder if it doesn’t exist)


### Manually Compiled

Compiling the project yourself? The build process will copy the file into ~/Library/QuickLook.


## Settings

### Maximum file size

To keep quickview fast the priview is limited in its number of shown bytes.
The default value is 100kB. You can change this using the shell to set your own max size.

	defaults write com.whomwah.quicklookstephen maxFileSize 102400


## Trouble?

If you’ve installed the plugin, but don’t see any changes:

- Make sure you are editing (a) the correct plist of (b) the correct bundle.
  (For example, you might have two `QLStephen` plugins. It’s possible the plugin in
   another directory—perhaps `/Library/QuickLook/`—is what is being read.)
- Run `qlmanage -r` in the Terminal. (This will restart QuickLook, which reloads all plugins.)

If you want to preview some text files that _do_ have extensions (e.g., `*.txt`), follow [these instructions](https://github.com/whomwah/qlstephen/issues/23).

## Why “QLStephen”?

Because I was listening to [Adam and Joe](http://www.bbc.co.uk/blogs/adamandjoe/2009/06/test-1.shtml) when I first wrote it.


## Authors

**Original author:** Duncan Robertson

Special thanks to the following people for submitting patches over the years:

* [Guillermo Ignacio Enriquez Gutierrez](https://github.com/nacho4d)
* [Rob Lourens](https://github.com/roblourens)
* [Avi Flax](https://github.com/aviflax)
* [Tony](https://github.com/Zearin)
* [Nicholas Hutchinson](https://github.com/nickhutchinson)


## Contributing

* Fork the project
* Send a pull request
* Don’t change the build number (I’ll do that when I release a new version)
