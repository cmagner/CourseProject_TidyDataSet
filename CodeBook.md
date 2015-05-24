---
title: "CodeBook.md"
author: "Chris Magner"
date: "Friday, May 22, 2015"
output: html_document
---

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

## Table of Contents

- [The Study Design](#lnk_StudyDesign)

    - [The UCI HAR DataSet](#lnk_RawData)
        - [Overview](#lnk_OrgOverview)
        - [Definition of Terms](#lnk_Terms)
        - [Raw Signals Collection and Processing](#lnk_RawSignals)
        - [Feature Definitions](#lnk_FeatureDefs)
        - [Feature Name Syntax](#lnk_NameSyntax)
        
    - [The Extracted Data Set](#lnk_ExtractedData)
        - [Overview](#lnk_ExtOverview)
        - [Merging the Training and Testing Data Sets](#lnk_Merging)
        - [Selecting Variables from the Raw Data Set](#lnk_Selecting)
        - [Creating the Subject and Activity Variables](#lnk_ActAndSub)
        
    - [The Tidy Data Set](#lnk_TidyData)
        - [Overview](#lnk_TidyOverview)
        - [Creating the Average Measurement for Each Subject and Activity](#lnk_Averages)
    
- [The Code Book](#lnk_CodeBook)

    - [The Extracted Data Table](#lnk_extCodeBook)
    
    - [The Tidy Data Set Table](#lnk_tidyCodeBook)
        
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

## The Study Design                         <a id="The Study Design"></a>

-------------------------------------------------------------------------------

### The UCI HAR Dataset                     <a id="lnk_RawData"></a>

#### Overview                               <a id="lnk_OrgOverview"></a>

See the *README.txt* file included in the UCI HAR Dataset for information about
each of the files.  See the *features_info.txt* file for details of the 
features in the UCI HAR Dataset.

#### Definition of Terms                    <a id="lnk_Terms"></a>

- <a id="lnk_varSubject"></a>   **Subject**                              
    - Thirty volunteers, aged 19-48 years, were utilized in the creation of 
        this data.  Each person wore a Samsung Galaxy S II smartphone on their
        waist and is referred to in the data set as a subject.  Subjects are
        identified by the integer numbers 1 through 30.

- <a id="lnk_varActivity"></a>  **Activity**
    - Each subject performed six activities: WALKING, WALKING_UPSTAIRS, 
        WALKING_DOWNSTAIRS, SITTING, STANDING, and LAYING.  For each subject
        a number observations were performed for each activity (for each
        subject).
        
- **Feature**
    - Refers to a specific variable recorded or calculated from
        an observation of a particular subject performing a particular activity.

- **Feature Vector**
    - The set of all 561 feature variables for a specific observation of a 
        particular subject performing a particular activity is referred to as a
        feature vector.

- **Training** and **Test** sets
    - The data set contains a total of 10,299 observations of each feature
        vector.  These are broken into two randomly selected data sets - a 
        training set containing 70% of the observations (7,352 observations)
        and a test set containing 30% of the observations (2,947 observations).

#### Raw Signals Collection and Processing  <a id="lnk_RawSignals"></a>

- **Raw Signals Collected**
    - X, Y, and Z axial time-domain signals were collected from the Samsung 
        Galaxy S II smartphone's accelerometer and gyroscope at a fixed 
        sampling rate of 50 Hz. These are referred to as follows where 
        [**?**] = X, Y, or Z:
        - **tAcc-**[**?**] 
        - **tGyro-**[**?**] 
                
- **Raw Signal Processing**
    - Noise was removed from all six of these signals using a median filter and
        a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz.
        This data was then sampled in fixed-width sliding windows of 2.56 seconds
        with 50% overlap to produce 128 samples for each raw signal.         
        
    - The acceleration signals were then separated into component time-domain
        body and gravity acceleration signals using another low pass 
        Butterworth filter.  The gravitational force is assumed to have only 
        low frequency components, therefore a filter corner frequency of 0.3 Hz
        was used. These are referred to as follows where [**?**] = X, Y, or Z:
        - **tBodyAcc-**[**?**] 
        - **tGravityAcc-**[**?**] 
        
    - NOTE: The **tBodyGyro-XYZ** signal is used to generate several 
        features but the UCI HAR Dataset makes no specific mention of how it 
        is calculated.
        
    - The first derivative of the body linear acceleration and the second 
        derivative of the angular velocity time domain signals were taken to 
        obtain Jerk signals for each. These are referred to as follows where 
        [**?**] = X, Y, or Z:
        - **tBodyAccJerk-**[**?**]
        - **tBodyGyroJerk-**[**?**]      
        
    - A 3-dimensional vector magnitude was calculated using the Euclidean 
        norm for the body acceleration, gravity acceleration, body Jerk 
        acceleration, the body gyroscopic magnitude, and the body gyroscopic 
        jerk magnitude. These are referred to as follows:
        - **tBodyAccMag**
        - **tGravityAccMag**
        - **tBodyAccJerkMag**
        - **tBodyGyroMag**
        - **tBodyGyroJerkMag**
        
    - Using a Fast Fourier Transform (FFT), frequency domain signals were 
        generated for the 3 axial signals of the body acceleration, body Jerk
        acceleration, and body gyroscopic angular velocity. These are referred
        to as follows where [**?**] = X, Y, or Z:
        - **fBodyAcc-**[**?**]
        - **fBodyAccJerk-**[**?**]
        - **fBodyGyro-**[**?**]      

    - Frequency domain signals were also generated using an FFT from the
        time domain vector magnitude signals of the body acceleration, body 
        jerk acceleration, 
        body gyroscopic angular velocity, and body gyroscopic angular jerk.
        These are referred to as follows:
        - **fBodyAccMag**
        - **fBodyAccJerkMag**
        - **fBodyGyroMag**
        - **fBodyGyroJerkMag**

#### Feature Definitions                    <a id="lnk_FeatureDefs"></a>

- The following signals (defined above) are used to estimate variables of the
    feature vector for each pattern where [**?**] = X, Y, or Z and denotes a 
    particular axial direction:  
        - **tBodyAcc-**[**?**]    
        - **tBodyGyro-**[**?**]    
        - **tGravityAcc-**[**?**]    
        - **tBodyAccJerk-**[**?**]    
        - **tBodyGyroJerk-**[**?**]        
        - **tBodyAccMag**    
        - **tGravityAccMag**    
        - **tBodyAccJerkMag**    
        - **tBodyGyroMag**    
        - **tBodyGyroJerkMag**    
        - **fBodyAcc-**[**?**]     
        - **fBodyAccJerk-**[**?**]     
        - **fBodyGyro-**[**?**]           
        - **fBodyAccMag**    
        - **fBodyAccJerkMag**      
        - **fBodyGyroMag**     
        - **fBodyGyroJerkMag**     

- The following functions are applied to this set of signals to generate the
    features:     
    
    | Function      | Description |
    | :------------ | :---------- |
    | mean()        | Mean value |
    | std()         | Standard deviation |
    | mad()         | Median absolute deviation  |
    | max()         | Largest value in array |
    | min()         | Smallest value in array |
    | sma()         | Signal magnitude area |
    | energy()      | Energy measure. Sum of the squares divided by the number of values.  |
    | iqr()         | Interquartile range  |
    | entropy()     | Signal entropy |
    | arCoeff()     | Autorregresion coefficients with Burg order equal to 4 |
    | correlation() | correlation coefficient between two signals |
    | maxInds()     | index of the frequency component with largest magnitude |
    | meanFreq()    | Weighted average of the frequency components to obtain a mean frequency |
    | skewness()    | skewness of the frequency domain signal  |
    | kurtosis()    | kurtosis of the frequency domain signal  |
    | bandsEnergy() | Energy of a frequency interval within the 64 bins of the FFT of each window. |
    | angle()       | Angle between to vectors. |

- The following vectors are obtained by averaging the their respective signals
    samples over the collection window and are used as inputs to the angle 
    function:
        - gravityMean
        - tBodyAccMean
        - tBodyAccJerkMean
        - tBodyGyroMean
        - tBodyGyroJerkMean

- Note that features are normalized and bounded within [-1,1].

- The complete list of variables of each feature vector is available in 
    *features.txt* file included with the UCI HAR Dataset.

#### Feature Name Syntax                    <a id="lnk_NameSyntax"></a>

- The syntax for most of the feature names is 
    ```
    [measurement category]-[function]-[optional measurement subcategory] 
    ```
    For example, 

    - The feature name **tBodyAcc-mean()-X** corresponds to the **mean()** of
      the signal measurement **tBodyAcc** for subcategory **X** (the x axis).
      
    - The feature name **fBodyBodyGyroMag-energy()** corresponds to the 
      **energy()** of the signal measurement **fBodyBodyGyroMag**.

- There a few feature names which do not follow this syntax but those are not
    required to be in the tidy data set to be produced in this project assignment.
    For example, 

    - **angle(tBodyAccJerkMean),gravityMean)**

-------------------------------------------------------------------------------

### The Extracted Data Set                  <a id="lnk_ExtractedData"></a>

#### Overview                               <a id="lnk_ExtOverview"></a>

The extracted data set table is generated by the **run_analysis()** function and 
captured in the *extracted_data.csv* file .  It contains 10,299 observations of 
68 variables representing a selected subset of feature variables from the combined 
training and testing data sets of the UCI HAR Dataset.  In addition, two new 
variables are included which indicate the subject and activity associated with 
each observation.

#### Merging the Training and Testing Data Sets     <a id="lnk_Merging"></a>

- The feature vectors from the training data set (contained in the UCI HAR Dataset
    file *X_train.txt*) and the testing data set (contained in the *X_train.txt* 
    file) are combined into a single table using the following R code...
    ```{r}
    X_train <- tbl_df( read.table("UCI HAR Dataset/train/X_train.txt") )
    X_test <- tbl_df( read.table("UCI HAR Dataset/test/X_test.txt") )
    merged_data <- rbind( X_train, X_test )
    ```
- This table is then given descriptive variable names (taken from the 
    *features.txt* file) using the following R code...
    ```{r}
    feature <- tbl_df( read.table("UCI HAR Dataset/features.txt") )
    names(merged_data) <- feature$V2
    ```

#### Selecting Variables from the Raw Data Set      <a id="lnk_Selecting"></a>

- Our goal is to extract all feature variables which correspond to a mean or 
    standard deviation value.  These variables will all contain "mean()" or 
    "std()" as the function subcomponent in their feature names.  (See
    [Feature Definitions](#lnk_FeatureDefs) and 
    [Feature Name Syntax](#lnk_NameSyntax) above for details on how features
    are named.)  

- The following R code extracts the desired features from the feature vector...
    ```{r}
    extracted_data <- 
        
        # First drop columns with duplicated feature names. None of these 
        # are germaine to the data to be extracted and they "confuse" some of 
        # the "dplyr" functions.
        merged_data[ , -feature[duplicated(feature$V2),]$V1 ] %>%
        
        # Next, drop all of the "angle()" features.  These features 
        # names do not follow the naming convention of the others
        # and they are not germaine to the data to be extracted.
        select( -contains("angle(") ) %>%
        
        # Finally, discard any columns whose names don't contain either mean()
        # or std()
        select( matches("(mean\\(\\))|(std\\(\\))") )
    ```    

#### Creating the Subject and Activity Variables    <a id="lnk_ActAndSub"></a>

- The *y_train.txt* file contains the integer values corresponding the activity
    performed for each observation in the training data set from the 
    *X_train.txt* file.  Similarly, the *y_train.txt* file contains the integer
    values corresponding to the activities performed for each observation in the
    testing data set from the *X_test.txt* file.  Earlier we merged the training
    and testing data sets together, now we must merge their corresponding
    integer activity values.  Then we can use the combined vector to lookup the
    actual text activity names from the *activity_labels.txt* file.
    
- The following R code does this...
    ```{r}
    activity <- tbl_df( read.table("UCI HAR Dataset/activity_labels.txt") )
    y_train <- tbl_df( read.table("UCI HAR Dataset/train/y_train.txt") )
    y_test <- tbl_df( read.table("UCI HAR Dataset/test/y_test.txt") )

    named_activities <- activity$V2[ c( y_train$V1, y_test$V1 ) ]
    ```
    
- Likewise, the subject ID values for each observation are split across the
    *subject_train.txt* and *subject_test.txt* files.  We now merge them to
    generate a vector of subject IDs corresponding to each observation in the 
    extracted data table.
    
- The following R code does this...
    ```{r}
    subject_train <- tbl_df( read.table("UCI HAR Dataset/train/subject_train.txt") )
    subject_test <- tbl_df( read.table("UCI HAR Dataset/test/subject_test.txt") )

    subject_ids <- c( subject_train$V1, subject_test$V1 )
    ```
    
- Now we can add the Activity and Subject variables to the extracted data table
    as demonstrated by the following R code...
    ```{r}
    extracted_data <-
        extracted_data %>% 
        mutate( Activity = named_activities, Subject = subject_ids )    
    ```    

-------------------------------------------------------------------------------

### The Tidy Data Set                      <a id="lnk_TidyData"></a>

#### Overview                               <a id="lnk_TidyOverview"></a>

The tidy data set table is generated by the **run_analysis()** function and 
captured in the *tidy_data.csv* file.  It contains 180 observations of 
68 variables.  The Subject and Activity variables are taken verbatim from the
extracted data table.  The other 66 variables represent the average of each 
feature variable from the extracted data table for a particular subset 
of subject and activity.

#### Creating the Average Measurement for Each Subject and Activity  <a id="lnk_Averages"></a>

- For each activity performed by each subject, we want the average value of the
    corresponding observations for each feature variable in the extracted data
    table.  

- The following R code does this...
    ```{r}
    # Create a tidy data set with the average of each variable for each activity 
    # and each subject.            
    tidy_data <-
        extracted_data %>%
        select( Subject, Activity, 1:(ncol(extracted_data)-2) ) %>%
        group_by( Subject, Activity ) %>%
        summarise_each( funs(mean) )
    
    # Adjust the names of the feature variable columns to reflect that they are now
    # mean() values
    col_names <- names(tidy_data)
    names(tidy_data) <-
        c("Subject","Activity", paste("mean(",col_names[-(1:2)],")",sep="") )
    ```        
    
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

## The Code Book                            <a id="lnk_CodeBook"></a>

-------------------------------------------------------------------------------

### The Extracted Data Table                <a id="lnk_extCodeBook"></a> 

- The following table provides the codebook for the extracted data table.  

- See the [The Extracted Data Set](#lnk_ExtractedData) section above for 
    details on how the variables in this table are generated.
    
- Note - For columns with no description see the 
    [Feature Definitions](#lnk_FeatureDefs) section of this document for 
    details of how the UCI HAR Data features are named and computed.
    
| Column | Variable Name               | Units                 | Description |
| :----: | :-------------------------- | :-------------------: | :---------- |
|    1   | Subject                     | *NA*                  | [see Subject details](#lnk_varSubject) |
|    2   | Activity                    | *NA*                  | [see Activity details](#lnk_varActivity) |
|    3   | tBodyAcc-mean()-X           | m/s<sup>2</sup>       |             |
|    4   | tBodyAcc-mean()-Y           | m/s<sup>2</sup>       |             |
|    5   | tBodyAcc-mean()-Z           | m/s<sup>2</sup>       |             |
|    6   | tBodyAcc-std()-X            | m/s<sup>2</sup>       |             |
|    7   | tBodyAcc-std()-Y            | m/s<sup>2</sup>       |             |
|    8   | tBodyAcc-std()-Z            | m/s<sup>2</sup>       |             |
|    9   | tGravityAcc-mean()-X        | m/s<sup>2</sup>       |             |
|    0   | tGravityAcc-mean()-Y        | m/s<sup>2</sup>       |             |
|   11   | tGravityAcc-mean()-Z        | m/s<sup>2</sup>       |             |
|   12   | tGravityAcc-std()-X         | m/s<sup>2</sup>       |             |
|   13   | tGravityAcc-std()-Y         | m/s<sup>2</sup>       |             |
|   14   | tGravityAcc-std()-Z         | m/s<sup>2</sup>       |             |
|   15   | tBodyAccJerk-mean()-X       | m/s<sup>3</sup>       |             |
|   16   | tBodyAccJerk-mean()-Y       | m/s<sup>3</sup>       |             |
|   17   | tBodyAccJerk-mean()-Z       | m/s<sup>3</sup>       |             |
|   18   | tBodyAccJerk-std()-X        | m/s<sup>3</sup>       |             |
|   19   | tBodyAccJerk-std()-Y        | m/s<sup>3</sup>       |             |
|   20   | tBodyAccJerk-std()-Z        | m/s<sup>3</sup>       |             |
|   21   | tBodyGyro-mean()-X          | radians/s             |             |
|   22   | tBodyGyro-mean()-Y          | radians/s             |             |
|   23   | tBodyGyro-mean()-Z          | radians/s             |             |
|   24   | tBodyGyro-std()-X           | radians/s             |             |
|   25   | tBodyGyro-std()-Y           | radians/s             |             |
|   26   | tBodyGyro-std()-Z           | radians/s             |             |
|   27   | tBodyGyroJerk-mean()-X      | radians/s<sup>3</sup> |             |
|   28   | tBodyGyroJerk-mean()-Y      | radians/s<sup>3</sup> |             |
|   29   | tBodyGyroJerk-mean()-Z      | radians/s<sup>3</sup> |             |
|   30   | tBodyGyroJerk-std()-X       | radians/s<sup>3</sup> |             |
|   31   | tBodyGyroJerk-std()-Y       | radians/s<sup>3</sup> |             |
|   32   | tBodyGyroJerk-std()-Z       | radians/s<sup>3</sup> |             |
|   33   | tBodyAccMag-mean()          | m/s<sup>2</sup>       |             |
|   34   | tBodyAccMag-std()           | m/s<sup>2</sup>       |             |
|   35   | tGravityAccMag-mean()       | m/s<sup>2</sup>       |             |
|   36   | tGravityAccMag-std()        | m/s<sup>2</sup>       |             |
|   37   | tBodyAccJerkMag-mean()      | m/s<sup>3</sup>       |             |
|   38   | tBodyAccJerkMag-std()       | m/s<sup>3</sup>       |             |
|   39   | tBodyGyroMag-mean()         | radians/s             |             |
|   40   | tBodyGyroMag-std()          | radians/s             |             |
|   41   | tBodyGyroJerkMag-mean()     | radians/s<sup>3</sup> |             |
|   42   | tBodyGyroJerkMag-std()      | radians/s<sup>3</sup> |             |
|   43   | fBodyAcc-mean()-X           | m/s<sup>2</sup>       |             |
|   44   | fBodyAcc-mean()-Y           | m/s<sup>2</sup>       |             |
|   45   | fBodyAcc-mean()-Z           | m/s<sup>2</sup>       |             |
|   46   | fBodyAcc-std()-X            | m/s<sup>2</sup>       |             |
|   47   | fBodyAcc-std()-Y            | m/s<sup>2</sup>       |             |
|   48   | fBodyAcc-std()-Z            | m/s<sup>2</sup>       |             |
|   49   | fBodyAccJerk-mean()-X       | m/s<sup>3</sup>       |             |
|   50   | fBodyAccJerk-mean()-Y       | m/s<sup>3</sup>       |             |
|   51   | fBodyAccJerk-mean()-Z       | m/s<sup>3</sup>       |             |
|   52   | fBodyAccJerk-std()-X        | m/s<sup>3</sup>       |             |
|   53   | fBodyAccJerk-std()-Y        | m/s<sup>3</sup>       |             |
|   54   | fBodyAccJerk-std()-Z        | m/s<sup>3</sup>       |             |
|   55   | fBodyGyro-mean()-X          | radians/s             |             |
|   56   | fBodyGyro-mean()-Y          | radians/s             |             |
|   57   | fBodyGyro-mean()-Z          | radians/s             |             |
|   58   | fBodyGyro-std()-X           | radians/s             |             |
|   59   | fBodyGyro-std()-Y           | radians/s             |             |
|   60   | fBodyGyro-std()-Z           | radians/s             |             |
|   61   | fBodyAccMag-mean()          | m/s<sup>2</sup>       |             |
|   62   | fBodyAccMag-std()           | m/s<sup>2</sup>       |             |
|   63   | fBodyBodyAccJerkMag-mean()  | m/s<sup>3</sup>       |             |
|   64   | fBodyBodyAccJerkMag-std()   | m/s<sup>3</sup>       |             |
|   65   | fBodyBodyGyroMag-mean()     | radians/s             |             |
|   66   | fBodyBodyGyroMag-std()      | radians/s             |             |
|   67   | fBodyBodyGyroJerkMag-mean() | radians/s<sup>3</sup> |             |
|   68   | fBodyBodyGyroJerkMag-std()  | radians/s<sup>3</sup> |             |

-------------------------------------------------------------------------------

### The Tidy Data Set Table                 <a id="lnk_tidyCodeBook"></a>

- The table which follows provides the codebook for the tidy data table.  

- See the [The Tidy Data Set](#lnk_TidyData) section above for 
    details on how the variables in this table are generated.
    
- Note - Columns with no description correspond to the average of all 
    observations which are associated with a particular subject and activity for 
    the feature variable whose name is enclosed within **mean( )**. See the 
    [Feature Definitions](#lnk_FeatureDefs) section of this document for details
    of how features are named and computed.
    
| Column | Variable Name                     | Units                 | Description |
| :----: | :-------------------------------- | :-------------------: | :---------- |
|    1   | Subject                           | *NA*                  | [see Subject details](#lnk_varSubject) |
|    2   | Activity                          | *NA*                  | [see Activity details](#lnk_varActivity) |
|    3   | mean(tBodyAcc-mean()-X)           | m/s<sup>2</sup>       |             |
|    4   | mean(tBodyAcc-mean()-Y)           | m/s<sup>2</sup>       |             |
|    5   | mean(tBodyAcc-mean()-Z)           | m/s<sup>2</sup>       |             |
|    6   | mean(tBodyAcc-std()-X)            | m/s<sup>2</sup>       |             |
|    7   | mean(tBodyAcc-std()-Y)            | m/s<sup>2</sup>       |             |
|    8   | mean(tBodyAcc-std()-Z)            | m/s<sup>2</sup>       |             |
|    9   | mean(tGravityAcc-mean()-X)        | m/s<sup>2</sup>       |             |
|    0   | mean(tGravityAcc-mean()-Y)        | m/s<sup>2</sup>       |             |
|   11   | mean(tGravityAcc-mean()-Z)        | m/s<sup>2</sup>       |             |
|   12   | mean(tGravityAcc-std()-X)         | m/s<sup>2</sup>       |             |
|   13   | mean(tGravityAcc-std()-Y)         | m/s<sup>2</sup>       |             |
|   14   | mean(tGravityAcc-std()-Z)         | m/s<sup>2</sup>       |             |
|   15   | mean(tBodyAccJerk-mean()-X)       | m/s<sup>3</sup>       |             |
|   16   | mean(tBodyAccJerk-mean()-Y)       | m/s<sup>3</sup>       |             |
|   17   | mean(tBodyAccJerk-mean()-Z)       | m/s<sup>3</sup>       |             |
|   18   | mean(tBodyAccJerk-std()-X)        | m/s<sup>3</sup>       |             |
|   19   | mean(tBodyAccJerk-std()-Y)        | m/s<sup>3</sup>       |             |
|   20   | mean(tBodyAccJerk-std()-Z)        | m/s<sup>3</sup>       |             |
|   21   | mean(tBodyGyro-mean()-X)          | radians/s             |             |
|   22   | mean(tBodyGyro-mean()-Y)          | radians/s             |             |
|   23   | mean(tBodyGyro-mean()-Z)          | radians/s             |             |
|   24   | mean(tBodyGyro-std()-X)           | radians/s             |             |
|   25   | mean(tBodyGyro-std()-Y)           | radians/s             |             |
|   26   | mean(tBodyGyro-std()-Z)           | radians/s             |             |
|   27   | mean(tBodyGyroJerk-mean()-X)      | radians/s<sup>3</sup> |             |
|   28   | mean(tBodyGyroJerk-mean()-Y)      | radians/s<sup>3</sup> |             |
|   29   | mean(tBodyGyroJerk-mean()-Z)      | radians/s<sup>3</sup> |             |
|   30   | mean(tBodyGyroJerk-std()-X)       | radians/s<sup>3</sup> |             |
|   31   | mean(tBodyGyroJerk-std()-Y)       | radians/s<sup>3</sup> |             |
|   32   | mean(tBodyGyroJerk-std()-Z)       | radians/s<sup>3</sup> |             |
|   33   | mean(tBodyAccMag-mean())          | m/s<sup>2</sup>       |             |
|   34   | mean(tBodyAccMag-std())           | m/s<sup>2</sup>       |             |
|   35   | mean(tGravityAccMag-mean())       | m/s<sup>2</sup>       |             |
|   36   | mean(tGravityAccMag-std())        | m/s<sup>2</sup>       |             |
|   37   | mean(tBodyAccJerkMag-mean())      | m/s<sup>3</sup>       |             |
|   38   | mean(tBodyAccJerkMag-std())       | m/s<sup>3</sup>       |             |
|   39   | mean(tBodyGyroMag-mean())         | radians/s             |             |
|   40   | mean(tBodyGyroMag-std())          | radians/s             |             |
|   41   | mean(tBodyGyroJerkMag-mean())     | radians/s<sup>3</sup> |             |
|   42   | mean(tBodyGyroJerkMag-std())      | radians/s<sup>3</sup> |             |
|   43   | mean(fBodyAcc-mean()-X)           | m/s<sup>2</sup>       |             |
|   44   | mean(fBodyAcc-mean()-Y)           | m/s<sup>2</sup>       |             |
|   45   | mean(fBodyAcc-mean()-Z)           | m/s<sup>2</sup>       |             |
|   46   | mean(fBodyAcc-std()-X)            | m/s<sup>2</sup>       |             |
|   47   | mean(fBodyAcc-std()-Y)            | m/s<sup>2</sup>       |             |
|   48   | mean(fBodyAcc-std()-Z)            | m/s<sup>2</sup>       |             |
|   49   | mean(fBodyAccJerk-mean()-X)       | m/s<sup>3</sup>       |             |
|   50   | mean(fBodyAccJerk-mean()-Y)       | m/s<sup>3</sup>       |             |
|   51   | mean(fBodyAccJerk-mean()-Z)       | m/s<sup>3</sup>       |             |
|   52   | mean(fBodyAccJerk-std()-X)        | m/s<sup>3</sup>       |             |
|   53   | mean(fBodyAccJerk-std()-Y)        | m/s<sup>3</sup>       |             |
|   54   | mean(fBodyAccJerk-std()-Z)        | m/s<sup>3</sup>       |             |
|   55   | mean(fBodyGyro-mean()-X)          | radians/s             |             |
|   56   | mean(fBodyGyro-mean()-Y)          | radians/s             |             |
|   57   | mean(fBodyGyro-mean()-Z)          | radians/s             |             |
|   58   | mean(fBodyGyro-std()-X)           | radians/s             |             |
|   59   | mean(fBodyGyro-std()-Y)           | radians/s             |             |
|   60   | mean(fBodyGyro-std()-Z)           | radians/s             |             |
|   61   | mean(fBodyAccMag-mean())          | m/s<sup>2</sup>       |             |
|   62   | mean(fBodyAccMag-std())           | m/s<sup>2</sup>       |             |
|   63   | mean(fBodyBodyAccJerkMag-mean())  | m/s<sup>3</sup>       |             |
|   64   | mean(fBodyBodyAccJerkMag-std())   | m/s<sup>3</sup>       |             |
|   65   | mean(fBodyBodyGyroMag-mean())     | radians/s             |             |
|   66   | mean(fBodyBodyGyroMag-std())      | radians/s             |             |
|   67   | mean(fBodyBodyGyroJerkMag-mean()) | radians/s<sup>3</sup> |             |
|   68   | mean(fBodyBodyGyroJerkMag-std())  | radians/s<sup>3</sup> |             |

-------------------------------------------------------------------------------

