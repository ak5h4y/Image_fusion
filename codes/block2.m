function [imr,stat] = block2(im_select,W,image1,image2,r,c)
%if the image have part from another while it's surrounding is not from

%that it select block according to surrounding
    i=8*r+1;c1=1;
    j=8*c+1;c2=1;imr=rand(8,8);
    for x=i:i+7
        for y=j:j+7
          if (im_select(r+1,c+1)==1&&W(r+1,c+1)<0)||(im_select(r+1,c+1)==-1&&W(r+1,c+1)>=0)
              stat=1;
             if im_select(r+1,c+1)==1
                 imr(c1,c2)=image2(x,y);
             else
                 imr(c1,c2)=image1(x,y);
             end
          else
              stat=-1;
          end
          c2=c2+1;
        end
        c1=c1+1;
    end

end
