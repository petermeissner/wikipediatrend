Since last submission to CRAN:

- I changed the last sentence of the package description in DESCRIPTION as requested


Furthermore

- I added R-Core team as contributers because part of the code was derived from R base package
- I changed license to GPL-2 because part of the code was derived from R base package 
- What I derived is mentioned in DESCRIPTION as well as within the help files of
wp_date() (the derived generic and its methods)

- I changed default behaviour of the main function to not send any user-agent information along its HTTP requests to comply with cran repository policy

- I extinguished some spelling/grammar errors in the readme

- Travis was used to check package on Ubuntu - ok
- devtools::check() was used to check the package locally on windows machine - ok
- devtools::build() was used to check the package on remote windows machines - ok 
