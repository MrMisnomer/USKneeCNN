clc
clear all 
close all
load('Datastores_7.mat');
% load('Intial_Nets.mat');
% load('default_Unet.mat');
load('Initial_U_1.mat')
% load('Initial_U.mat')
% load('Initial_W_2.mat')
% load('Initial_Stack2.mat');
% net = createUnet();



[train_Input_ds,train_Enhanced_ds,train_RW_ds,train_Manual_ds] = ...
MakeDatastoreFcn("train");

[test_Input_ds,test_Enhanced_ds,test_RW_ds,test_Manual_ds] = ...
MakeDatastoreFcn("test");

initialLearningRate = 0.05;
maxEpochs = 20;
minibatchSize = 10;
patchsize = 20;
batchimages = 100;
l2reg = 0.0001;
imsize = [256,256];
options = trainingOptions('sgdm',...
    'InitialLearnRate', initialLearningRate, ...
    'L2Regularization',l2reg,...
    'MaxEpochs',maxEpochs,...
    'MiniBatchSize',minibatchSize,...
    'VerboseFrequency',20,...
    'LearnRateSchedule','piecewise',... 
        'Shuffle','never',...
    'Plots','training-progress',...
    'GradientThresholdMethod','l2norm',...
    'GradientThreshold',0.05);
% options = trainingOptions('adam',...
%     'MiniBatchSize',minibatchSize,...
%         'Shuffle','never');
%     'Momentum',0.9,...
%     'Shuffle','every-epoch',...
ds = Mini(train_Input_ds,train_Enhanced_ds,train_RW_ds,train_Manual_ds,...
    patchsize,minibatchSize,batchimages,imsize);




[trainedNet,  traininfo] = trainNetwork(ds,U_Net,options);
% [trainedNet,  traininfo] = trainNetwork(ds,Stack_Net_2,options);
% [trainedNet,  traininfo] = trainNetwork(ds,W_Net_2,options);
% 






