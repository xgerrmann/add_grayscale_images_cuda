#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>

int main(){
	// Load images
	im0path = "media/im0.png"
	im1path = "media/im1.png"
	cv::Mat im0 = cv::imread(im0path,0);
	cv::Mat im1 = cv::imread(im0path,1);

	cv::imshow('Im0',im0);
	cv::imshow('Im1',im1);
	cv::waitKey(0);
	return 0;
}
