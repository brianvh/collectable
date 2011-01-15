# collectable

A fairly simple Ruby module that provides helper methods, primarily to a parent class, so it can learn (i.e. _collect_) info about the classes that inherit from it.

This module came about as a pattern that I extracted from a Rails 3 engine I was building. I found that I had multiple classes, with sub-classes, where I was gathering info on those sub-classes into the parent, so I could build more efficient delegation methods. This gem contains that functionality. Maybe you'll find a use for it in your own classes.

## Installation

    $ sudo gem install collectable
