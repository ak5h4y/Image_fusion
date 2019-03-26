function [coli] =cltrans(col,coli,s,e)
    if s==e
        coli(s,1)=col(s,1);
    elseif s==e-1
        coli(s,1)=col(s,1);
        coli(e,1)=col(e,1);
    else
        c=0;
        for i=s:e
            if col(i,1)==1
                c=c+1;
            end
        end
        per=(c*100)/(e-s+1);
        if per>=70
            for d=s:e
                coli(d,1)=1;
            end
        elseif per<30
            for g=s:e
                coli(g,1)=-1;
            end
        else
            z=floor((s+e)/2);
            coli=cltrans(col,coli,s,z);
            coli=cltrans(col,coli,z+1,e);
        end
    end
end

