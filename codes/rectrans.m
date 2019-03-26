function [QQ]= rectrans(im_select,W,r1,r2,c1,c2)
    if r1==r2&&c1==c2
        W(r1,c1)=im_select(r1,c1);
    elseif r1==r2
        con=0;
        r=r1;
            for c=c1:c2
                if im_select(r,c)==1
                    con=con+1;
                end
            end
        x=(c2-c1+1);
        y=(con*100)/x;
        if y>=75
            r=r1;
                for c=c1:c2
                    W(r,c)=1;
                end
        elseif y<25
            r=r1;
                for c=c1:c2
                    W(r,c)=-1;
                end
        else
            r=r1;
            for c=c1:c2
                W(r,c)=im_select(r,c);
            end
        end
    elseif c1==c2
        con=0;
        c=c1;
            for r=r1:r2
                if im_select(r,c)==1
                    con=con+1;
                end
            end
        x=(r2-r1+1);
        y=(con*100)/x;
        if y>=75
            c=c1;
                for r=r1:r2
                    W(r,c)=1;
                end
        elseif y<25
            c=c1;
                for r=r1:r2
                    W(r,c)=-1;
                end
        else
            c=c1;
            for r=r1:r2
                W(r,c)=im_select(r,c);
            end
        end
    elseif r1==r2-1&&c1==c2-1
        co=0;
        if im_select(r1,c1)==1
            co=co+1;
        end
        if im_select(r1,c2)==1
            co=co+1;
        end
        if im_select(r2,c1)==1
            co=co+1;
        end
        if im_select(r2,c2)==1
            co=co+1;
        end
        if co>=3
            W(r1,c1)=1;
            W(r1,c2)=1;
            W(r2,c1)=1;
            W(r2,c2)=1;
        elseif co<=1
            W(r1,c1)=-1;
            W(r1,c2)=-1;
            W(r2,c1)=-1;
            W(r2,c2)=-1;
        else
            W(r1,c1)=im_select(r1,c1);
            W(r1,c2)=im_select(r1,c2);
            W(r2,c1)=im_select(r2,c1);
            W(r2,c2)=im_select(r2,c2);
        end
    else
        con=0;
        for r=r1:r2
            for c=c1:c2
                if im_select(r,c)==1
                    con=con+1;
                end
            end
        end
        x=(r2-r1+1)*(c2-c1+1);
        y=(con*100)/x;
        if y>=75
            for r=r1:r2
                for c=c1:c2
                    W(r,c)=1;
                end
            end
        elseif y<25
            for r=r1:r2
                for c=c1:c2
                    W(r,c)=-1;
                end
            end
        else
            r12=floor((r1+r2)/2);
            c12=floor((c1+c2)/2);
            W=rectrans(im_select,W,r1,r12,c1,c12);
            W=rectrans(im_select,W,r12+1,r2,c1,c12);
            W=rectrans(im_select,W,r1,r12,c12+1,c2);
            W=rectrans(im_select,W,r12+1,r2,c12+1,c2);
        end
    end
    QQ=W;
end

