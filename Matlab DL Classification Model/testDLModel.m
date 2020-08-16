%Test Model: given test datastore, evaluate trainedDLModel 

%Internal Test: within data split

testInternal = true;
if testInternal
    inputSize = [227 227]; % Resize the images to match the network input layer.
    %inputSize = [224 224];
    imds_testing.ReadFcn = @(loc)imresize(imread(loc),inputSize);

    YTest = imds_testing.Labels;

    [YPred,probs] = classify(trainedNet,imds_testing);

    accuracy = mean(YPred == YTest)
end

%External Test: outside data split

testExternal = false;
if testExternal
    location1 = fullfile('C:\Users\jusfo\Desktop\Smoke Images\Classification_Dataset_Split\test_image'); %from Adversarial (easy)
    location2 = fullfile('C:\Users\jusfo\Desktop\Smoke Images\Fuego Smoke_Images_Resized'); %from Fuego (hard)
    
    location3 = fullfile('C:\Users\jusfo\Desktop\Smoke Images\Fuego Dataset\Fuego Cropped_Non_Smoke_Images'); %all 44K Fuego non-smoke
    location4 = fullfile('C:\Users\jusfo\Desktop\Smoke Images\Batch 1');
    
    imds = imageDatastore(location4);

    inputSize = [227 227];
    imds.ReadFcn = @(loc)imresize(imread(loc),inputSize); %dummy parameter 'loc' to assign new read function w/ resizing

    [YPred,probs] = classify(trainedNet,imds);

    %accuracy = sum(YPred == 'smoke')/size(imds.Files,1) 
    accuracy = sum(YPred == 'no smoke')/size(imds.Files,1) 
end 

% verify wrong images
%id = find(YPred == 'smoke')
%imshow(cell2mat(imds.Files(id)))

