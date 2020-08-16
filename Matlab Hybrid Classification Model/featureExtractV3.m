%takes two consec images and creates generate a sequence of 'LBP-XCS' preprocessed images from a database

%test image
%im = imread('69bravo-e-mobo-c__2019-08-13T14;45;44.jpg');

function RGB = featureExtractV3(im)
    gI1 = rgb2gray(im);
    gI1 = imadjust(gI1);
    
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

    RGB = imfuse(gI1,XCS,'blend','Scaling','independent'); 
    RGB = cat(3,RGB,RGB,RGB);
end