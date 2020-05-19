get_stage("before_deploy") %>%
  add_step(step_setup_push_deploy(branch = "master", orphan = FALSE))

get_stage("deploy") %>%
  add_code_step(rmarkdown::render("README.Rmd")) %>%
  add_step(step_install_github("pat-s/drat@drat-archive")) %>%
  add_step(step_archive_drat()) %>%
  add_step(step_do_push_deploy(commit_paths = c("README.md", "bin/", "src/")))
