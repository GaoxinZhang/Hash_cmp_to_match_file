function str1=imghash(img)
    %����ͼƬ��hashֵ
    f=rgb2gray(img);%RGBת��Ϊ�Ҷ�ͼ
    f=imresize(f,[8,8]);%����ͼƬ
    b=f>=mean2(f);%�õ���ֵͼ
    b=b(:);
    L=size(b,1); %64
    str1=[];
    for j=1:4:L-3 %1:4:61
        x=b(j)*2^3+b(j+1)*2^2+b(j+2)*2^1+b(j+3);%ѡȡ���ڵ���λ���� ��1101 ����ת��Ϊʮ����
        n=dec2hex(x); % ʮ����ת��Ϊʮ������
        str1=strcat(str1,n);%�õ�16���ַ�
    end
end
