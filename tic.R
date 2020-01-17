# installs dependencies, runs R CMD check, runs covr::codecov()
do_package_checks()

get_stage("before_deploy") %>%
  add_step(step_setup_push_deploy(branch = "master", orphan = FALSE))

get_stage("deploy") %>%
  add_code_step(rmarkdown::render("README.Rmd")) %>%
  add_step(step_do_push_deploy(commit_paths = "README.md"))
