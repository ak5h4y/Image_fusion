clear
%val2=imread('F:/PROJECT/im/jug_fused_dct_svd_cv.png');
%val1=imread('F:/PROJECT/im/jug_fused_dct_svd.png');
val3=imread('F:/PROJECT/im/jug_fused_dct_svd_cv1.png');
ref=imread('F:/PROJECT/im/jug_ref.png');
%ssim(val1,ref)
%ssim(val2,ref)
ssim(val3,ref)