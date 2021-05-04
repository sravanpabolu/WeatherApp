# WeatherApp
An iOS app, built on **Swift**, that displays weather across different locations

**Tools:**
1. XCode 12.4
1. Apple Swift version 5.3.2

**Features:**
1. Add a location to the screen, using **'+'** button. Select location and hit **Done**
2. Swipe left on the a location to display **Delete** button, to delete a location
3. Choose units between **Metric** and **Imperial**

**Technical Features:**
1. Used MVVM design pattern
2. Size classes for changing color of city name label in City Screen for iPad/iPhone - Landscape/Portrait orientations
3. Used WKWebview, for loading a simple url
4. Test coverage for about 85%, both UnitTesting and UITesting using XCTest framework
5. Core data for storing settings and bookmarked locations
6. Basic Network API call using URLSession
7. MapKit for marking location
