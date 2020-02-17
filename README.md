# QuicklookStephen

QLStephen is a QuickLook plugin that lets you view text files without their own dedicated QuickLook plugin. Files like:

    README
    INSTALL
    Capfile
    CHANGELOG
    package.json
    etc...

## Installation

### Homebrew

    brew cask install qlstephen

### Pre-compiled

* [Download the latest version of QuickLookStephen](https://github.com/whomwah/qlstephen/releases)
* Unzip
* Copy the file into `~/Library/QuickLook` (You can create the `QuickLook` folder if it doesn’t exist)

### Manually Compiled

Compiling the project yourself? Run:

    make
    make install
    
## Permissions (Quarantine)

If you run into issues with macOS not letting you run the plugin because it's not signed by a verified developer you can follow these steps:

1. Install the plugin using one of the methods above
1. run `xattr -cr ~/Library/QuickLook/QLStephen.qlgenerator` (sudo if needed)
1. run `qlmanage -r`
1. run `qlmanage -r cache`
1. Restart Finder by...
    -  Restarting your computer
    -  or holding down the option key and right click on Finder’s dock icon, then select “Relaunch” from the menu

For more disucssion on this you can read up on [#81](https://github.com/whomwah/qlstephen/issues/81) [starting here](https://github.com/whomwah/qlstephen/issues/81#issuecomment-582207278)

## Settings

### Maximum file size

To keep quickview fast the preview is limited in its number of shown bytes.
The default value is 100kB. You can change this using the shell to set your own max size.

    defaults write com.whomwah.quicklookstephen maxFileSize 102400

## Trouble?

If you’ve installed the plugin, but don’t see any changes:

- Run `qlmanage -m` and look for the `public.data` line to make sure a different application's `qlgenerator` file hasn't taken precedence. (Not all `qlgenerator` files are in `~/Library/QuickLook/` or `/Library/QuickLook/`!)
- Make sure you are editing (a) the correct plist of (b) the correct bundle.
  (For example, you might have two `QLStephen` plugins. It’s possible the plugin in
   another directory — perhaps `/Library/QuickLook/` — is what is being read.)
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
