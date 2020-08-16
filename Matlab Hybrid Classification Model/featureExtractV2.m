%takes two consec images and creates generate a sequence of 'SmokeColourMotion' preprocessed images from a database

function RGB = featureExtractV2(im1, im2)
    gI1 = rgb2gray(im1);
    gI2 = rgb2gray(im2);
    gI1 = imadjust(gI1);
    gI2 = imadjust(gI2);
    
   %LBP Extracted image
    gI1 = double(gI1);
    gI2 = double(gI2);
    FxRadius = 1;
    FyRadius = 1;
    %TInterval = 1;
    %TimeLength = 1;
    BorderLength = 1;
    NeighborPoints = [8 8 8]; % XY, XT, and YT planes, respectively
    %nDim = 2 ^ (NeighborPoints(1));  %dimensionality of basic XC-LBP
    XCS1 = XCSLBP(gI1,FxRadius, FyRadius, NeighborPoints, BorderLength);
    XCS1 = XCS1*(255/16);
    XCS2 = XCSLBP(gI2,FxRadius, FyRadius, NeighborPoints, BorderLength);
    XCS2 = XCS2*(255/16);

    %MOTION Extracted image
    opticFlow = opticalFlowLK;
    estimateFlow(opticFlow,XCS1);
    flow = estimateFlow(opticFlow,XCS2);
    ang = flow.Orientation;
    mag = double(flow.Magnitude);
    I = hsv2rgb(ang,  mag,  mag);
    I = rgb2hsv(I);
    
    RGB = imfuse(I,XCS2,'blend','Scaling','joint'); 
    RGB = imfuse(RGB,gI2,'blend','Scaling','joint');
    
end