Third submission:

* add `Additional_repositories` field in DESCRIPTION for reactR;
    thanks Uwe!

Resubmit with following corrections:

* replace \code{str()} with  'str()'  in DESCRIPTION
* remove Maintainer field in DESCRIPTION
* add reference to location of reactR in notes https://github.com/timelyportfolio/reactR and add to stop
in function that tries to use reactR

## Test environments
* local Windows 10 install, R 3.2.2
* ubuntu (on travis-ci), R 3.2.3
* rhub check_for_cran

## R CMD check results

0 errors | 0 warnings | 1 notes

* checking package dependencies ... NOTE
Package which this enhances but not available for checking: 'reactR'

'reactR' in development on Github at https://github.com/timelyportfolio/reactR. I plan to submit to CRAN soon.
