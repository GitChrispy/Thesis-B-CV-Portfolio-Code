%Create an image folder sample of an existing dataset

nNonSmokeImages = 1661;

loc = fullfile('C:\Users\jusfo\Desktop\Smoke Images\HPWREN Dataset','*.jpg'); %non smoke
files = dir(loc);

folderSize = size(files,1);

% Partition Images from Folder
cv = cvpartition(folderSize,'HoldOut',nNonSmokeImages); 
idx = cv.test; 
dataSourceSelected = files(idx,1);
% create cell of filenames
nSelected = size(dataSourceSelected,1);

for i=1:nSelected
    filenames(i,1) = {strcat(dataSourceSelected(i).folder,'\',dataSourceSelected(i).name)};
end

initialLoc = fullfile('C:\Users\jusfo\Desktop\Smoke Images\HPWREN Dataset');
targetLoc = fullfile('C:\Users\jusfo\Desktop\Smoke Images\HPWREN Non-smoke');
cd(initialLoc);

for i = 1 : nSelected
    tempFile = cell2mat(filenames(i,1));
    copyfile(tempFile, targetLoc, 'f')
end

