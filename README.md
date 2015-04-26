# cleaningdata
## Course project for Getting and Cleaning Data

### How the script works
The run_analysis.R script assumes that the data is located in the same directory with subdirectories for ..\test and ..\train.

First, the script loads the "lookup" data from files.  One file relates the Activity Code (integer 1 through 6) with the Activity Name (descriptive text).  The second file contains the list of 561 features measured in the observation data.

Next, we load the observation data from the test data set.  Observations come from three files:
- The first contains a single column with an identifier for the test subject (person being observed).
- The second contains a single column with the activity (walking, laying, etc.)
- The third contains the 561 measurements.

After loading each file into a separate data frame, the script combines them into a single data frame for test data.

The script then repeats the loading and combining steps above for the training data.

With test data and training data in two data frames, the script then appends training data to the test data in a new data frame.

This data frame now contains all observations, but still contains the numeric code for the Activity.  The script then joins the Activity code from the observation data frame with the Activity lookup table loaded at the outset to add a meaningful Activity Description to the combined data frame.  This data from now has over 10000 rows and 564 columns.

Since we are only interested in the mean and standard deviation measurements, we create a new data frame that selects just those columns.  This results in about 75 columns and represents a tidy dataset for step 4 of the assignment instructions.

To get the dataset for step 5 of the assignment, we use the group_by() and summarise_each() functions from the dplyr package to group by Subject Number and Activity Name, taking the average (mean) of all other columns.

Finally, this data frame is written out to a file.

