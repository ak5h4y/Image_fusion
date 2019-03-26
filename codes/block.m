function [imr,q] = block(image1,image2,r,c)
%taking 8*8 blocks
    i=8*r+1;c1=1;
    j=8*c+1;c2=1;
    for x=i:i+7
        for y=j:j+7
          edit1(c1,c2)=image1(x,y);
          edit2(c1,c2)=image2(x,y);
          c2=c2+1;
        end
        c1=c1+1;
    end
    %covert 8*8 blocks of both images into Descrete cosine transfort(DCT)
    im_dct1=dct2(edit1);im_dct2=dct2(edit2);
    %calculate svd of 8*8 blocks of DCTs
    singular_values1=svd(im_dct1);singular_values2=svd(im_dct2);
    svd1=(singular_values1(1,1)*singular_values1(2,1)*singular_values1(3,1)*singular_values1(4,1)*singular_values1(5,1))^(1/5);
    svd2=(singular_values2(1,1)*singular_values2(2,1)*singular_values2(3,1)*singular_values2(4,1)*singular_values2(5,1))^(1/5);
    %choose one block which is focused from two 8*8 blocks
    if svd1>=svd2
      imr=idct2(im_dct1);q=1;
    else
      imr=idct2(im_dct2);q=-1;
    end
%return resultant 8*8 block AND im+select(r,c)
end

