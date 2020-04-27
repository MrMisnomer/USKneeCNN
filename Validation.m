clc
close all;
clear all
[test_Input_ds,test_Enhanced_ds,test_RW_ds,test_Manual_ds] = ...
MakeDatastoreFcn("test");

% load('RAND_Stack_Net_B_7.mat')
%  load('RAND_W_Net_B_11.mat')
% load('Hridayi_Test_1_1.mat');
% load('RAND_Stack_Net_B_9.mat')
% load('RAND_Stack_Net_B_1.mat')
% load('RAND_U_Net_2_3.mat')
 load('RANDEN_U_Net_1_9.mat')
Net1 = trainedNet;
clear trainedNet;
% load('RAND_Stack_Net_EN_6.mat')
% load('RAND_Stack_Net_EN_1.mat')
load('RAND_Stack_Net_Both_8.mat')
Net2 = trainedNet;
clear trainedNet;
% load('RAND_Stack_Net_Both_8.mat')
% load('RAND_W_Net_Both_3.mat')
load('RAND_W_Net_Both_2.mat')
Net3 = trainedNet;
clear trainedNet;
% load('RAND_Stack_Net_EN_10.mat')
% Net2 = trainedNet;
% clear trainedNet;
% load('RAND_Stack_Net_Both_Justin_10.mat')
% Net3 = trainedNet;
% clear trainedNet;
a =0;
t1 = 0;
t2 = 0;
t3 = 0;
for i = 1:50
    en = readimage(test_Enhanced_ds,i);
    in = readimage(test_Input_ds,i);
    man = readimage(test_Manual_ds,i);
    man = man>1;
    rw = readimage(test_RW_ds,i);
    in1 = augimg2(in,[0 0],[256 256]);
    en1 = augimg2(en,[0 0],[256 256]);
    A = zeros(256,256,2);
    A(:,:,1) = in1;
    A(:,:,2) = en1;
    s = size(in);
    tic
%     nn1 = predict(Net1,in1);
%     nn2 = predict(Net2,en1);
%     nn3 = predict(Net3,A);
    nn1 = predict(Net1,en1);
    nn2 = predict(Net2,A);
    nn3 = predict(Net3,A);
%     t1= t1 + toc;
%     tic
%     nn2 = predict(Net2,en1);
%     t2 =t2 + toc;
%     nn3 = predict(Net3,A);
%     t3 =t3 + toc;
    nn1 = nn2orig(nn1,s);
    nn2 = nn2orig(nn2,s);
    nn3 = nn2orig(nn3,s);

%     nn2 = nn2orig(nn2,s);
%     nn3 = nn2orig(nn3,s);
    if mod(i,5)==0
%         figure;
%         imshow(nn1>0.5);
        figure;
        subplot(2,3,1)
        imshow(in1);
        title('Original','FontSize',14);
        
        subplot(2,3,2)
        imshow(man);
        title('Manual Segmentation','FontSize',14);
        
        subplot(2,3,3)
        imshow(rw);
        title('Random Walker','FontSize',14);
        
        subplot(2,3,4)
        imshow(nn1>0.5);
        title('B-Mode','FontSize',14)

        subplot(2,3,5);
        imshow(nn2>0.5);
        title('Enhanced','FontSize',14);
%         
        subplot(2,3,6);
        imshow(nn3>0.5);
        title('Combined','FontSize',14);

    end
    
    dn1(i) = dice(man,nn1>0.5);
    bn1(i) = jaccard(man,nn1>0.5);
    dn2(i) = dice(man,nn2>0.5);
    bn2(i) = jaccard(man,nn2>0.5);
    dn3(i) = dice(man,nn3>0.5);
    bn3(i) = jaccard(man,nn3>0.5);
%     brw(i) = jaccard(man,rw);
%     drw(i) = dice(man,rw);
end
mean(dn1)
mean(dn2)
mean(dn3)








% clc
% close all;
% a =0;
% t1 = 0;
% t2 = 0;
% [test_Input_ds,test_Enhanced_ds,test_RW_ds,test_Manual_ds] = ...
% MakeDatastoreFcn("test");
% for i = 1:50
%     en = readimage(test_Enhanced_ds,i);
%     in = readimage(test_Input_ds,i);
%     man = readimage(test_Manual_ds,i);
%     man = man>1;
%     rw = readimage(test_RW_ds,i);
% %     in1 = augimg2(in,[0 0],[256 256]);
%     en1 = augimg2(en,[0 0],[256 256]);
% %     A(:,:,1) = in1;
% %     A(:,:,2) = en1;
%     s = size(in);
%     tic
%     nn1 = predict(trainedNet,en1);
%     t1= t1 + toc;
% %     tic
% %     nn2 = predict(Net2,A);
% %     t2 =t2 + toc;
%     nn1 = nn2orig(nn1,s);
% %     nn2 = nn2orig(nn2,s);
%     dn1(i) = dice(man,nn1>0.5);
% %     dn2(i) = dice(man,nn2>0.5);
%     drw(i) = dice(man,rw);
% end
% 


