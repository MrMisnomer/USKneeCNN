
function [AugmentedImages] = augimg1(Images,Vars,Size)
%AUGMENT Summary of this function goes here
%   Detailed explanation goes here
%Vars: [ rotation translation XFlip? ]
% maxRot = 180;
% maxXTrans = 20;
% maxYTrans = 20;
% maxRot = 60;
% maxXTrans = 30;
% maxYTrans = 30;

% For Rand_U_Net_1 and 2
maxRot = 20;
maxXTrans = 20;
maxYTrans = 20;


% For Rand2_U_Net_1 and 2
% maxRot = 180;
% maxXTrans = 20;
% maxYTrans = 20;
l = length(Images);
AugmentedImages = Images;
if Vars(1)
%     r = maxRot*rand(1)- 90;
    r = maxRot*(0.5-rand(1));

    for i = 1:l
        AugmentedImages{i} = imrotate(AugmentedImages{i},r); 
    end

end
if Vars(2)
   r1  = randi(maxXTrans);
   r2 = randi(maxYTrans);
   for i = 1:l
   AugmentedImages{i} = imtranslate(AugmentedImages{i},[r1,r2]);
   end
end
if Vars(3)
  for i = 1:l
   AugmentedImages{i} = fliplr(AugmentedImages{i});
   end
end
% if Vars(4)
%   for i = 1:l
%    AugmentedImages{i} = flipud(AugmentedImages{i});
%    end
% end
m = min(size(AugmentedImages{1}));
for i = 1:l
    AugmentedImages{i} =  imcrop(AugmentedImages{i},[0 0 m m]);
    AugmentedImages{i} = imresize(AugmentedImages{i},Size);
%     if i~=l
%         AugmentedImages{i} = imnoise(AugmentedImages{i},'speckle',0.3);
%     end
end
AugmentedImages{end} = 255*(AugmentedImages{end}>100);
AugmentedImages{end} =  categorical(AugmentedImages{end},[0 255],{'background', 'foreground'});

end

