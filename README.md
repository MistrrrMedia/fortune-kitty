# Fortune Kitty 🐈

**Fortune Kitty** is a personal, mostly humorous iOS app that displays *ultra silly* (generated) wisdom with a random adorable cat. It's like a fortune cookie, except whatever fortune you get may have been written by a cat. 

## About

Fortune Kitty generates random, fortune cookie-style quotes using the OpenAI API. The quotes are based on philosophical and nonsensical themes (see `data.json`). Each quote is accompanied by a picture of a cat fetched from The Cat API.

- [Cat API](https://thecatapi.com/)
- [OpenAI API](https://platform.openai.com/)

<img alt = "screenshot" src="https://i.imgur.com/uD7yBVj.png" height = "640"/>

## Xcode Version

I used the new Xcode 16.1 beta to build this app. The target OS is iOS 18.1. This app should be run on a device or simulator with the latest iOS 18.1 beta (or newer).

## Installation

1. Clone repository.
2. `cd fortune-kitty`
3. Modify `Fortune Kitty/Resources/config.json` so it contains your API keys for the OpenAI and Cat APIs.
3. Double-click on `fortune-kitty.xcodeproj`
4. Select a target device/simulator and run. 

## Usage: 

1. Open Fortune Kitty.
2. Observe.
3. Tap "Fetch New Kitty" if you get bored of the cat and/or the quote. 

## To Do: 

*  Add a widget extension to display quotes and cat images on the home screen

## Contributing

I started this project to teach myself Swift/SwiftUI and strengthen my skills in interfacing with APIs. Any effort to make this project better or help me learn is much appreciated!

## License

This is licensed under the MIT License. See the `LICENSE` file in the root project directory.
