### 26 July 2014
- Consider using separate mongodb that is not packaged with Meteor,
  since it will open up options like full-text search and Mass JSON DATA dump then check later once it's already inserted.

### 24 July 2014

- DATA from `.json` should be inserted without any kind of check. Checking will happen with `forEach` after insert
- Consider converting `_s.json` to object instead of array

### 22 July 2014

- Figure out Json Control on e.g. `"city_n"` and `"country_n"` in the same document should match.
- Consider converting `_s.json` to object instead of array
