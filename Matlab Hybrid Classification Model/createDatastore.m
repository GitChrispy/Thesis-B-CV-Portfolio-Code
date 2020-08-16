%Create custom datastore from various image folder sources + Split data 
function [imds_training, imds_val, imds_testing] = createDatastore()

nSmokeImages = 10000;
%nNonSmokeImages = 10000;
nNonSmokeImages = 1661;

%nFolderImages = 1661;

%loc = fullfile('C:\Users\jusfo\Desktop\Smoke Images\Preprocessed Images V2\Non_Smoke','*.jpg'); %non smoke
loc = fullfile('C:\Users\jusfo\Desktop\Smoke Images\Preprocessed Images V3\Non_Smoke','*.jpg'); %non smoke
files = dir(loc);

folderSize = size(files,1);

% Partition Images from Folder
partitionNeeded = true;
if partitionNeeded

    cv = cvpartition(folderSize,'HoldOut',nNonSmokeImages); 
    idx = cv.test; 
    dataSourceSelected = files(idx,1);

end

% Create cell of filenames
dataSourceSelected = files;
nSelected = size(dataSourceSelected,1);
for i=1:nSelected
    filenames(i,1) = {strcat(dataSourceSelected(i).folder,'\',dataSourceSelected(i).name)};
end

imds1 = imageDatastore(filenames);
imds1.Labels = categorical(repmat({'no smoke'},size(dataSourceSelected,1),1));

loc = fullfile('C:\Users\jusfo\Desktop\Smoke Images\Preprocessed Images V3\Smoke','*.jpg'); %smoke
files = dir(loc);
dataSourceSelected = files;

nSelected = size(dataSourceSelected,1);
for i=1:size(dataSourceSelected,1)
    filenames(i,1) = {strcat(dataSourceSelected(i).folder,'\',dataSourceSelected(i).name)};
end
imds2 = imageDatastore(filenames);
imds2.Labels = categorical(repmat({'smoke'},nSelected,1));

%Combine Datastores
imds = imageDatastore(cat(1,imds1.Files,imds2.Files));
imds.Labels = cat(1,imds1.Labels,imds2.Labels);


%Split Data: 70-20-10 split
[imds_training, imds_val, imds_testing] = splitEachLabel(imds,0.7,0.1,'randomized');
end
