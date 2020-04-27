function [AugmentedImages] = augimg2(Image,Vars,Size)
%AUGMENT Summary of this function goes here
%   Detailed explanation goes here
%Vars: [ rotation translation XFlip? ]
maxRot = 5;
maxXTrans = 5;
maxYTrans = 5;
l =1;
AugmentedImages = Image;
if Vars(1)
    r = maxRot*rand(1);
    AugmentedImages = imrotate(AugmentedImages,r); 


end
if Vars(2)
   r1  = randi(maxXTrans);
   r2 = randi(maxYTrans);
   AugmentedImages = imtranslate(AugmentedImages,[r1,r2]);

end
% if Vars(3)
%    AugmentedImage = flipud(AugmentedImage);
% end

m = min(size(AugmentedImages));

AugmentedImages =  imcrop(AugmentedImages,[0 0 m m]);
AugmentedImages = imresize(AugmentedImages,Size);

% AugmentedImages{end} = 255*(AugmentedImages{end}>100);
% AugmentedImages{end} =  categorical(AugmentedImages{end},[0 255],{'background', 'foreground'});

end

