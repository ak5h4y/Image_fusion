%image input
imagei1 = imread('/media/ak5h4y/D1sk/PROJECT/c1.png');
imagei2 = imread('/media/ak5h4y/D1sk/PROJECT/c2.png');
%calculation of size of images
im_sizer = size(imagei1,1);block_sizer = floor(im_sizer/8);sr=im_sizer-block_sizer*8;sr=8-sr;
im_sizec = size(imagei1,2);block_sizec = floor(im_sizec/8);sc=im_sizec-block_sizec*8;sc=8-sc;
%padding to make rows and columnsof matrix multiple of 8
for r=1:im_sizer+sr
    for c=1:im_sizec+sc
        if r>im_sizer|c>im_sizec
            image1(r,c)=0;
            image2(r,c)=0;
        else
            image1(r,c)=imagei1(r,c);
            image2(r,c)=imagei2(r,c);
        end
    end
end
%fused image creation using DCT+SVD
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
%removal of padding to get exact size of two unfocused images
for r=1:im_sizer
    for c=1:im_sizec
        final_image(r,c)=fin(r,c);
    end
end
%conversion of matrix to image to get fused image
imwrite(mat2gray(final_image),'/media/ak5h4y/D1sk/PROJECT/cfused_dct_svd.png');
%consistency verification post-processing step
for j=1:block_sizec+1
  for i=1:block_sizer+1
    if i==1&j==1
      W(i,j)=(im_select(i,j)+im_select(i+1,j)+im_select(i,j+1)+im_select(i+1,j+1))/4;
    elseif i==1&j==block_sizec+1
      W(i,j)=(im_select(i,j)+im_select(i+1,j)+im_select(i,j-1)+im_select(i+1,j-1))/4;
    elseif i==block_sizer+1&j==1
      W(i,j)=(im_select(i,j)+im_select(i-1,j)+im_select(i,j+1)+im_select(i-1,j+1))/4;
    elseif i==block_sizer+1&j==block_sizec+1
      W(i,j)=(im_select(i,j)+im_select(i-1,j)+im_select(i,j-1)+im_select(i-1,j-1))/4;
    elseif i==1
      W(i,j)=(im_select(i,j)+im_select(i+1,j)+im_select(i,j-1)+im_select(i+1,j-1)+im_select(i,j+1)+im_select(i+1,j+1))/6;
    elseif j==1
      W(i,j)=(im_select(i,j)+im_select(i+1,j)+im_select(i-1,j)+im_select(i-1,j+1)+im_select(i,j+1)+im_select(i+1,j+1))/6;
    elseif i==block_sizer+1
      W(i,j)=(im_select(i,j)+im_select(i-1,j-1)+im_select(i-1,j)+im_select(i-1,j+1)+im_select(i,j+1)+im_select(i,j-1))/6;
    elseif j==block_sizec+1
      W(i,j)=(im_select(i,j)+im_select(i-1,j-1)+im_select(i-1,j)+im_select(i+1,j-1)+im_select(i+1,j)+im_select(i,j-1))/6;
    else
      W(i,j)=(im_select(i,j)+im_select(i-1,j-1)+im_select(i-1,j)+im_select(i+1,j-1)+im_select(i+1,j)+im_select(i,j-1)+im_select(i-1,j+1)+im_select(i,j+1)+im_select(i+1,j+1))/9;
    end
  end
end
%conversion of padded image according to W selections
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
%removal of padding to get exact size of two unfocused images
%fused image using DCT+SVD+CV
for r=1:im_sizer
    for c=1:im_sizec
        final_image(r,c)=fin(r,c);
    end
end
imwrite(mat2gray(final_image),'/media/ak5h4y/D1sk/PROJECT/cfused_dct_svd_cv.png');
