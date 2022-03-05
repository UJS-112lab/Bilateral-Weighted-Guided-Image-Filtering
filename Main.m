clc,clear;
image = im2double(imread("statue.png"));

% ORout = ones(size(image,1),size(image,2),size(image,3));
% ORout(:,:,1) = bilateralweightedguidedfilter0(image(:,:,1),image(:,:,1),8,0.1,5,0.06,1);
% ORout(:,:,2) = bilateralweightedguidedfilter0(image(:,:,2),image(:,:,2),8,0.1,5,0.06,1);
% ORout(:,:,3) = bilateralweightedguidedfilter0(image(:,:,3),image(:,:,3),8,0.1,5,0.06,1);
% figure, imshow([image,ORout]);

Fastout = ones(size(image,1),size(image,2),size(image,3));
Fastout(:,:,1) = m6_bilateralweightedguidedfilter_fast(image(:,:,1),image(:,:,1),0.1,5,0.06,1);
Fastout(:,:,2) = m6_bilateralweightedguidedfilter_fast(image(:,:,2),image(:,:,2),0.1,5,0.06,1);
Fastout(:,:,3) = m6_bilateralweightedguidedfilter_fast(image(:,:,3),image(:,:,3),0.1,5,0.06,1);
figure, imshow([image,Fastout]);