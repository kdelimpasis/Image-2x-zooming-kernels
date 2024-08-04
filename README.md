# Image 2x-zooming kernels
This code calculates the kernels of several interpolation methods for 2D image zooming 2x. Most of the methods are well known. However we also provide the kernels for a least utilized method: Hermite coordinate interpolation.
The generic concept of 2x image zooming with convolution-based interpolation entails 3 kernels as shown in the Fig. below.
![Fig1_3kernels](https://github.com/kdelimpasis/Image-2x-zooming-kernels/assets/94488062/6b54dc68-9e7f-4c54-8a0c-ed50254d86b8)
## Interpolation methods supported
This implementation supports both Traditional and Generalized convolution-based methods. 
1. __Traditional convolution-based methods__
We have precalculated the 3 required kernels for a number of simple well-knonw interpolation methods
   - nearest
   - bilinear 
   - bicubic 4-point
   - bicubic 8-point
2. __Generalized convolution-based methods__
We have precalculated the 3 required kernels for a number of state-of-the-art interpolation methods. The prefiltering step is being performed for each method and each image.
   - b-spline 3th and 5th degree
   - OMOM 3th. 4th, 5th and 7th degree
   - _Proposed __Hermite__ interpolation_
This is a mathematically demanding method that interpolates images using up to 2nd order image derivatives along each axis. The mathematical foundations can be found in [1]. To accelerate the application of the method, we constructed the Hermite kernels for 2x image zooming, as it is explained in [2]. This implemetation uses 5x5 kernels and all 9 combinations of image partial derivatives up to 2nd degree.

The required 2x zoom kernels for all methods have been pre-calculated and stored in 2 .mat files.

## Examples
The main function is `image2D_zoom_final_fun`, which accepts 2 input arguments: an NxN 2D image (single or double) and a binary vector of 11 elements, corresponding to the interpolation methods to be applied. If the ith element if 1 then the corresponding method will be applied. The indexing of the available methods is given below.
1. Hermite
2. nearest
3. bilinear
4. bicubic
5. OMOM4
6. OMOM5
7. OMOM7
8. B-Spline deg=3
9. B-Spline deg=5
10. Cubic poly deg=3, 8-point
11. bicubic custom.
    
The output is a 2N x 2N x K array, whose kth slice (k=1,2,..,K) is the zoomed image using the kth method.

Example:
`Ix2=image2D_zoom_final_fun(I,[1,0,0,0,1])`

The Hermite and the OMOM deg. 4 will be applied to I. The output Ix2 will be of size 2N x 2N x 5. Thus `Ix2(:,:P,1)` is the resulting zoom using Hermite, `Ix2(:,:P,5)` is the resulting zoom using OMOM4, whereas `Ix2(:,:P,2)`, `Ix2(:,:P,3)`, `Ix2(:,:P,4)` contain zeros.  

1. `example1.m`: simple script that reads an image and invokes `image2D_zoom_final_fun`.
2. `example2.m`: more versatile script that subsamples an image, uses it as ground truth, generates the zoomed image (from the subsampled one) and calculates the Mean Absolute Error (MAE) and PSNR.

References

[1] Kechriniotis, A. I., Delibasis, K. K., Oikonomou, I., & Tsigaridas, G. N. (2024). Classical multivariate Hermite coordinate interpolation on n-dimensional grids. Journal of Computational and Applied Mathematics, 449, 115962.

[2] Delibasis, K. K., Oikonomou, I., Kechriniotis, A. I., & Tsigaridas, G. N. (2024). Hermite coordinate interpolation kernels: application to image zooming. arXiv preprint arXiv:2403.13195.
