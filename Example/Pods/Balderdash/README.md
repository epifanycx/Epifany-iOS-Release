
[![CircleCI](https://circleci.com/gh/stealzinc/Balderdash.svg?style=svg)](https://circleci.com/gh/stealzinc/Balderdash)

# Balderdash

A simple gibberish detection library for iOS

### Installing

```pod install Balderdash```

### Usage

    balderdash = BalderdashController()
    let bundle = Bundle(for: self.classForCoder)
    let path = bundle.path(forResource: "trained_data", ofType: "json")
    let url = URL(fileURLWithPath: path!)
    balderdash.loadFile(url: url)

    let string = "This is a test"
    balderdash.isGibberish(string)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Built from [gibberish_detector](https://github.com/mchitten/gibberish_detector) and [Gibberish-detector](https://github.com/rrenaud/Gibberish-Detector)