# Testing

- local Win7 / Win8 
- local Ubuntu 14.04 LTS
- winbuild
- Travis (Ubuntu) : https://travis-ci.org/petermeissner/wikipediatrend
- Apveyor (Windows) : https://ci.appveyor.com/project/petermeissner/wikipediatrend


# Submission Comments and responses / actions taken

- Single-quote 'stats.grok.se': see the manual.  Preferably give it correctly as 'http://stats.grok.se'.
-> done


- Suggests or Enhances not in mainstream repositories: AnomalyDetection, BreakoutDetection
-> added ...-
Additional_repositories: 'http://ghrr.github.io/drat'
to the DESCRIPTION file. Both packages can be installed via usage of install.packages() : 
install.packages("AnomalyDetection", repos = "http://petermeissner.github.io/drat/", type="source")
install.packages("BreakoutDetection", repos = "http://petermeissner.github.io/drat/", type="source")
