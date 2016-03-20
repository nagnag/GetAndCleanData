Description of the DATA

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix ‘t’ to denote time) were captured at a constant rate of 50 Hz. and the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) – both using a low pass Butterworth filter.

The body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

A Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the ‘f’ to indicate frequency domain signals).

Description of abbreviations of measurements

leading t or f is based on time or frequency measurements.
Body = related to body movement.
Gravity = acceleration of gravity
Acc = accelerometer measurement
Gyro = gyroscopic measurements
Jerk = sudden movement acceleration
Mag = magnitude of movement
mean and SD are calculated for each subject for each activity for each mean and SD measurements.
The units given are g’s for the accelerometer and rad/sec for the gyro and g/sec and rad/sec/sec for the corresponding jerks.

These signals were used to estimate variables of the feature vector for each pattern:
‘-XYZ’ is used to denote 3-axial signals in the X, Y and Z directions. They total 33 measurements including the 3 dimensions - the X,Y, and Z axes.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag
The set of variables that were estimated from these signals are:

mean(): Mean value
std(): Standard deviation


================================================================================================================

   subject

----------------------------------------------------------------------------------------------------------------

   Storage mode: integer

          Min.:   1.000
       1st Qu.:   8.000
        Median:  15.500
          Mean:  15.500
       3rd Qu.:  23.000
          Max.:  30.000

================================================================================================================

   activity

----------------------------------------------------------------------------------------------------------------

   Storage mode: integer
   Factor with 6 levels

         Values and labels    N    Percent 
                                           
    1 'LAYING'               66   16.7  3.3
    2 'SITTING'              66   16.7  3.3
    3 'STANDING'             66   16.7  3.3
    4 'WALKING'              66   16.7  3.3
    5 'WALKING_DOWNSTAIRS'   66   16.7  3.3
    6 'WALKING_UPSTAIRS'     66   16.7  3.3
   NA                      1584        80.0

================================================================================================================

   featDomain

----------------------------------------------------------------------------------------------------------------

   Storage mode: integer
   Factor with 2 levels

   Values and labels    N    Percent 
                                     
            1 'Time' 1200   60.6     
            2 'Freq'  780   39.4     

================================================================================================================

   featAcceleration

----------------------------------------------------------------------------------------------------------------

   Storage mode: integer
   Factor with 3 levels

   Values and labels    N    Percent 
                                     
         1 'NA'       780   39.4     
         2 'Body'     960   48.5     
         3 'Gravity'  240   12.1     

================================================================================================================

   featInstrument

----------------------------------------------------------------------------------------------------------------

   Storage mode: integer
   Factor with 2 levels

   Values and labels    N    Percent 
                                     
   1 'Accelerometer' 1200   60.6     
   2 'Gyroscope'      780   39.4     

================================================================================================================

   featJerk

----------------------------------------------------------------------------------------------------------------

   Storage mode: integer
   Factor with 2 levels

   Values and labels    N    Percent 
                                     
            1 'NA'   1200   60.6     
            2 'Jerk'  780   39.4     

================================================================================================================

   featMagnitude

----------------------------------------------------------------------------------------------------------------

   Storage mode: integer
   Factor with 2 levels

   Values and labels    N    Percent 
                                     
       1 'NA'        1440   72.7     
       2 'Magnitude'  540   27.3     

================================================================================================================

   featVariable

----------------------------------------------------------------------------------------------------------------

   Storage mode: integer
   Factor with 2 levels

   Values and labels    N    Percent 
                                     
            1 'Mean'  990   50.0     
            2 'SD'    990   50.0     

================================================================================================================

   featAxis

----------------------------------------------------------------------------------------------------------------

   Storage mode: integer
   Factor with 4 levels

   Values and labels    N    Percent 
                                     
              1 'NA'  540   27.3     
              2 'X'   480   24.2     
              3 'Y'   480   24.2     
              4 'Z'   480   24.2     

================================================================================================================

   count

----------------------------------------------------------------------------------------------------------------

   Storage mode: integer

          Min.:  281.000
       1st Qu.:  317.000
        Median:  342.500
          Mean:  343.300
       3rd Qu.:  372.000
          Max.:  409.000

================================================================================================================

   average

----------------------------------------------------------------------------------------------------------------

   Storage mode: double

          Min.:  -0.980
       1st Qu.:  -0.717
        Median:  -0.623
          Mean:  -0.509
       3rd Qu.:  -0.462
          Max.:   0.745

