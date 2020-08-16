%takes two consec images and creates generate a sequence of 'LBP-XCS' preprocessed images from a database
% fuse with RGB image to create V4 hybrid dataset

%test image
% im = imread('hp-n-mobo-c__2019-07-16T13;28;25.jpg');
% figure(1);
% imshow(im);

function RGB = featureExtractV5(im)
    gI1 = rgb2gray(im);
%     figure(5);
%     imshow(gI1);    
    gI1 = imadjust(gI1);
%     figure(2);
%     imshow(gI1);
    
   %LBP Extracted image
    gI1 = double(gI1);
    FxRadius = 1;
    FyRadius = 1;
    %TInterval = 1;
    %TimeLength = 1;
    BorderLength = 1;
    NeighborPoints = [8 8 8]; % XY, XT, and YT planes, respectively
    %nDim = 2 ^ (NeighborPoints(1));  %dimensionality of basic XC-LBP
    XCS = XCSLBP(gI1,FxRadius, FyRadius, NeighborPoints, BorderLength);
    XCS = XCS*(255/16);
%     figure(3);
%     imshow(XCS);
    im(:,:,1) = im(:,:,1)+XCS;
    im(:,:,2) = im(:,:,2)+XCS;
    im(:,:,3) = im(:,:,3)+XCS;
    RGB = im;
%     figure(4);
%     imshow(RGB);
%end