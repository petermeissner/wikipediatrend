# Checking
# ------------------------------------

- Local Win8-64 (stable)

- winbuilder (release, devel) :
  http://win-builder.r-project.org/8fcQKvs7Q189/
  http://win-builder.r-project.org/E4UN8gKL0LgL/
  
  
- Travis Ubuntu (old, release, devel)
  https://travis-ci.org/petermeissner/wikipediatrend


# Submission comments 
# and --> actions taken
# ------------------------------------

- CRAN asked me to fix a problem with the vignette (wp_trend() breaking because of NA input)

--> I rewrote the code so that such problems should not re-occur 


- CRAN policies have changed in the meantime so that imports from non 'base' R should be made explicit - I did so 

