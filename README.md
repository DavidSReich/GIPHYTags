#  GIPHY Tags

What is/are GIPHY Tags?

GIPHY Tags is a Swift example application.  
It is a Xcode 9 project and Swift 4.

It queries the GIPHY website via its URL interface, and uses the tags returned to search deeper and deeper.  (This isn't necessarily a good thing.)

GIPHY Tags (GT) uses lots of Swift and iOS features:
classes and structs
protocols
extensions
computed properties
UIRefreshControl

"abstracted" UITableViewDataSource & UITableViewDelegate
autosizing table view cells

tableview as multiple selection picker

@IBDesignable
gradient

UIImageView with cached asynch loader

Segues:
shouldPerformSegue
prepare
unwind
storyboard reference


Functional programming lite:
sorted
joined
map

asynch REST

unit test

class func

static struct func

factory

information hiding

============

It also has:

Data:
DataModel classes
DataSource class (contains DataModel protocols)

Networking:
URLSession extension
JSONNetwork services (on top of URLSession)

Managers:
DataManager -
invokes JSONNetwork services,
uses results to create DataModels,
passes DataModels to DataSource
hides all of that behind a DataManagerProtocol

ViewManager -
implements UITableViewDataSource, UITableViewDelegate
uses DataManagerProtocol

UserDefaultsManager

ViewControllers - Main, detail, options, popup selector.

Views - reusable - UITableViewCell classes, ImageView subclass, IBDesignable UIView, etc.


