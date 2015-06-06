
# Checking

- Local  Win7-32 / Win8-64
- Local Ubuntu 14.10

- winbuilder 
- Travis (Ubuntu) : https://travis-ci.org/petermeissner/wikipediatrend



# Submission comments/responses -> actions taken


This installs packages in the user's file space (e.g. his personal library) without asking permission.  That violates
 
'Packages should not write in the users’ home filespace, nor anywhere else on the file system apart from the R session’s temporary directory'
 
The package has been removed from CRAN.


-> I removed those lines from the vignette that - if build - installed two packages from ghrr repository if they were not on the system already
