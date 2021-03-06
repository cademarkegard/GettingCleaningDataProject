Getting Cleaning Data Project
==========================

Submission for Getting and Cleaning Data Project for Johns Hopkins Coursera Specialization

Using the UCI HAR Data extracted into the working directory the ```"run_analysis.R"``` script takes the training and test data combining it into a tidy dataset called ```"UCI_HAR_TIDY.txt"```. This code also gives non-numeric labels for the activities each subject has done. The tidy dataset has columns for the subject of the test, the activity they were doing, and the mean of the sensor data. In the CodeBook.md there are a list of the variables which the mean has been taken of.  

Requires packages:

`dplyr`
`tidyr`

Open in R:
```r
source("run_analysis.R")
```

This will output the ```UCI_HAR_TIDY.txt``` data set. This script works by reading in the training and test data, matches it up with the subject and their activity. Then from this table one can extract the tidy data by grouping by subject and their activity (using ```dplyr``` module). 
