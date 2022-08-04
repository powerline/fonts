# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/).

## Unreleased

## [1.8.0] - 2019-11-16

### Added
- Add coding ligatures to all weights [#64]

### Removed
- Stop producing EOTs

[#64]: https://github.com/belluzj/fantasque-sans/issues/64
[1.8.0]: https://github.com/belluzj/fantasque-sans/releases/tag/v1.8.0

## [1.7.2] - 2018-01-07

### Added
- Font variant with a larger line height, especially for users of accented
  capitals. [#23]
- Numero sign (№) [#23]
- Perl 6 quotes (｢ and ｣) [#82]
- Black circle (●) [#78]
- Comparison operators (≤ and ≥) [#69]

### Changed
- Fixed the curly tail on Cyrillic у [#23]
- Upgrade the build system to have a proper version of the font with
  a built-in stylistic set `ss01` (no-loop `k`) [#67]

  Thanks to the [Monoid](https://github.com/larsenwork/monoid) project
  for open-sourcing their build scripts.

[#23]: https://github.com/belluzj/fantasque-sans/issues/23
[#67]: https://github.com/belluzj/fantasque-sans/issues/67
[#69]: https://github.com/belluzj/fantasque-sans/issues/69
[#78]: https://github.com/belluzj/fantasque-sans/issues/78
[#82]: https://github.com/belluzj/fantasque-sans/issues/82
[1.7.2]: https://github.com/belluzj/fantasque-sans/releases/tag/v1.7.2

## 1.7.1

- **Add a stylistic set to replace the looped lowercase `k` with
  a straight version.**
- Adjust curly quotes so they behave better as apostrophes.
- Also, since nobody complained about the new Cyrillic characters,
  I declare this is their official release! (I did not change
  anything since 1.7.0 though).

## 1.7.0

Beta version for the 1.7 series.

- **Add Cyrillic alphabet to the four fonts.**
- Add some real sub/supscript numbers and fractions.
- Revamp straight and curly quotes.
- Fix some Windows rendering issues.
- Move accents around (why do I do that every time?)
- Add `fontdiff` script which generates font diffs.

## 1.6.5
- Make italics visible on Windows.

## 1.6.4
- Fix line height on Mac.
- Move all the italic glyphs to the left.
- Adjust some accents.

## 1.6.3
- Add block characters.
- Make the underscore visible on Windows.
- Generate better CSS.

## 1.6.2
- Make `+` symmetrical, align dots in `:` and `;`.

## 1.6.1
- Simplify @ to make it look sharp at all sizes.
- Various fixes.

## 1.6
- Add bold italic version.

## 1.5
- Add regular italic version.
- Some small changes (Q, w, y, n).

## 1.4.1
- Drop Reserved Font Name. **You can now subset, compress, hint and
  whatnot without worrying about renaming**.
- Many small improvements (8, s , t, a, e, {, }, W, i, l, g...).

## 1.4
- Rename font to **Fantasque Sans**, because *fantasque is the new cosmic*.
- Make W look symmetrical at big size.

## 1.3.2
- Various fixes: playing again with bold m, moving accents again, taking
  care again of Powerline symbols, clean 8 and R.
- Add a few box drawing characters (for use with vim-indentline).
- Generate webfonts (goal: this font used for code samples on all cool
  languages' websites).
- Add a WIP medium version of the proportional font.

## 1.3.1
- Various fixes: still cleaning m and w, reworked all ogoneks, changed a
  bit the dollar, moved some accents, eliminated glitches around
  Powerline symbols.
- TTF fonts are now hinted using Freetype's `ttfautohint`, which should
  give much better results on Windows (and maybe in Java apps and others
  contexts). In case this is a problem, please let me know and I will
  provide also an unhinted version.

  **Windows users should use the TTF (TrueType) files.**

## 1.3
- Very slight change of metrics to add space between characters and lines.
- Various small changes : curlier curly brackets, more difference between
- various quotes, cleaner W, w, m, and rounder @.
- Windows compatibility.
- More latin accents.
- Greek letters.
- Powerline characters.

## 1.2.1
- Minor adjustments.

## 1.2
- Add the bold version.
- Various minor adjustments, new paragraph symbol, slanted dollar.

## 1.1.1
- Make slashes longer, ensure parenthesis and brackets are rendered at
  the same height, and some other minor adjustments.

## 1.1
First release.
