# INTRODUCTION

SUS Inspector is an utility app for viewing detailed information about Apple's Software Update Service. It sets up a local [Reposado](https://github.com/wdas/reposado) installation to replicate catalogs and then parses them for viewing.

By default, SUS Inspector uses Apple's servers for the catalogs. If you are already replicating the software update service on your local network (using Reposado, OS X Server or something else) you should point SUS Inspector to that local server instead. This will greatly speed up the sync process.

To do this, modify the base URL before launching SUS Inspector for the first time:

    defaults write fi.obsolete.SUS-Inspector baseURL "http://your-server.example.com"

Or edit the URL's manually on the first run setup window.

# REQUIREMENTS

SUS Inspector requires OS X 10.7 or later

# INSTALLATION

At the moment, the only way to run SUS Inspector is to build from source:

* Clone, fork or download the source code
* Open "SUS Inspector.xcodeproj" with Xcode and hit 'Run'

Building requires:

* Xcode 4.6 or later
* Optional: [mogenerator + Xmo'd](http://github.com/rentzsch/mogenerator)

# THANKS

* Greg Neagle for his [Reposado](https://github.com/wdas/reposado)
* Jonathan Rentzsch for his [mogenerator](http://github.com/rentzsch/mogenerator)
* CocoaDev [MultiPanePreferences](http://www.cocoadev.com/index.pl?MultiPanePreferences)
* Cathy Shive for [NSCell example code](http://katidev.com/blog/2008/02/22/styling-an-nstableview-dttah/)
* Daniel Jalkut at Red Sweater Software for [RSVerticallyCenteredTextFieldCell](http://www.red-sweater.com/blog/148/what-a-difference-a-cell-makes)
* SUS Inspector uses icons created by:
    * [Glyphish Pro](http://www.glyphish.com)

# LICENSE

SUS Inspector itself is licensed under the Apache License, Version 2.0. The included [Reposado](https://github.com/wdas/reposado) is licensed under the new BSD license.
