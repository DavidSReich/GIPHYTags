#  GIPHY Tags

What is/are GIPHY Tags?

GIPHY Tags is a Swift example application.  
It is written in Swift 4 (Xcode 9).

It queries the GIPHY website via its URL interface, and uses the tags returned to search deeper and deeper.  (This isn't necessarily a good thing.)

GIPHY Tags uses lots of Swift and iOS features:  

* classes and structs  
* protocols  
* extensions  
* computed properties  
* UIRefreshControl

"Abstracted" UITableViewDataSource & UITableViewDelegate  
Autosizing UITableViewCells

UITableView as multiple selection picker

@IBDesignable  
gradient

UIImageView with cached asynch loader

Segues:  

* shouldPerformSegue  
* prepare(for segue: ...)  
* unwind...(segue:)  
* Storyboard Reference

Functional programming lite:  

* sorted  
* joined  
* map

Asynch REST

Unit Test

Factory pattern

Information hiding

It also has:

Data:

* DataModel classes
* DataSource class (contains DataModel protocols)

Networking:

* URLSession extension
* JSONNetwork services (on top of URLSession)

Managers:

* DataManager -
    * invokes JSONNetwork services
    * uses results to create DataModels
    * passes DataModels to DataSource
    * hides all of that behind a DataManagerProtocol
* ViewManager -
    * implements UITableViewDataSource, UITableViewDelegate
    * uses DataManagerProtocol
* UserDefaultsManager
* ViewControllers - 
    * Main
    * Detail
    * Options
    * Popup selector
* Resuable UIViews -
    * UITableViewCell classes
    * UImageView class
    * IBDesignable UIView


