#include <stdio.h>
#include <iostream>

#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>

__global__ void combine(uchar *a, uchar *b, uchar *c){
	c[blockIdx.x] = (a[blockIdx.x] + b[blockIdx.x])/2;
}

int main(){
	// Load images
	const char *im0path = "media/im0.png";
	const char *im1path = "media/im1.png";
	cv::Mat im0_tmp = cv::imread(im0path,0);
	cv::Mat im1_tmp = cv::imread(im1path,0);
	uchar *im0, *im1, *im2;
	uchar *im0_c, *im1_c, *im2_c;
	int N = im0_tmp.rows*im0_tmp.cols; // Number of pixels
	std::cerr << "# Pixels: " << N << std::endl;
	int size = N * sizeof(uchar);
	
	// Show original images
	cv::imshow(im0path,im0_tmp);
	cv::imshow(im1path,im1_tmp);
	cv::waitKey(0);

	// Allocate space for device copies
	cudaMalloc((void **)&im0_c,size);
	cudaMalloc((void **)&im1_c,size);
	cudaMalloc((void **)&im2_c,size);

	// Allocate space for host copies
	im0 = im0_tmp.ptr();
	im1 = im1_tmp.ptr();
	im2 = (uchar *)malloc(size);

	// Copy inputs to device
	cudaMemcpy(im0_c, im0, size, cudaMemcpyHostToDevice);
	cudaMemcpy(im1_c, im1, size, cudaMemcpyHostToDevice);
	
	// Execute combine on GPU
	combine<<<N,1>>>(im0_c, im1_c, im2_c); // block indexing
	
	// Copy result to host
	cudaMemcpy(im2, im2_c, size, cudaMemcpyDeviceToHost);

	// Cleanup
	cv::Mat im_out(im0_tmp.rows, im0_tmp.cols, im0_tmp.type(), im2);
	cv::imshow("im_out",im_out);
	cv::waitKey(0);
	
	free(im2); // im0 and im1 memory is managed by opencv.
	cudaFree(im0_c); cudaFree(im1_c);

	return 0;
}
