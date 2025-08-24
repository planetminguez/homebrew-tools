# Homebrew Tap: planetminguez/tools
[![Bump python2exe formula](https://github.com/planetminguez/homebrew-tools/actions/workflows/bump-python2exe.yml/badge.svg)](https://github.com/planetminguez/homebrew-tools/actions/workflows/bump-python2exe.yml)

Personal Homebrew tap with tools and new formulae.

## Quick start

- Add the tap:
  ```sh
  brew tap planetminguez/tools
  ```
- Install python2exe:
  ```sh
  brew install python2exe
  ```

## python2exe

Convert Python scripts into native executables via a generated C wrapper.

- Project: https://github.com/planetminguez/Python2ExeInC
- License: GPL-3.0-or-later

### Usage

```sh
# Create an executable from a Python script
python2exe path/to/script.py

# Then run the generated executable (same directory by default)
./script
```

### Upgrade

```sh
brew update
brew upgrade python2exe
```

### Uninstall

```sh
brew uninstall python2exe
# Optionally remove the tap
brew untap planetminguez/tools
```

## Troubleshooting

- Ensure Homebrew is up to date: `brew update`
- Check your environment: `brew doctor`
- Show formula info: `brew info python2exe`

## Contributing

PRs and issues are welcome. For version bumps, update the URL and SHA256 in `Formula/python2exe.rb` to the new release tarball.

