
# mlr3learners/mlr3learners.drat

[`drat`](https://github.com/eddelbuettel/drat) package repository for
the
[mlr3learners.drat](https://github.com/mlr3learners/mlr3learners.drat)
project.  
Install mlr3 learners from this repository using

``` r
install.packages(..., repos = "https://mlr3learners.github.io/mlr3learners.drat")
```

To omit having to pass the `repos` argument every single time, add the
following to your `.Rprofile`:

``` r
options(repos = structure(c(getOption("repos"),
  mlr3learners = "https://mlr3learners.github.io/mlr3learners.drat")))
```

This will append this drat repo to your list of available repositories
which `install.packages()` will check when trying to install a package.
If you want a c/p command for this: The following will append the line
above to your `~/.Rprofile`:

``` r
write("options(repos = structure(c(getOption('repos'),
  mlr3learners = 'https://mlr3learners.github.io/mlr3learners.drat')))",
  file = "~/.Rprofile", append = TRUE)
```

With this, you are able to install any learner from the
[mlr3learners](https://github.com/mlr3learners) organization as simple
as

``` r
install.packages("mlr3learners.ksvm")
```

## Available packages

List of all available learners in this organization

    ## [1] "mlr3learners.ksvm"

## How it works

The package sources of the listed packages (including binaries for macOS
and Windows) are build during a CI run (once a week) and automatically
deployed to this repo. The work behind the scenes is highly simplified
by packages [{tic}](https://github.com/ropensci/tic) and
[{drat}](https://github.com/eddelbuettel/drat).
