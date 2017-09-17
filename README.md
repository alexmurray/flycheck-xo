# Flycheck XO Checker

[![License GPL 3](https://img.shields.io/badge/license-GPL_3-green.svg)](http://www.gnu.org/licenses/gpl-3.0.txt)
[![MELPA](http://melpa.org/packages/flycheck-xo-badge.svg)](http://melpa.org/#/flycheck-xo)
[![Build Status](https://travis-ci.org/alexmurray/flycheck-xo.svg?branch=master)](https://travis-ci.org/alexmurray/flycheck-xo)

Integrate [XO](https://github.com/sindresorhus/xo)
with [flycheck](http://www.flycheck.org) to automatically check the style of
your JavaScript code on the fly.

## Installation

### MELPA (coming soon)

The preferred way to install `flycheck-xo` is via
[MELPA](http://melpa.org) - then you can just <kbd>M-x package-install RET
flycheck-xo RET</kbd>

To enable then simply add the following to your init file:

```emacs-lisp
(with-eval-after-load 'flycheck
  (require 'flycheck-xo)
  (flycheck-xo-setup))
```

### Pallet

If you use [Pallet](https://github.com/rdallasgray/pallet) to manage your emacs packages, add the following line to your `~/.emacs.d/Cask`:

```emacs-lisp
(depends-on "flycheck-xo" :git "https://github.com/alexmurray/flycheck-xo" :ref "master")
```

Then do `M-x pallet-install` in your emacs, and finally add this to your init file:

```emacs-lisp
(require 'flycheck-xo)
(flycheck-xo-setup)
```

### Manual

If you would like to install the package manually, download or clone it and
place within Emacs' `load-path`, then you can require it in your init file like
this:

```emacs-lisp
(require 'flycheck-xo)
(flycheck-xo-setup)
```

NOTE: This will also require the manual installation of `flycheck` if you have
not done so already.

## License

Copyright © 2017 Alex Murray

Distributed under GNU GPL, version 3.
