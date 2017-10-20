![Localize](https://raw.githubusercontent.com/s4cha/Localize/master/banner.png)

# Localize
[![Language: Swift](https://img.shields.io/badge/language-swift-f48041.svg?style=flat)](https://developer.apple.com/swift)
![Platform: iOS](https://img.shields.io/badge/platform-iOS-blue.svg?style=flat)
[![codebeat badge](https://codebeat.co/badges/158a502c-1e18-4239-8301-a7ff79160b60)](https://codebeat.co/projects/github-com-s4cha-localize)
[![License: MIT](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)](https://github.com/s4cha/Localize/blob/master/LICENSE)
[![Release version](https://img.shields.io/badge/release-0.1-blue.svg)]()

*Localize* is a tiny run script that keeps your `Localizable.strings` files clean and emits warnings when something is suspicious.


![Localize](https://raw.githubusercontent.com/s4cha/Localize/master/xcodeScreenshot.png)


Because **Localization** files tend to **rot over time** and become a hassle to work with. **Stressful** when you have to test your app against many different Localizations.

## Try it!

Localize is part of [freshOS](http://freshos.org) iOS toolset. Try it in an example App ! <a class="github-button" href="https://github.com/freshOS/StarterProject/archive/master.zip" data-icon="octicon-cloud-download" data-style="mega" aria-label="Download freshOS/StarterProject on GitHub">Download Starter Project</a>

## How
By using a **script** running automatically, you have a **safety net** keeping them **sane**, checking for **translation issues** and preventing then to **rot over time.**

## What
Automatically (On build)
  - [x] **Cleans** you localization files (removes spaces)
  - [x] **Sorts** keys Alphabetically
  - [x] Checks for **Unused Keys**
  - [x] Checks for **Missing Keys**
  - [x] Checks for **Untranslated** (which you can ignore with a flag)

## Installation

Add the following `Run Script` in XCode, this will run the script at every build.
Use the path of where you copied Localize.swift script

```shell
${SRCROOT}/{REPLACE ME}} # Ex: ${SRCROOT}/Libs/Localize.swift
```
Run and Enjoy \o/

## Configuration
Configure the top section of the `Localize.script` according to your project

## More

### Ignore [Potentialy Untranslated] warnings
Just Add `//ignore-same-translation-warning` next to the translation.
Example :
```
"PhotoKey" = "Photo"; //ignore-same-translation-warning
```
This will take care of ignoring `[Potentialy Untranslated] "XXX" in FR file doesn't seem to be localized`

### Unused false positive

#### Not found by the script reason 1
The script parses your project sources and checks if your keys are called within `NSLocalizedString` calls.
But chances are you have a helper for a shorter NSLocalizedString syntax.
This is indeed supported but you have to give the script what to look for.

You can modify the script to include other ways of localizations:

```swift
let patterns = [
    "NSLocalizedString\\(@?\"(\\w+)\"", // Swift and Objc Native
    "Localizations\\.((?:[A-Z]{1}[a-z]*[A-z]*)*(?:\\.[A-Z]{1}[a-z]*[A-z]*)*)", // Laurine Calls
    //Add your own matching regex here
    "fsLocalized\\(@?\"(\\w+)\""
]
```

#### Not found by the script reason 2
Another common pattern is to have keys being built at runtime.
Of course thoses keys are not present at compile time so the script can't know about them and emits false positive errors.
You can add those keys at the top of of the script to prevent this from happening:

```swift
let ignoredFromUnusedKeys = [
    "NotificationNoOne",
    "NotificationCommentPhoto",
    "NotificationCommentHisPhoto",
    "NotificationCommentHerPhoto"
]
```

## Author

Sacha Durand Saint Omer, sachadso@gmail.com

## Contributors
[JuliusBahr](https://github.com/JuliusBahr)

## Contributing

Contributions to Localize are very welcomed and encouraged!

## License

Localize is available under the MIT license. See [LICENSE](https://github.com/s4cha/Localize/blob/master/LICENSE) for more information.


# Backers
Like the project? Offer coffee or support us with a monthly donation and help us continue our activities :) 

<a href="https://opencollective.com/freshos/backer/0/website" target="_blank"><img src="https://opencollective.com/freshos/backer/0/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/1/website" target="_blank"><img src="https://opencollective.com/freshos/backer/1/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/2/website" target="_blank"><img src="https://opencollective.com/freshos/backer/2/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/3/website" target="_blank"><img src="https://opencollective.com/freshos/backer/3/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/4/website" target="_blank"><img src="https://opencollective.com/freshos/backer/4/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/5/website" target="_blank"><img src="https://opencollective.com/freshos/backer/5/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/6/website" target="_blank"><img src="https://opencollective.com/freshos/backer/6/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/7/website" target="_blank"><img src="https://opencollective.com/freshos/backer/7/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/8/website" target="_blank"><img src="https://opencollective.com/freshos/backer/8/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/9/website" target="_blank"><img src="https://opencollective.com/freshos/backer/9/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/10/website" target="_blank"><img src="https://opencollective.com/freshos/backer/10/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/11/website" target="_blank"><img src="https://opencollective.com/freshos/backer/11/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/12/website" target="_blank"><img src="https://opencollective.com/freshos/backer/12/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/13/website" target="_blank"><img src="https://opencollective.com/freshos/backer/13/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/14/website" target="_blank"><img src="https://opencollective.com/freshos/backer/14/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/15/website" target="_blank"><img src="https://opencollective.com/freshos/backer/15/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/16/website" target="_blank"><img src="https://opencollective.com/freshos/backer/16/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/17/website" target="_blank"><img src="https://opencollective.com/freshos/backer/17/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/18/website" target="_blank"><img src="https://opencollective.com/freshos/backer/18/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/19/website" target="_blank"><img src="https://opencollective.com/freshos/backer/19/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/20/website" target="_blank"><img src="https://opencollective.com/freshos/backer/20/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/21/website" target="_blank"><img src="https://opencollective.com/freshos/backer/21/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/22/website" target="_blank"><img src="https://opencollective.com/freshos/backer/22/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/23/website" target="_blank"><img src="https://opencollective.com/freshos/backer/23/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/24/website" target="_blank"><img src="https://opencollective.com/freshos/backer/24/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/25/website" target="_blank"><img src="https://opencollective.com/freshos/backer/25/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/26/website" target="_blank"><img src="https://opencollective.com/freshos/backer/26/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/27/website" target="_blank"><img src="https://opencollective.com/freshos/backer/27/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/28/website" target="_blank"><img src="https://opencollective.com/freshos/backer/28/avatar.svg"></a>
<a href="https://opencollective.com/freshos/backer/29/website" target="_blank"><img src="https://opencollective.com/freshos/backer/29/avatar.svg"></a>

### Sponsors
Become a sponsor and get your logo on our README on Github with a link to your site :) 

<a href="https://opencollective.com/freshos/sponsor/0/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/0/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/1/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/1/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/2/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/2/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/3/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/3/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/4/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/4/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/5/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/5/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/6/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/6/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/7/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/7/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/8/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/8/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/9/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/9/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/10/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/10/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/11/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/11/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/12/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/12/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/13/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/13/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/14/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/14/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/15/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/15/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/16/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/16/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/17/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/17/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/18/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/18/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/19/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/19/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/20/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/20/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/21/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/21/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/22/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/22/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/23/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/23/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/24/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/24/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/25/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/25/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/26/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/26/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/27/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/27/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/28/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/28/avatar.svg"></a>
<a href="https://opencollective.com/freshos/sponsor/29/website" target="_blank"><img src="https://opencollective.com/freshos/sponsor/29/avatar.svg"></a>
