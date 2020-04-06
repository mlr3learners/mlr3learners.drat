
# mlr3learners.drat

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
above to your `~/.Rprofile` while keeping your currently set CRAN
mirror:

``` r
cran = getOption('repos')[['CRAN']] 
write(sprintf("options(repos = structure(c(CRAN = '%s',
  mlr3learners = 'https://mlr3learners.github.io/mlr3learners.drat')))",
   cran),
  file = "~/.Rprofile", append = TRUE)
```

**Note: Restart your R session to make use of the new option.**

With this, you are able to install any learner from the
[mlr3learners](https://github.com/mlr3learners) organization as simple
as

``` r
install.packages("mlr3learners.kernlab")
```

## Available packages

List of all available learners in this organization

    ## [1] "mlr3learners.c50"        "mlr3learners.extratrees"
    ## [3] "mlr3learners.fnn"        "mlr3learners.gbm"       
    ## [5] "mlr3learners.kernlab"    "mlr3learners.liblinear" 
    ## [7] "mlr3learners.mboost"     "mlr3learners.partykit"  
    ## [9] "mlr3learners.rweka"

## How it works

The package sources of the listed packages (including binaries for macOS
and Windows) are build during a CI run (once a week) and automatically
deployed to this repo. The work behind the scenes is highly simplified
by packages [{tic}](https://github.com/ropensci/tic) and
[{drat}](https://github.com/eddelbuettel/drat).

### How to add a mlr3learner to {mlr3learners.drat}

1.  Make sure your repo already uses GitHub Actions. If not, call
    `tic::use_ghactions_yml(deploy = TRUE)`.

2.  Source `init_mlr3learner_drat_deploy()` from [this
    Gist](https://gist.github.com/pat-s/be7b0ebc6953726d5a51a171742c3e21)
    and call the function with the name of the repo, e.g.
    `init_mlr3learner_drat_deploy("mlr3learners.mboost")`. This will add
    a private key as a “secret” to your repo and a public deploy key to
    [mlr3learners/mlr3learners.drat](https://github.com/mlr3learners/mlr3learners.drat),
    making it possible to deploy to the latter from your repo.

3.  Replace `TIC_DEPLOY_KEY: ${{ secrets.TIC_DEPLOY_KEY }}` by `id_rsa:
    ${{ secrets.id_rsa }}` in `.github/workflows/main.yml`.

4.  Replace the condition for steps “Before deploy” and “Deploy” with
    `if: matrix.config.r != 'devel'`. This enables deployment on all
    platforms but excludes builds that use R-devel.

5.  Now the macOS and Windows runners will push their binaries to
    mlr3learners.drat for every no-devel version (i.e. versions without
    .9000 at the end). The Linux runner will push the `.tar.gz` file to
    install the learner from source.

**Note**

It is very important to only init one CI run per release and then switch
directly to a dev version. Otherwise, binaries will be pushed during
every CI run, bloating up the repo size of
mlr3learners/mlr3learners.drat\](<https://github.com/mlr3learners/mlr3learners.drat>).
