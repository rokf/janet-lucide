# janet-lucide

This library contains Lucide icons in form of Janet standard data structures. These are meant to be used together with something like [spork/htmlgen](https://janet-lang.org/api/spork/htmlgen.html).

## Installation

The lucide module that's exposed by this library can be installed with:
```sh
jpm install https://github.com/rokf/janet-lucide
```

Alternatively you can put it into your project's depencency tuple:

```janet
{ :url "https://github.com/rokf/janet-lucide" :tag "main" }
```

## API

Each icon has its own function, which optionally accepts a size in pixels (integer). The default value for the size is `24` and it is used for both the width and height attribute of the `svg` (main) element.

**Example:**

```janet
(import lucide)
(lucide/a-arrow-down)
(lucide/alarm-clock-plus 32)
```

See the HTML page in the [preview](./preview) folder for a list of available icons. There should also be a script that generates that page.

## Icon updates

To regenerate the `lucide` module first update the submodule with the official `lucide` Git repository. One way to do this is to go into the `lucide` folder and run `git pull`. This will pull down the latest commits for the current branch, which should be `main`.

Then run `janet src/generate.janet` from the root of the repository. This should update the `src/lucide.jimage` file.

## Preview

To regenerate the preview page simply run `janet preview/preview.janet` from the root of the repository. This will update the `preview/preview.html` file.

## License

The `lucide` folder is a submodule with the official [lucide](https://github.com/lucide-icons/lucide) Git repository. See their license for that part. It was using ISC the last time I checked.

The rest is MIT - see the `LICENSE` file at the root of the repository for details.
