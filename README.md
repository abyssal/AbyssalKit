# AbyssalKit

My extensions and utilities for Swift and SwiftUI. You can add this to your projects by adding it with Swift Package Manager in Xcode.

### 🔨 Contents
- `Direction` enum with values `forward`, `nearest`, `back`
- Extensions to the date/time models
  - Commonly used date formats (English/New Zealand)
    - `DateFormats.longDate = "EEEE, MMM d, yyyy"`
    - `DateFormats.time = "h:mm aa"`
  - `Date#asLongDateString` converts self to a string with `DateFormats.longDate`
  - `Date#asTimeString` converts self to a string with `DateFormats.time`
  - `Date#string(String)` converts self to a string using the provided format string
  - `Date#getWeekday(Direction)` finds the nearest date that's a weekday (M-F) using the provided direction
    - If self is already a weekday, it will return itself
    - `forward` will return the next Monday if self is Saturday or Sunday
    - `nearest` will return Monday if self is Sunday, and the previous Friday if self is a Saturday
    - `back` will return the previous Friday if self is a Saturday or Sunday
  - `String#date(String)` is essentially the reverse of `Date#string(String)`
  - `String#asPcsDate` is a niche method that converts the string to a date using the format `DD/MM/YYYY`
  - `String#randomUIColor` generates a random `UIColor` using `self` as a seed
  - `String#randomColor` generates a SwiftUI `Color` object from `String#randomUIColor` with opacity `1`
- Extensions to `UIColor`
  - `UIColor#init?(String)` generates a `UIColor` object from a hex colour string
  - `UIColor#toHexString` does the reverse of the above
  - `UIColor#toHSBComponents` returns a `(CGFloat, CGFloat, CGFloat)` representing hue, saturation, and brightness
  - `hueComponent`, `saturationComponent`, and `brightnessComponent` are `CGFloat` variables representing the above
  
### License
MIT
