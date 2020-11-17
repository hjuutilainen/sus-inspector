## INTRODUCTION

Inspect Apple macOS software updates.

![SUS Inspector](https://raw.githubusercontent.com/hjuutilainen/sus-inspector/master/screenshot.png)

SUS Inspector is an utility app for viewing detailed information about Apple's Software Update Service. It sets up a local [Reposado](https://github.com/wdas/reposado) installation to replicate catalogs and then parses them for viewing.

By default, SUS Inspector uses Apple's servers for the catalogs. If you are already replicating the software update service on your local network (using Reposado, OS X Server or something else) you should point SUS Inspector to that local server instead. This will greatly speed up the sync process.

To do this, modify the base URL before launching SUS Inspector for the first time:

    $ defaults write com.hjuutilainen.SUS-Inspector baseURL "https://reposado.example.com"

Or edit the URL's manually on the first run setup window.


### KNOWN ISSUES

* There's no way to cancel an active package download.
* There's no way to cancel an active repo_sync.
* The 'Extract Package Payload...' from product info window works only for newer gzip compressed payloads.
* Catalogs can't be modified after the initial setup.
* Preferences need major UI work


### RESETTING AND UNINSTALLING

Removing SUS Inspector's database file effectively resets the application and causes the first run setup window to reappear. This database file is in SQLite format and can be found in:

    ~/Library/Application Support/SUS Inspector/SUS_Inspector.storedata

By default, all Reposado generated data is kept separate from the application and the default location is in:

    ~/Library/Application Support/SUS Inspector/Default/

Completely removing SUS Inspector and Reposado data can be done by removing the whole SUS Inspector directory:

    ~/Library/Application Support/SUS Inspector/


## REQUIREMENTS

SUS Inspector requires macOS 10.13 or later.


## INSTALLATION

The current release version can be downloaded from the [Releases page](https://github.com/hjuutilainen/sus-inspector/releases)

The other way to run SUS Inspector is to build from source:

1. Clone the project (including the Reposado submodule)

        $ git clone --recursive https://github.com/hjuutilainen/sus-inspector.git

2. Open "SUS Inspector.xcodeproj" with Xcode and hit 'Run'


Building requires:

* Xcode
* Optional: [mogenerator + Xmo'd](http://github.com/rentzsch/mogenerator) 


## THANKS

* Greg Neagle for his [Reposado](https://github.com/wdas/reposado)
* Jonathan Rentzsch for his [mogenerator](http://github.com/rentzsch/mogenerator)
* CocoaDev [MultiPanePreferences](http://www.cocoadev.com/index.pl?MultiPanePreferences)
* Cathy Shive for [NSCell example code](http://katidev.com/blog/2008/02/22/styling-an-nstableview-dttah/)
* Daniel Jalkut at Red Sweater Software for [RSVerticallyCenteredTextFieldCell](http://www.red-sweater.com/blog/148/what-a-difference-a-cell-makes)
* SUS Inspector uses wonderful icons created by:
    * [Glyphish Pro 3](http://www.glyphish.com)
    * [Batch](http://adamwhitcroft.com/batch/) by [@adamwhitcroft](https://twitter.com/adamwhitcroft)


## LICENSE

SUS Inspector itself is licensed under the Apache License, Version 2.0. The included [Reposado](https://github.com/wdas/reposado) is licensed under the new BSD license.


## DONATIONS

There's no need to donate, the app is free to use and I'm just happy it's useful to other admins. If you absolutely want to support the development of these tools, you should first go and see a Disney movie of your choice (because Reposado and Munki are open source projects from Walt Disney Animation Studios and my projects simply wouldn't exist without those projects). After that, if you're still up for it, you can [buy me a coffee](https://www.buymeacoffee.com/hjuutilainen).
