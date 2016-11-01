# Immerse App - Overview

## Getting Started

1. Ensure that Cocoapods is installed on your machine
2. Pull down the repo
3. Run 'pod install'
4. Open the resulting Xcode Workspace file

Notes:

* To run in Xcode 8, will need to upgrade the syntax from Swift 2.2 to Swift 2.3 or Swift 3 (would recommend the latter)
* To install with CocoaPods, this pod file was setup using a pre-release version of CocoaPods. It was later upgraded to CocoaPods 1.0 syntax. Ensure that Cocoapods 1.0 or later is installed on your machine along with the requisite Ruby version.
* The project is configured to use 2 tabs instead of 4 tabs by default
* Would recommend installing Alcatraz as a plugin manager for Xcode

## Architectural Overview

The project loosely follows an MVVM design pattern. Views and broken up into their own files and Xib files where necessary.

* Xib / Views : Provide simple rendering behavior for the screent
* ViewControllers : Provide presentation logic, request data from ViewModels
* ViewModel : Quering services and interfaces for the requested projects and passing them to the ViewControllers
* Services : Lowest level, interact with the DB layer

Realm is used as the local database. May be useful especially now that Realm platform exists.


## Project Status

* Models for the Faith, Notes, Tags, and Cross References have been built out and linked to one another. RealmService is built out to support CRUD operations against the RealmDB
* Library will populate appropriately as more text are parsed and added to Realm
* Processing scripts are present, but work needs to be done to further standardize the collection of flat files into structure data. 
* Reader and reader highlighting and selection has been built out to create tags, notes, and cross references. Table of contents has also been built. Significant work needs to be done to prettying these tools. Reader is implemented as a tableview with cells representing specific paragraphs
* Home Page will update with latest tags, notes, and cross references that were created. Progress appears for each writing.
* Sharing is built in against Cross References though it does not yet exist as a single interface for all notes, tags, and passages

## Outstanding TODO List

* Process the Writings : A lot of work went into standardizing the writings into a format that would be usable. Please consult the Processing Script folder for more information. The script should already be there and ready to go, it just needs to be used against the existing writing flat files found in the immerse-writings repo.
    * Need to write the import script for using the Realm database. The processing script will spit out a bar delimited text file that can later be processed. You can investigate other schemes, but this was the way we got most of our traction. 
* Migrate from Swift 2.2 to either Swift 2.3 or Swift 3.0 for support. Update the project for iOS 10 support (should be done automatically when opening in Xcode 8). 
* Finish writing the search functionality against notes, cross references, and tags
* Finish implementing the editing ability against notes, cross references, and tags
* Library sorting is built in to various degrees but needs to be cleaned up
* The app needs a general once over to true up the design, tidy up any remaining issues and corner cases, and needs code cleanup and refactor to build in additional functionality. It's in pretty raw shape right now
* Testing! Unit testing. 

**Contact**: [jamesktan@gmail.com](mailto:jamesktan@gmail.com)


