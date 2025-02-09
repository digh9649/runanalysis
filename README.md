# Run Analysis

To read in the necessary datasets, the script uses read.table. For the X test and train datasets, I named the functions using the features datasets and col.names function. 

Then the six datasets containing the results of the experiments, and subject information are merged using cbind and rbind, rbind merging for test and train and cbind for X, Y and subject information. 

Then used the select function to pull out the functions calculating STD and mean of the activities. 

Renamed the functions using gsub to make the tidy dataset easier to understand. 

Then calculated the mean of each function using summarise_all() and grouped by subject using group_by(). 

To export the dataset, used write.table. 
