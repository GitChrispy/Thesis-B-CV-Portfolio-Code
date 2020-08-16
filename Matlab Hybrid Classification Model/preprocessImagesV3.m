% texture extractor CS-LBP function
% a more conservative approach preserving original grayimage, 'blended'
% w/texture data

%Generate preprocessed smoke images
createSmokeData = true;
if createSmokeData
    loc = fullfile('C:\Users\jusfo\Desktop\Smoke Images\Fuego Smoke_Images_Resized','*.jpg'); %smoke images
    files = dir(loc);
    folderSize = size(files,1);

    initialLoc = fullfile('C:\Users\jusfo\Desktop\Smoke Images\Fuego Smoke_Images_Resized');
    targetLoc = fullfile('C:\Users\jusfo\Desktop\Smoke Images\Preprocessed Images V3\Smoke');
    addpath(initialLoc);

    for i = 1 : folderSize
        I = imread(files(i).name);
        I = imresize(I,[416,416]);
        C = featureExtractV3(I);
        imwrite(C,strcat( targetLoc, '\' , files(i).name ));
    end

    loc = fullfile('C:\Users\jusfo\Desktop\Smoke Images\HPWREN Non-smoke','*.jpg'); %non_smoke images
    files = dir(loc);
    folderSize = size(files,1);

    initialLoc = fullfile('C:\Users\jusfo\Desktop\Smoke Images\HPWREN Non-smoke');
    targetLoc = fullfile('C:\Users\jusfo\Desktop\Smoke Images\Preprocessed Images V3\Non_Smoke');
    addpath(initialLoc);

    for i = 1 : folderSize
        I = imread(files(i).name);
        I = imresize(I,[416,416]);
        C = featureExtractV3(I);
        imwrite(C,strcat( targetLoc, '\' , files(i).name ));
    end

end
