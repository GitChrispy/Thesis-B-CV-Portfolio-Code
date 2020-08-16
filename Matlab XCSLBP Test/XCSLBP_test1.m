%given a preselected image sequence, compute XCSLBP and similarity images

%Based on AdaptiveBackgroundLearning.m 

%result- base of the smoke is slightly noticable, texture image and
%similarity image (between background and LBP)

%does not seem like its better than just using LBP texture

addpath('../')
clear; clc;

%loc = fullfile('C:\Users\jusfo\Desktop\Thesis B\Matlab XCSLBP Test\Sample'); %smoke images
loc = fullfile('C:\Users\jusfo\Desktop\Thesis B\Matlab XCSLBP Test\Sample2'); %smoke images
addpath(loc);
files = dir(loc); % for some reason there are '.' and '..' files
folderSize = size(files,1); 

alpha = 0.05;
for k = 3:1:folderSize
    disp(['Processing frame: ' num2str(k-2)]);    
    I = imread(files(k).name);
    I = rgb2gray(I);
    I = imadjust(I);
    I = double(I);


    %XCS-LBP parameters
    FxRadius = 1;
    FyRadius = 1;
    TInterval = 2;
    TimeLength = 2;
    BorderLength = 1;
    NeighborPoints = [8 8 8]; % XY, XT, and YT planes, respectively
    nDim = 2 ^ (NeighborPoints(1));  %dimensionality of basic XC-LBP
    
    %adaptive background
    if k == 3
        B = I;
    else
        B = alpha * I + (1-alpha) * B;
    end
    
    Blbp = XCSLBP(B, FxRadius, FyRadius, NeighborPoints, BorderLength);
    Blbp = Blbp*(255/16);
    
    FLDP = XCSLBP(I, FxRadius, FyRadius, NeighborPoints, BorderLength); 
    FLDP = FLDP*(255/16);
    
    K = compute_similarity(FLDP,Blbp); 
    F = (K < 0.5);
    F = medfilt2(F);
    
    h1 = figure(1);
    subplot(1,4,1), imshow(I,[],'InitialMagnification','fit'), title('Input');
    subplot(1,4,2), imshow(Blbp,[],'InitialMagnification','fit'), title('XCSLBP Background');
    %subplot(1,4,2), imshow(B,[],'InitialMagnification','fit'), title('B Background');
    subplot(1,4,3), imshow(FLDP,[],'InitialMagnification','fit'), title('XCSLBP Input');
    subplot(1,4,4), imshow(F,[],'InitialMagnification','fit'), title('Similarity');
    pause(0.1);
end
disp('Finished');