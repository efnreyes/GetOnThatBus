Map Kit
=======

What's an iOS device without a map? The Map Kit framework provides an interface for embedding maps directly into your own windows and views. This framework also provides support for annotating the map, adding overlays, and performing reverse-geocoding lookups to determine placemark information for a given map coordinate.


GetOnThatBus
============

As a user, I want to view all the transit stops on a map
2 points

    On a map, show a pin for each stop from: https://s3.amazonaws.com/mobile-makers-lib/bus.json

As a user, I want to see the name and routes of a stop when tapping its pin
2 points

    Show a callout for each stop that shows the name and routes
        Hint: it would be overkill to show that data in a whole new ViewController, also having to tap through to a new ViewController to get such fundamental information would be a bad user-experience.

As a user, I want to see the map zoomed to Chicago
2 points

    The map should be zoomed such that all pins can be seen
        Hint, you can determine the map region by hand, but challenge yourself: do it programmatically. After all, more bus stops will probably be added in the future.


Stretches
=========


As a user, I want to see the details of a stop
2 points

    Make it so tapping annotationView callouts shows a new detail screen (*hint a whole new ViewController!)
    Show the bus stop’s name as the screen's title
    Show the stop’s address
    Show the bus routes
    Show any intermodal transfers (to the suburban Pace bus system or the Metra commuter rail line)



As a user, I want to see stop transfers on the map
3 points

    Create a custom annotation for stops with transfer options to Metra
    Create a custom annotation for stops with transfer options to Pace



As a user, I want to see all of the stops in a list
3 points

    Add a segmented control to toggle between a TableView and a MapView
    Add the functionality to view the stops in a TableView
    Selected TableView items should also display the detail viewController

