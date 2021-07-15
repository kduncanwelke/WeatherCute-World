# WeatherCute World
Worldwide cute weather!

This app uses weather data from [WeatherAPI](https://www.weatherapi.com) to track weather and forecasts for a user's selected locations. WeatherCute World is an internationl version of WeatherCute that combines a user-friendly interface and friendly art with current condition and forecast data to provide an easy and fun way for users to get their U.S. weather. Features include current conditions, 3-day forecast, astronomy, air quality, toggling between Fahrenheit and Celsius measurements, easy addition and deletion of locations, current alerts, and more.

![Screenshot](https://i.ibb.co/9HbdxGC/Screen-Shot-2021-07-15-at-2-46-17-PM.png)

## Description

Track weather, forecast, moon phase, air quality, and more for your favorite locations!

WeatherCute Worldwide provides all your weather needs in an easy to digest, fun format, featuring adorable art, a user-friendly interface, and weather data provided by WeatherAPI. Additional astronomy and air quality data offer further information to guide your day!

Add, rearrange, and view location weather in your preferred measurements and stay up-to-date on conditions with the three-day forecast.

Features include:

* Current condition information - temperature, humidity, UV index, and more!
* Cute and simple art for at-a-glance understanding
* Air quality data and EPA air quality index
* Astronomy data for current conditions and forecasts, including sunset, sunrise, moon phase, and more
* Pop-ups for easy air quality and astro info, simply press and hold the icons
* Three-day forecast
* Easy deletion and reordering of locations from the edit view
* Location addition and search
* Red button for active alerts related to a location
* Detailed alert info, including details and advised steps
* Easy toggling between Fahrenheit and Celsius measurements, preference saved
* Location local time and date displayed for current condition info
* Refresh button to retrieve information anew
* Feedback and responsiveness to network loss and restoration

Please note: this app requires a network connection for full functionality.

## Features
The app accesses the WeatherAPI and retrieves and parses JSON (using Codable) to provide current weather condition and forecast information for locations a user has selected. Locations are displayed in a page view controller, and can be swiped through readily. A user adds locations by hitting the plus button in the upper right - this directs to a view with a search bar. Locations can be found by searching by city or zipcode, and more. Once confirmed, a selected location is saved in Core Data.

The main view for any selected weather location featues an area for current conditions and forecast data. Two API calls are made for each location - one for current conditions, forecast data, and air quality, and one for astronomy data. A refresh button allows the user to refresh the data as desired, and the display shows the current time and date at the location for when the data was retrieved. A control at the top of the view allows toggling between fahrenheit and celsius measurements.

Current conditions show basic information such as temperature and a brief description, along with a user-friendly image created for the app. Forecast data is displayed in a collection view. Pressing and holding on the astro data moon and stars icon or the air quality wind icon will show a popup showing the current astro or air quality data. If alerts are present, a red ! button is displayed next to the current temperature. This leads to an alert area which provides details and suggested steps.

An edit view, indicated by a pencil, allows the user to rearrange their weather locations or delete them altogether. Swapping items refreshes the page view so items are shown as the user prefers.

Network monitoring allows the app to detect and indicate network loss, and respond with reloads or removal of loss indicators when the network is restored. 

The app overall aims to provide weather in a cute, enjoyable, user-friendly manner that allows the user to tailor their experience through reordering, data reloads, and measurement type preferences.

## Art
Unique art for every weather condition specified by the WeatherAPI (and for both day and nighttime conditions) is included as an integral part of this app, to allow at-a-glance understanding. This art was created by myself (the developer) and belongs to no one else. The art displayed is set based off condition codes returned by the API.

## Support
If you experience trouble using the app, have any questions, or simply want to contact me, you can contact me via email at kduncanwelke@gmail.com. I will be happy to discuss this project.

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/S6S03G1HT)
