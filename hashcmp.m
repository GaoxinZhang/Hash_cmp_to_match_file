function cc=hashcmp(hash1,hash2)
%将两张图片的hash值进行比较（汉明距离），判断是否为同一张图片
    n1=0;
for j=1:size(hash2,2)
    n2=strcmp(hash2(j),hash1(j));
    n1=n1+n2;
end
    if n1>14
        cc=1;
    else
        cc=0;
    end
end

