%given a preselected image sequence, compute XCSLBP w/ Gaussian Mixture Model
 
%Based on GaussianMixtureModel.m

%result- no noticable result again, seems slightly worse than adaptive
%background

addpath('../')
clear; clc;

%loc = fullfile('C:\Users\jusfo\Desktop\Thesis B\Matlab XCSLBP Test\Sample'); %smoke images
loc = fullfile('C:\Users\jusfo\Desktop\Thesis B\Matlab XCSLBP Test\Sample2'); %smoke images
addpath(loc);
files = dir(loc); % for some reason there are '.' and '..' files
folderSize = size(files,1); 

nFrames = folderSize -2;

detector = vision.ForegroundDetector(...
    'NumTrainingFrames', nFrames, ... % 5 because of short video
    'InitialVariance', 30*30); % initial standard deviation of 30

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
    
    XCS = XCSLBP(I, FxRadius, FyRadius, NeighborPoints, BorderLength); 
    XCS = XCS*(255/16);
    frame = medfilt2(XCS);
    
    mask = step(detector, frame);
    
    h1 = figure(1);
    subplot(1,2,1), imshow(I,[],'InitialMagnification','fit'), title('Input');
    subplot(1,2,2), imshow(mask,[],'InitialMagnification','fit'), title('Foreground');
    pause(0.1);
end
disp('Finished');