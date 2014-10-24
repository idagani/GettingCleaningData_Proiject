labels <- read.table("activity_labels.txt",header=FALSE)
colnames(labels) = c("id","name")

features <- read.table("features.txt",header=FALSE)
colnames(features) = c("id","name")

# 7352 rows X 561 cols
x_train <- read.table("X_train.txt",header=FALSE)
y_train <- read.table("y_train.txt",header=FALSE)
colnames(x_train) <- features$name

# 2947 rows X 561 cols
x_test <- read.table("X_test.txt",header=FALSE)
y_test <- read.table("y_test.txt",header=FALSE)
colnames(x_test) <- features$name

#merge data into one data set - 10299 rows X 561 cols
x_data <- rbind(x_train, x_test) 
colnames(x_data) <- features$name
y_data <- rbind(y_train, y_test)

# create a new data set for only mean and standard deviation related features

mean_features <- features[grepl('mean', features$name),]
std_features <- features[grepl('std', features$name),]
select_features <- rbind(mean_features, std_features)
select_features <- select_features[order(select_features$id),]

# convert column names from factors to strings
col_names <- select_features$name
col_names <- as.character(select_features$name)

# extract the selected columns - 10299 rows X 79 cols + 1 label column
x_select <- x_data[,col_names]
x_select$label <- y_data

# create a different data set for each of the 6 activities
# for each activity - calculate the mean for each column

walking_data <- subset(x_select, x_select$label == labels[1,]$id)
walking_up_data <- subset(x_select, x_select$label == labels[2,]$id)
walking_dn_data <- subset(x_select, x_select$label == labels[3,]$id)
sitting_data <- subset(x_select, x_select$label == labels[4,]$id)
standing_data <- subset(x_select, x_select$label == labels[5,]$id)
laying_data <- subset(x_select, x_select$label == labels[6,]$id)

walking_mean <- colMeans(walking_data[,1:ncol(walking_data)-1])
walking_up_mean <- colMeans(walking_up_data[,1:ncol(walking_up_data)-1])
walking_dn_mean <- colMeans(walking_dn_data[,1:ncol(walking_dn_data)-1])
sitting_mean <- colMeans(sitting_data[,1:ncol(sitting_data)-1])
standing_mean <- colMeans(standing_data[,1:ncol(standing_data)-1])
laying_mean <- colMeans(laying_data[,1:ncol(laying_data)-1])

# merge to one data set
df <- data.frame(walking_mean, walking_up_mean, walking_dn_mean, sitting_mean, standing_mean, laying_mean)

# save to CSV file
write.table(df, "df.txt", sep=",", row.name=FALSE)
