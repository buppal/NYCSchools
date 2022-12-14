# NYCSchools

Coding Principles followed:

* The code is done with SwiftUI and Combine.

* SOLID Design principles are followed.

* Dependency Injection is followed, so that mocks can be created for unit testing. All services are protocols.

* MVVM is followed, for uni-directional flow of data, easier unit testing and making sure the Single Responsibility Principle is followed.

* All Service interfaces are very thin, to ensure the Interface Segregation Principle is followed.

I wanted to time box this to 3-4 hours. If we decide to proceed, happy to talk in more detail, make improvements. Things to be done if there was more time:

* Improve Unit testing

    * Add mocks.

    * Unit test all the view models.

    * Add Snapshot test for all views.

    * UI tests for golden workflows.

* Add documentation for all functions and variables. 

* Localize all strings used in the app.

* Add more extensions for DLS-like design syntax.

* Improve the Network layer:
    
    * Better and more detailed error handling.
    
    * Add ability to append query parameters in a Builder pattern.
    
    * Add ability to add post requests.
