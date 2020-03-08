# local-places-app

### Instructions:

1. Open the project through the `LocalPlaces.xcodeproj` file.
2. Xcode should fetch the dependencies (described below) automatically.
3. Edit `GooglePlacesAPIService.swift` to add your own API key in the `apiKey` property, then run the project.
4. Run the project (`cmd+R`)


### Libraries used (through Swift Package Manager):
* Resolver: https://github.com/hmlongco/Resolver
  * Used as dependency injection system
* Alamofire: https://github.com/Alamofire/Alamofire
  * Used only to implement HTTP request faster, due to my own time constraints. Should be unnecessary in an actual project.

### Images used:
* Closed place: https://www.iconfinder.com/icons/1871435/closed_online_shop_shopping_sign_icon
* Open place: https://www.iconfinder.com/icons/1871431/online_open_shop_shopping_sign_icon
* Filter: https://www.iconfinder.com/icons/2561439/filter_icon
* Sorting: https://www.iconfinder.com/icons/905641/ascending_az_filters_sort_sorting_icon
* Photo used in the mocked PlacesService: https://unsplash.com/photos/GXXYkSwndP4
