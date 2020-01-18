
# mlr3learners/mlr3learners.drat

[`drat`](https://github.com/eddelbuettel/drat) package repository for
the
[mlr3learners.drat](https://github.com/mlr3learners/mlr3learners.drat)
project.  
Install mlr3 learners from this repository
using

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

    ## [1] "mlr3learners.extratrees" "mlr3learners.fnn"       
    ## [3] "mlr3learners.ksvm"

## How it works

The package sources of the listed packages (including binaries for macOS
and Windows) are build during a CI run (once a week) and automatically
deployed to this repo. The work behind the scenes is highly simplified
by packages [{tic}](https://github.com/ropensci/tic) and
[{drat}](https://github.com/eddelbuettel/drat).

### How to add a mlr3learner to {mlr3learners.drat}

1.  Enable the learner on both Travis CI and Appveyor CI

<!-- end list -->

  - `travis::travis_enable(endpoint = ".org")`
  - Manual activation for Appveyor CI

<!-- end list -->

2.  Add `tic.R` and CI YAML files. Simplified by using
    
    ``` r
    tic::use_tic(wizard = FALSE, mac = "none", deploy = "travis", 
      travis_endpoint = ".org", travis_private_key_name = "id_rsa")
    ```

3.  Add `do_drat("mlr3learners/mlr3learners.drat")` to `tic.R`

4.  Copy [these two
    lines](\(https://github.com/mlr3learners/mlr3learners.extratrees/blob/master/appveyor.yml#L35-L36\))
    as env var “id\_rsa” into your `appveyor.yml` file.

5.  Now go to Travis CI (org) (`travis::browse_travis(endpoint =
    ".org")`) and delete the “id\_rsa” env var. Unfortunately Travis CI
    does not support encrypting SSH private keys via the CLI tool.
    Therefore, two options exist:
    
    1.  Ping @pat-s to add the private key which is also used for other
        mlr3learners repo to your repo as secure env var (preferred to
        have only one key stored in the repo).
    2.  Create a new SSH key pair. Add the private key as a secure env
        var “id\_rsa” to Travis CI for your repo. Then add the public
        key to {mlr3learners.drat}
