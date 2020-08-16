% given train, val datastores => train CNN model

%data from createdatastore()
load('imds_split_Model3.mat');

%manual CNN select/config
%net = squeezenet; %choose network
net = shufflenet; 
%deepNetworkDesigner
%analyzeNetwork(lgraph);

% Resize the images to match the network input layer.
%inputSize = [227 227]; 
inputSize = [224 224];
imds_training.ReadFcn = @(loc)imresize(imread(loc),inputSize);
imds_val.ReadFcn = @(loc)imresize(imread(loc),inputSize);

%trainingSetup = load('C:\Users\jusfo\Desktop\Thesis B\Matlab DL Classification Model\trainingSetup_2020_07_01__12_00_59.mat');

% ------------insert generated CNN model code---------------
% lgraph = layerGraph();
% tempLayers = [
%     imageInputLayer([227 227 3],"Name","data","Mean",trainingSetup.data.Mean)
%     convolution2dLayer([3 3],64,"Name","conv1","Stride",[2 2],"Bias",trainingSetup.conv1.Bias,"Weights",trainingSetup.conv1.Weights)
%     reluLayer("Name","relu_conv1")
%     maxPooling2dLayer([3 3],"Name","pool1","Stride",[2 2])
%     convolution2dLayer([1 1],16,"Name","fire2-squeeze1x1","Bias",trainingSetup.fire2_squeeze1x1.Bias,"Weights",trainingSetup.fire2_squeeze1x1.Weights)
%     reluLayer("Name","fire2-relu_squeeze1x1")];
% lgraph = addLayers(lgraph,tempLayers);
% 
% tempLayers = [
%     convolution2dLayer([1 1],64,"Name","fire2-expand1x1","Bias",trainingSetup.fire2_expand1x1.Bias,"Weights",trainingSetup.fire2_expand1x1.Weights)
%     reluLayer("Name","fire2-relu_expand1x1")];
% lgraph = addLayers(lgraph,tempLayers);
% 
% tempLayers = [
%     convolution2dLayer([3 3],64,"Name","fire2-expand3x3","Padding",[1 1 1 1],"Bias",trainingSetup.fire2_expand3x3.Bias,"Weights",trainingSetup.fire2_expand3x3.Weights)
%     reluLayer("Name","fire2-relu_expand3x3")];
% lgraph = addLayers(lgraph,tempLayers);
% 
% tempLayers = [
%     depthConcatenationLayer(2,"Name","fire2-concat")
%     convolution2dLayer([1 1],16,"Name","fire3-squeeze1x1","Bias",trainingSetup.fire3_squeeze1x1.Bias,"Weights",trainingSetup.fire3_squeeze1x1.Weights)
%     reluLayer("Name","fire3-relu_squeeze1x1")];
% lgraph = addLayers(lgraph,tempLayers);
% 
% tempLayers = [
%     convolution2dLayer([1 1],64,"Name","fire3-expand1x1","Bias",trainingSetup.fire3_expand1x1.Bias,"Weights",trainingSetup.fire3_expand1x1.Weights)
%     reluLayer("Name","fire3-relu_expand1x1")];
% lgraph = addLayers(lgraph,tempLayers);
% 
% tempLayers = [
%     convolution2dLayer([3 3],64,"Name","fire3-expand3x3","Padding",[1 1 1 1],"Bias",trainingSetup.fire3_expand3x3.Bias,"Weights",trainingSetup.fire3_expand3x3.Weights)
%     reluLayer("Name","fire3-relu_expand3x3")];
% lgraph = addLayers(lgraph,tempLayers);
% 
% tempLayers = [
%     depthConcatenationLayer(2,"Name","fire3-concat")
%     maxPooling2dLayer([3 3],"Name","pool3","Padding",[0 1 0 1],"Stride",[2 2])
%     convolution2dLayer([1 1],32,"Name","fire4-squeeze1x1","Bias",trainingSetup.fire4_squeeze1x1.Bias,"Weights",trainingSetup.fire4_squeeze1x1.Weights)
%     reluLayer("Name","fire4-relu_squeeze1x1")];
% lgraph = addLayers(lgraph,tempLayers);
% 
% tempLayers = [
%     convolution2dLayer([1 1],128,"Name","fire4-expand1x1","Bias",trainingSetup.fire4_expand1x1.Bias,"Weights",trainingSetup.fire4_expand1x1.Weights)
%     reluLayer("Name","fire4-relu_expand1x1")];
% lgraph = addLayers(lgraph,tempLayers);
% 
% tempLayers = [
%     convolution2dLayer([3 3],128,"Name","fire4-expand3x3","Padding",[1 1 1 1],"Bias",trainingSetup.fire4_expand3x3.Bias,"Weights",trainingSetup.fire4_expand3x3.Weights)
%     reluLayer("Name","fire4-relu_expand3x3")];
% lgraph = addLayers(lgraph,tempLayers);
% 
% tempLayers = [
%     depthConcatenationLayer(2,"Name","fire4-concat")
%     convolution2dLayer([1 1],32,"Name","fire5-squeeze1x1","Bias",trainingSetup.fire5_squeeze1x1.Bias,"Weights",trainingSetup.fire5_squeeze1x1.Weights)
%     reluLayer("Name","fire5-relu_squeeze1x1")];
% lgraph = addLayers(lgraph,tempLayers);
% 
% tempLayers = [
%     convolution2dLayer([1 1],128,"Name","fire5-expand1x1","Bias",trainingSetup.fire5_expand1x1.Bias,"Weights",trainingSetup.fire5_expand1x1.Weights)
%     reluLayer("Name","fire5-relu_expand1x1")];
% lgraph = addLayers(lgraph,tempLayers);
% 
% tempLayers = [
%     convolution2dLayer([3 3],128,"Name","fire5-expand3x3","Padding",[1 1 1 1],"Bias",trainingSetup.fire5_expand3x3.Bias,"Weights",trainingSetup.fire5_expand3x3.Weights)
%     reluLayer("Name","fire5-relu_expand3x3")];
% lgraph = addLayers(lgraph,tempLayers);
% 
% tempLayers = [
%     depthConcatenationLayer(2,"Name","fire5-concat")
%     maxPooling2dLayer([3 3],"Name","pool5","Padding",[0 1 0 1],"Stride",[2 2])
%     convolution2dLayer([1 1],48,"Name","fire6-squeeze1x1","Bias",trainingSetup.fire6_squeeze1x1.Bias,"Weights",trainingSetup.fire6_squeeze1x1.Weights)
%     reluLayer("Name","fire6-relu_squeeze1x1")];
% lgraph = addLayers(lgraph,tempLayers);
% 
% tempLayers = [
%     convolution2dLayer([1 1],192,"Name","fire6-expand1x1","Bias",trainingSetup.fire6_expand1x1.Bias,"Weights",trainingSetup.fire6_expand1x1.Weights)
%     reluLayer("Name","fire6-relu_expand1x1")];
% lgraph = addLayers(lgraph,tempLayers);
% 
% tempLayers = [
%     convolution2dLayer([3 3],192,"Name","fire6-expand3x3","Padding",[1 1 1 1],"Bias",trainingSetup.fire6_expand3x3.Bias,"Weights",trainingSetup.fire6_expand3x3.Weights)
%     reluLayer("Name","fire6-relu_expand3x3")];
% lgraph = addLayers(lgraph,tempLayers);
% 
% tempLayers = [
%     depthConcatenationLayer(2,"Name","fire6-concat")
%     convolution2dLayer([1 1],48,"Name","fire7-squeeze1x1","Bias",trainingSetup.fire7_squeeze1x1.Bias,"Weights",trainingSetup.fire7_squeeze1x1.Weights)
%     reluLayer("Name","fire7-relu_squeeze1x1")];
% lgraph = addLayers(lgraph,tempLayers);
% 
% tempLayers = [
%     convolution2dLayer([1 1],192,"Name","fire7-expand1x1","Bias",trainingSetup.fire7_expand1x1.Bias,"Weights",trainingSetup.fire7_expand1x1.Weights)
%     reluLayer("Name","fire7-relu_expand1x1")];
% lgraph = addLayers(lgraph,tempLayers);
% 
% tempLayers = [
%     convolution2dLayer([3 3],192,"Name","fire7-expand3x3","Padding",[1 1 1 1],"Bias",trainingSetup.fire7_expand3x3.Bias,"Weights",trainingSetup.fire7_expand3x3.Weights)
%     reluLayer("Name","fire7-relu_expand3x3")];
% lgraph = addLayers(lgraph,tempLayers);
% 
% tempLayers = [
%     depthConcatenationLayer(2,"Name","fire7-concat")
%     convolution2dLayer([1 1],64,"Name","fire8-squeeze1x1","Bias",trainingSetup.fire8_squeeze1x1.Bias,"Weights",trainingSetup.fire8_squeeze1x1.Weights)
%     reluLayer("Name","fire8-relu_squeeze1x1")];
% lgraph = addLayers(lgraph,tempLayers);
% 
% tempLayers = [
%     convolution2dLayer([3 3],256,"Name","fire8-expand3x3","Padding",[1 1 1 1],"Bias",trainingSetup.fire8_expand3x3.Bias,"Weights",trainingSetup.fire8_expand3x3.Weights)
%     reluLayer("Name","fire8-relu_expand3x3")];
% lgraph = addLayers(lgraph,tempLayers);
% 
% tempLayers = [
%     convolution2dLayer([1 1],256,"Name","fire8-expand1x1","Bias",trainingSetup.fire8_expand1x1.Bias,"Weights",trainingSetup.fire8_expand1x1.Weights)
%     reluLayer("Name","fire8-relu_expand1x1")];
% lgraph = addLayers(lgraph,tempLayers);
% 
% tempLayers = [
%     depthConcatenationLayer(2,"Name","fire8-concat")
%     convolution2dLayer([1 1],64,"Name","fire9-squeeze1x1","Bias",trainingSetup.fire9_squeeze1x1.Bias,"Weights",trainingSetup.fire9_squeeze1x1.Weights)
%     reluLayer("Name","fire9-relu_squeeze1x1")];
% lgraph = addLayers(lgraph,tempLayers);
% 
% tempLayers = [
%     convolution2dLayer([3 3],256,"Name","fire9-expand3x3","Padding",[1 1 1 1],"Bias",trainingSetup.fire9_expand3x3.Bias,"Weights",trainingSetup.fire9_expand3x3.Weights)
%     reluLayer("Name","fire9-relu_expand3x3")];
% lgraph = addLayers(lgraph,tempLayers);
% 
% tempLayers = [
%     convolution2dLayer([1 1],256,"Name","fire9-expand1x1","Bias",trainingSetup.fire9_expand1x1.Bias,"Weights",trainingSetup.fire9_expand1x1.Weights)
%     reluLayer("Name","fire9-relu_expand1x1")];
% lgraph = addLayers(lgraph,tempLayers);
% 
% tempLayers = [
%     depthConcatenationLayer(2,"Name","fire9-concat")
%     dropoutLayer(0.5,"Name","drop9")
%     convolution2dLayer([1 1],2,"Name","conv","BiasLearnRateFactor",10,"Padding","same","WeightLearnRateFactor",10)
%     reluLayer("Name","relu_conv10")
%     globalAveragePooling2dLayer("Name","pool10")
%     softmaxLayer("Name","prob")
%     classificationLayer("Name","classoutput")];
% lgraph = addLayers(lgraph,tempLayers);
% 
% % clean up helper variable
% clear tempLayers;
% 
% lgraph = connectLayers(lgraph,"fire2-relu_squeeze1x1","fire2-expand1x1");
% lgraph = connectLayers(lgraph,"fire2-relu_squeeze1x1","fire2-expand3x3");
% lgraph = connectLayers(lgraph,"fire2-relu_expand3x3","fire2-concat/in2");
% lgraph = connectLayers(lgraph,"fire2-relu_expand1x1","fire2-concat/in1");
% lgraph = connectLayers(lgraph,"fire3-relu_squeeze1x1","fire3-expand1x1");
% lgraph = connectLayers(lgraph,"fire3-relu_squeeze1x1","fire3-expand3x3");
% lgraph = connectLayers(lgraph,"fire3-relu_expand1x1","fire3-concat/in1");
% lgraph = connectLayers(lgraph,"fire3-relu_expand3x3","fire3-concat/in2");
% lgraph = connectLayers(lgraph,"fire4-relu_squeeze1x1","fire4-expand1x1");
% lgraph = connectLayers(lgraph,"fire4-relu_squeeze1x1","fire4-expand3x3");
% lgraph = connectLayers(lgraph,"fire4-relu_expand3x3","fire4-concat/in2");
% lgraph = connectLayers(lgraph,"fire4-relu_expand1x1","fire4-concat/in1");
% lgraph = connectLayers(lgraph,"fire5-relu_squeeze1x1","fire5-expand1x1");
% lgraph = connectLayers(lgraph,"fire5-relu_squeeze1x1","fire5-expand3x3");
% lgraph = connectLayers(lgraph,"fire5-relu_expand1x1","fire5-concat/in1");
% lgraph = connectLayers(lgraph,"fire5-relu_expand3x3","fire5-concat/in2");
% lgraph = connectLayers(lgraph,"fire6-relu_squeeze1x1","fire6-expand1x1");
% lgraph = connectLayers(lgraph,"fire6-relu_squeeze1x1","fire6-expand3x3");
% lgraph = connectLayers(lgraph,"fire6-relu_expand1x1","fire6-concat/in1");
% lgraph = connectLayers(lgraph,"fire6-relu_expand3x3","fire6-concat/in2");
% lgraph = connectLayers(lgraph,"fire7-relu_squeeze1x1","fire7-expand1x1");
% lgraph = connectLayers(lgraph,"fire7-relu_squeeze1x1","fire7-expand3x3");
% lgraph = connectLayers(lgraph,"fire7-relu_expand1x1","fire7-concat/in1");
% lgraph = connectLayers(lgraph,"fire7-relu_expand3x3","fire7-concat/in2");
% lgraph = connectLayers(lgraph,"fire8-relu_squeeze1x1","fire8-expand3x3");
% lgraph = connectLayers(lgraph,"fire8-relu_squeeze1x1","fire8-expand1x1");
% lgraph = connectLayers(lgraph,"fire8-relu_expand3x3","fire8-concat/in2");
% lgraph = connectLayers(lgraph,"fire8-relu_expand1x1","fire8-concat/in1");
% lgraph = connectLayers(lgraph,"fire9-relu_squeeze1x1","fire9-expand3x3");
% lgraph = connectLayers(lgraph,"fire9-relu_squeeze1x1","fire9-expand1x1");
% lgraph = connectLayers(lgraph,"fire9-relu_expand1x1","fire9-concat/in1");
% lgraph = connectLayers(lgraph,"fire9-relu_expand3x3","fire9-concat/in2");
% ------------insert generated CNN model code---------------

%train model
rng(0);

% ------------insert training options----------------
opts = trainingOptions("sgdm",...
    "ExecutionEnvironment","auto",...
    "InitialLearnRate",0.001,...
    "LearnRateDropFactor",0.5,...
    "LearnRateDropPeriod",10,...
    "MaxEpochs",10,...
    "MiniBatchSize",16,...
    "Momentum",0.8,...
    "Shuffle","every-epoch",...
    "Plots","training-progress",...
    "ValidationData",imds_val);
% ------------insert training options----------------

[trainedNet, traininfo] = trainNetwork(imds_training,lgraph_1,opts);

