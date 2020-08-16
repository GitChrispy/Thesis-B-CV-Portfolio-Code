% Create a datastore of non smoke data to test false positive/detection rate
%of models

% Randomly selects* 166 images from HPWREN non smoke folder. Label ground truth (empty) 
% Create datastore. 

% use 'FalseDetectionData.mat'

function filenames = createNonSmokeData(nNonSmokeImages)

    loc = fullfile('C:\Users\jusfo\Desktop\Smoke Images\HPWREN Non-smoke','*.jpg'); %non smoke
    files = dir(loc);
    
    folderSize = size(files,1);
    cv = cvpartition(folderSize,'HoldOut',nNonSmokeImages); 
    idx = cv.test; 
    dataSourceSelected = files(idx,1);

    nSelected = size(dataSourceSelected,1);
    for i=1:nSelected
        filenames(i,1) = {strcat(dataSourceSelected(i).folder,'\',dataSourceSelected(i).name)};
    end

end