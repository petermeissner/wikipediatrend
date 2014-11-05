YOUR REQUESTS AND MY ACTIONS TAKEN 
-- sorry for the inconveniences, I hope everything works now -- 

* checking top-level files ... NOTE
Non-standard file/directory found at top level:
  ‘cran-comments.md’
  
  --> file is now excluded from built

* Also, pls use the MIT license as explained on the R license page.

  --> reduced LICENSE file to two lines:
    YEAR: 2014
    COPYRIGHT HOLDER: Peter Meissner
  --> License in DESCRIPTION: 
    License: MIT + file LICENSE

* Finally, pls use title case and no final period for the title.

  --> title in DESCRIPTION changed to:
  Public Subject Attention via Wikipedia Page Access Statistics


BEFORE SUBMISSION TO CRAN

* package was checked via 
    - R CMD check on Win7 64 system -- OK
    - Travis Ubuntu build //  https://travis-ci.org/petermeissner/wikipediatrend -- OK
    - devtools::build_win() -- OK 