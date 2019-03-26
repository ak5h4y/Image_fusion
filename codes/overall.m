clear
%{
image1 = imread('F:/PROJECT/im_fusion_dataset/jug/jug1.jpg');
image2 = imread('F:/PROJECT/im_fusion_dataset/jug/jug2.jpg');
image3 = imread('F:/PROJECT/im_fusion_dataset/jug/jug-g.jpg');
if size(image1,3)==3
  imwrite(rgb2gray(image1),'F:/PROJECT/c1.png');
else
  imwrite(image1,'F:/PROJECT/c1.png');
end
if size(image2,3)==3
  imwrite(rgb2gray(image2),'F:/PROJECT/c2.png');
else
  imwrite(image2,'F:/PROJECT/c2.png');
end
if size(image3,3)==3
  imwrite(rgb2gray(image3),'F:/PROJECT/cref.png');
else
  imwrite(image3,'F:/PROJECT/cref.png');
end
%}
%image input
imagei1 = imread('F:/PROJECT/im/jug/jug_1.png');
imagei2 = imread('F:/PROJECT/im/jug/jug_2.png');

im_sizer = size(imagei1,1);block_sizer = floor(im_sizer/8);sr=im_sizer-block_sizer*8;sr=8-sr;
im_sizec = size(imagei1,2);block_sizec = floor(im_sizec/8);sc=im_sizec-block_sizec*8;sc=8-sc;
for r=1:im_sizer+sr
    for c=1:im_sizec+sc
        if r>im_sizer||c>im_sizec
            image1(r,c)=0;
            image2(r,c)=0;
        else
            image1(r,c)=imagei1(r,c);
            image2(r,c)=imagei2(r,c);
        end
    end
end
count =0;
for r=0:block_sizer
  for c=0:block_sizec
    [imr,im_select(r+1,c+1)]=block(image1,image2,r,c);
    i=8*r+1;c1=1;
    j=8*c+1;c2=1;
    for x=i:i+7
        for y=j:j+7
          fin(x,y)=imr(c1,c2);
          c2=c2+1;
        end
        c1=c1+1;
    end
  end
end
for r=1:im_sizer
    for c=1:im_sizec
        final_image(r,c)=fin(r,c);
    end
end
%imwrite(mat2gray(final_image),'F:/PROJECT/cfused_dct_svd.png');

for j=1:block_sizec+1
    for i=1:block_sizer+1
        W(i,j)=0;
        for pp=i-19:i+19
            for qq=j-19:j+19
                if pp>=1&&pp<=block_sizer+1
                    if qq>=1&&qq<=block_sizec+1
                        W(i,j)=W(i,j)+im_select(pp,qq);
                    end
                end
            end
        end
    if W(i,j)>0
        W(i,j)=1;
    else
        W(i,j)=-1;
    end
    
    
 %using cltran();column vise percent count   
    %{
    col=zeros(block_sizer+1,1);
    coli=zeros(block_sizer+1,1);
    for i=1:block_sizer+1
        col(i,1)=im_select(i,j);
    end
    coli=cltrans(col,coli,1,block_sizer+1);
    for i=1:block_sizer+1
        W(i,j)=coli(i,1);
    end
    %}
    end
end

%using rectrans(); block vise percent count
    %w1=im_select;
    %W=rectrans(im_select,w1,1,block_sizer+1,1,block_sizec+1);
for r=0:block_sizer
  for c=0:block_sizec
      [imr,stat]=block2(im_select,W,image1,image2,r,c);
      if stat==1
          i=8*r+1;c1=1;
          j=8*c+1;c2=1;
          for x=i:i+7
             for y=j:j+7
                fin(x,y)=imr(c1,c2);
                c2=c2+1;
             end
             c1=c1+1;
          end
      end
  end
end
for r=1:im_sizer
    for c=1:im_sizec
        final_image(r,c)=fin(r,c);
    end
end
imwrite(mat2gray(final_image),'F:/PROJECT/im/jug/jug_fused_dct_svd_cv9.png');
val3=imread('F:/PROJECT/im/jug/jug_fused_dct_svd_cv9.png');
ref=imread('F:/PROJECT/im/jug/jug_ref.png');
psnr_val=psnr(val3,ref)
ssim_val=ssim(val3,ref)
%{
val1=imread('F:/PROJECT/cfused_dct_svd_cv.png');
val2=imread('F:/PROJECT/cfused_dct_svd.png');
val3=imread('F:/PROJECT/im/jug/jug_ref.png');
without_cv_psnr=psnr(val1,val3)
without_cv_ssim=ssim(val1,val3)
with_cv_psnr=psnr(val2,val3)
with_cv_ssim=ssim(val2,val3)
%}