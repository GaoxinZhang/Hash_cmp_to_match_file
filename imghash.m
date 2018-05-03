function str1=imghash(img)
    %计算图片的hash值
    f=rgb2gray(img);%RGB转换为灰度图
    f=imresize(f,[8,8]);%缩放图片
    b=f>=mean2(f);%得到二值图
    b=b(:);
    L=size(b,1); %64
    str1=[];
    for j=1:4:L-3 %1:4:61
        x=b(j)*2^3+b(j+1)*2^2+b(j+2)*2^1+b(j+3);%选取相邻的四位计算 如1101 将其转换为十进制
        n=dec2hex(x); % 十进制转换为十六进制
        str1=strcat(str1,n);%得到16个字符
    end
end
