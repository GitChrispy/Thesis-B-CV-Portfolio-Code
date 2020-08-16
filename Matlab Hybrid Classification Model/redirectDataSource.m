% given a DL Classification imds split i.e. load('imds_split_Model3.mat');
% redirect to the target preprocessed image folder

load('imds_split_Model3.mat');

oldLoc1 = 'C:\Users\jusfo\Desktop\Smoke Images\Fuego Smoke_Images_Resized';
len1 = size(oldLoc1,2);
newLoc1 = 'C:\Users\jusfo\Desktop\Smoke Images\Preprocessed Images V5\Smoke'; % redirect to preprocessing V5

oldLoc2 = 'C:\Users\jusfo\Desktop\Smoke Images\HPWREN Non-smoke';
len2 = size(oldLoc2,2);
newLoc2 = 'C:\Users\jusfo\Desktop\Smoke Images\Preprocessed Images V5\Non_Smoke'; % redirect to preprocessing V5
%training data
%dataSourceSelected = gTruthTraining.DataSource.Source;
dataSourceSelected = imds_training.Files; 
trainingLabel = imds_training.Labels;

nSelected = size(dataSourceSelected,1);
for i=1:nSelected
    if i < 1164 %hard coded from imds.Files datasource
        extractedName = cell2mat(dataSourceSelected(i));
        extractedName = extractedName(len2+1:end);
        filenames(i,1) = {strcat(newLoc2,extractedName)};
    else
        extractedName = cell2mat(dataSourceSelected(i));
        extractedName = extractedName(len1+1:end);
        filenames(i,1) = {strcat(newLoc1,extractedName)};
    end
end

training_ds = imageDatastore(filenames);
training_ds.Labels = trainingLabel;

clear filenames;
%validating data
dataSourceSelected = imds_val.Files; 
valLabel = imds_val.Labels;

nSelected = size(dataSourceSelected,1);
for i=1:nSelected
    if i < 167 %hard coded from imds.Files datasource
        extractedName = cell2mat(dataSourceSelected(i));
        extractedName = extractedName(len2+1:end);
        filenames(i,1) = {strcat(newLoc2,extractedName)};
    else
        extractedName = cell2mat(dataSourceSelected(i));
        extractedName = extractedName(len1+1:end);
        filenames(i,1) = {strcat(newLoc1,extractedName)};
    end
end

val_ds = imageDatastore(filenames);
val_ds.Labels = valLabel;

clear filenames;
%testing data
dataSourceSelected = imds_testing.Files; 
testLabel = imds_testing.Labels;

nSelected = size(dataSourceSelected,1);
for i=1:nSelected
    if i < 333 %hard coded from imds.Files datasource
        extractedName = cell2mat(dataSourceSelected(i));
        extractedName = extractedName(len2+1:end);
        filenames(i,1) = {strcat(newLoc2,extractedName)};
    else
        extractedName = cell2mat(dataSourceSelected(i));
        extractedName = extractedName(len1+1:end);
        filenames(i,1) = {strcat(newLoc1,extractedName)};
    end
end

test_ds = imageDatastore(filenames);
test_ds.Labels = testLabel;