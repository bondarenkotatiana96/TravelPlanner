# TravelPlanner
# <img src="/README/logo.png">

## Summary

**TravelPlanner** is an app that allows users to plan their  upcoming trips, create a bucket list of the places they want to visit and explore the most popular destinations and local places.


## About the Developer

TravelPlanner was created by Tatiana Bondarenko. Learn more about the developer on [LinkedIn](https://www.linkedin.com/in/tatiana-bondarenko/).

## Table of Contents✈️

* [Tech Stack](#tech-stack)
* [Features](#features)
* [Setup/Installation](#installation)
* [To-Do](#future)
* [License](#license)

## <a name="tech-stack"></a>Tech Stack

__iOS Development:__ Swift, SwiftUI, URLSession, JSON Persistence <br/>
__Framework:__ MapKit <br/>
__APIs:__ Yelp, random-data-api, Triposo, Geocodify <br/>

## <a name="features"></a>Features 🌎

Search for cities/countries, add them to the list of your future trips and get notified about your upcoming trips
  
![Trip List](/README/1screen.png)
<br/><br/><br/>
Change your trip details by adding notes, dates and things to pack
  
![Trip List](/README/2screen.png)
<br/><br/><br/>
Create your own bucket list to save places you want to visit
  
![Trip List](/README/5screen.png)
<br/><br/><br/>
Pin places you want to visit on the map
  
![Trip List](/README/4screen.png)
<br/><br/><br/>
Explore the most popular cities and local places
  
![Trip List](/README/6screen.png)
<br/><br/><br/>
Share your trip details on social media
  
![Trip List](/README/7screen.png)
<br/><br/><br/>
The app, also, has support for English, Russian, Spanish and Korean languages; Onboarding; and ability for users to send a feedback/support email

## <a name="installation"></a>Setup/Installation ⌨️

#### Requirements:

- Swift5
- Yelp, Geocodify and Triposo API keys

To have this app running on your local computer, please follow the below steps:

Clone repository:
```
$ git clone https://github.com/bondarenkotatiana96/TravelPlanner.git
```
Get your own secret keys🔑 for [Yelp](https://www.yelp.com/developers/documentation/v3),  [Triposo](https://www.triposo.com/api/) and [Geocodify](https://geocodify.com/api-documentation). Save them to a file `Config.xcconfig`. Your file should look something like this:
```
API_KEY = xyz
YELP_API_KEY = abc
TOKEN = abc
ACCOUNT = xyz
```

## <a name="future"></a>TODO✨
* Add ability for users to upload attachments (ex. boarding passes, hotel reservations, etc.)
* Add day by day trip planner
* Add user registration and authorization process
* Add ability for users to archive their previous trips
* Add localization for more languages

## <a name="license"></a>License

Copyright (c) 2022 Tatiana Bondarenko 
