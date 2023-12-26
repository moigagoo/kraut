# Changelog

-   [!]—backward incompatible change
-   [+]—new feature
-   [f]—bugfix
-   [r]—refactoring
-   [t]—test suite improvement
-   [d]—docs improvement


## 1.1.0 (December 26, 2023)

-   [!] Require Karax 1.3.3.
-   [f] Fix query param parsing.


## 1.0.3 (July 31, 2023)

-   [r] Lower the required Nim version.


## 1.0.2 (April 16, 2023)

-   [+] Extract query params from URL and store in `qryParams` attribute of `Context` instance (see [#2](https://github.com/moigagoo/kraut/issues/2)).


## 1.0.1 (March 7, 2023)

-   [+] Add `defaultRenderer` param to `routeRenderer` to handle the Not Found situation.
-   [+] Add `kraut/sugar` module with `routes` macro to generate routes table from module names.


## 1.0.0 (February 27, 2023)

-   🎉 initial release.

