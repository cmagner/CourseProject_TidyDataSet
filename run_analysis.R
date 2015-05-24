#==============================================================================
#
# DESCRIPTION:
#
#   This file contains the R source code for the run_analysis() function.
#
#   The purpose of the run-analysis() function is to create a tidy data set
#   from the UCI HAR Dataset which was collected from the accelerometer and
#   gyroscope in the Samsung Galaxy S smartphone.
#
#   The code does the following:
#   * Merges the training and the test data sets to create one data set. 
#
#   * Extracts only the features corresponding to a mean or standard deviation. 
#
#   * Uses descriptive activity names to name the activities in the data set. 
#
#   * Appropriately labels the data set with descriptive variable names.
#
#   * Creates a second, independent tidy data set with the average of each 
#       feature variable for each activity and each subject.
#
#   Further details of the data set and analysis steps can be found in the 
#   README.md and CodeBook.md files which accompany this file.
#
#==============================================================================

run_analysis <- function() {

    library(dplyr)
    library(tidyr)
    
    
    #--------------------------------------------------------------------------
    # Read in all data from the downloaded data set
    
    print("Reading in feature and activity tables...")
    feature <- tbl_df( read.table("UCI HAR Dataset/features.txt") )
    activity <- tbl_df( read.table("UCI HAR Dataset/activity_labels.txt") )
    
    print("Reading in the training data...")
    subject_train <- tbl_df( read.table("UCI HAR Dataset/train/subject_train.txt") )
    X_train <- tbl_df( read.table("UCI HAR Dataset/train/X_train.txt") )
    y_train <- tbl_df( read.table("UCI HAR Dataset/train/y_train.txt") )
    
    print("Reading in the testing data...")
    subject_test <- tbl_df( read.table("UCI HAR Dataset/test/subject_test.txt") )
    X_test <- tbl_df( read.table("UCI HAR Dataset/test/X_test.txt") )
    y_test <- tbl_df( read.table("UCI HAR Dataset/test/y_test.txt") )
    
    
    #--------------------------------------------------------------------------
    # Merge the training and testing data sets
    
    print("Merging the training and testing data sets...")
    
    merged_data <- rbind( X_train, X_test )
    
    # Remove the large data files to free up memory
    rm("X_train")
    rm("X_test")
    
    
    #--------------------------------------------------------------------------
    # Add descriptive variable names to the merged data set
    
    names(merged_data) <- feature$V2
    
    
    #--------------------------------------------------------------------------
    # Utilize only mean and standard deviation features    
        
    print("Extracting relevant data...")
    
    extracted_data <- 
        
        # First drop columns with duplicated feature names. None of these 
        # are germaine to the data to be extracted and they "confuse" some of 
        # the "dplyr" functions.
        merged_data[ , -feature[duplicated(feature$V2),]$V1 ] %>%
        
        # Next, drop all of the "angle()" measurements.  These feature 
        # names do not follow the naming convention of the other features
        # and they are not germaine to the data to be extracted.
        select( -contains("angle(") ) %>%
        
        # Finally, discard any columns whose names don't contain either mean()
        # or std()
        select( matches("(mean\\(\\))|(std\\(\\))") )
    
        
    #------------------------------------------------------------------------------
    # Add descriptive activity names and subject IDs to the data set
    
    print("Creating the tidy data set...")
    
    named_activities <- activity$V2[ c( y_train$V1, y_test$V1 ) ]
    subject_ids <- c( subject_train$V1, subject_test$V1 )
    
    extracted_data <-
        extracted_data %>% 
        mutate( Activity = named_activities, Subject = subject_ids )    
    
    
    #------------------------------------------------------------------------------
    # Create a tidy data set with the average of each variable for each activity 
    # and each subject.
            
    tidy_data <-
        extracted_data %>%
        select( Subject, Activity, 1:(ncol(extracted_data)-2) ) %>%
        group_by( Subject, Activity ) %>%
        summarise_each( funs(mean) )
    
    # Adjust the names of the feature columns to reflect that they are now
    # mean() values
    col_names <- names(tidy_data)
    names(tidy_data) <-
        c("Subject","Activity", paste("mean(",col_names[-(1:2)],")",sep="") )
    

    #------------------------------------------------------------------------------
    # Save the extracted and tidy data sets to CSV files.
    
    print("Saving the extracted and tidy data to files...")
    
    write.csv( extracted_data, "extracted_data.csv", row.names=FALSE )
    write.csv( tidy_data, "tidy_data.csv", row.names=FALSE )
    
    print("Done.")
}
