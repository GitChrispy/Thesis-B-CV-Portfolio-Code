% Create a Classification DL Model with Adversarial Smoke Dataset w/forest
% background (30000) and Fuego's non_smoke Dataset

%gpuDevice
%net = squeezenet;
%deepNetworkDesigner

%analyzeNetwork(lgraph_1);

%evaluate 1 test image

% I = imread(fullfile('C:\Users\jusfo\Desktop\Smoke Images\Adversarial Dataset\test_image\000006.jpg'));
% 
% I = imresize(I, [227 227]);
% 
% [YPred,probs] = classify(trainedNetwork_3,I);
% imshow(I)
% label = YPred;
% title(string(label) + ", " + num2str(100*max(probs),3) + "%");

%evaluate test image set

location1 = fullfile('C:\Users\jusfo\Desktop\Smoke Images\Classification_Dataset_Split\test_image'); %from Adversarial (easy)
location2 = fullfile('C:\Users\jusfo\Desktop\Smoke Images\Fuego Smoke_Images_Resized'); %from Fuego (hard)
imds = imageDatastore(location2);

inputSize = [227 227];
imds.ReadFcn = @(loc)imresize(imread(loc),inputSize); %dummy parameter 'loc' to assign new read function w/ resizing

[YPred,probs] = classify(trainedNetwork_3,imds);

accuracy = sum(YPred == 'Smoke')/size(imds.Files,1); 


%Create DL Model with [Fuego Smoke] + [Fuego Non-smoke]

%k select Fuego Non-smoke images