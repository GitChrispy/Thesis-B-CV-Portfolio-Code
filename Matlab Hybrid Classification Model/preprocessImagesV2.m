% texture-motion extractor function: takes two consec images and creates
% generate a sequence of 'SmokeColourMotion' preprocessed images from a
% database (to preserve 1661 smoke images, last image of sequence compared
% to first image and computed

% a more conservative approach preserving original grayimage, 'blended'
% w/motion and texture data

%Generate preprocessed smoke images
createSmokeData = true;
if createSmokeData
loc = fullfile('C:\Users\jusfo\Desktop\Smoke Images\Fuego Smoke_Images_Resized','*.jpg'); %smoke images
files = dir(loc);

folderSize = size(files,1);

initialLoc = fullfile('C:\Users\jusfo\Desktop\Smoke Images\Fuego Smoke_Images_Resized');
targetLoc = fullfile('C:\Users\jusfo\Desktop\Smoke Images\Preprocessed Images V2\Smoke');
addpath(initialLoc);

for i = 1 : folderSize
    if i == folderSize
        C = featureExtractV2(firstIm, I1);
        imwrite(C,strcat( targetLoc, '\' , firstName ));   
        break;
    end
        
    I1 = imread(files(i).name);
    if i == 1
        firstIm = I1;
        firstName = files(i).name;       
    end
    str1 = files(i).name;
    str1 = str1(1:end-12);
    
    I2 = imread(files(i+1).name);
    str2 = files(i+1).name;
    str2 = str2(1:end-12);
    
    if strcmp(str1,str2)
        C = featureExtractV2(I1, I2);
        imwrite(C,strcat( targetLoc, '\' , files(i+1).name ));
    elseif i ~= folderSize
        C = featureExtractV2(firstIm, I1);
        imwrite(C,strcat( targetLoc, '\' , firstName ));
        
        firstIm = I2;
        firstName = files(i+1).name;   
    end
    
end

end
%Generate preprocessed non_smoke images
createNonSmokeData = true;
if createNonSmokeData
loc = fullfile('C:\Users\jusfo\Desktop\Smoke Images\HPWREN Non-smoke','*.jpg'); %non_smoke images
files = dir(loc);

folderSize = size(files,1);

initialLoc = fullfile('C:\Users\jusfo\Desktop\Smoke Images\HPWREN Non-smoke');
targetLoc = fullfile('C:\Users\jusfo\Desktop\Smoke Images\Preprocessed Images V2\Non_Smoke');
addpath(initialLoc);

for i = 1 : folderSize
    I1 = imread(files(i).name);
    I1 = imresize(I1,[416,416]);
    C = featureExtractV2(I1, I1);
    imwrite(C,strcat( targetLoc, '\' , files(i).name ));
end

end
