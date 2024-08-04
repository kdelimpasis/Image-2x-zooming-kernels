function output = subsampling(input, n)
% Subsample an image, the image is subsampled
% to avoid distortion due to the subsampling
% Inputs
% 	input 	image
%	n 		subsampling
% number of arguments check and error msg

% https://www.mathworks.com/matlabcentral/fileexchange/6748-subsampling-input-n

error(nargchk(2,2,nargin)); 
input = double(input);
% create a FIR filter
Hd = zeros(13,13);
Hd(4:10,4:10) = 1;
h = fwind1(Hd, hamming(13), hamming(13));  % h=[1];
% sig=0.8;
% h=fspecial('gaussian',[ceil(6*sig+1),ceil(6*sig+1)],sig);
% freq. response of the filter
%figure; freqz2(h);
% filter the image
im_f = imfilter(input, h, 'symmetric');
% subsample the filtered image
% output = im_f(2:n:end, 2:n:end);
output = im_f(1:n:end, 1:n:end);