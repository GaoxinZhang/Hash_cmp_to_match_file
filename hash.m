%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% hash.m
% ���������ļ���imghash.m��hashcmp.m��
% �ҳ����Ƚ��ļ��У�һ�����е�ͼƬ��ԭʼ�ļ��У��༶���е�ͼƬ�Ķ�Ӧ��ϵ
% 27-3-2018 Created
% Author:Gaoxin Zhang
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% path_ori = 'C:\Users\Hancy\Desktop\injury_ori\';%ԭͼĿ¼
% fileExt = '*.jpg';
% files_ori = dir(fullfile(path_ori,fileExt));
%len_ori = size(files_ori,1);

path_cmp = 'C:\Users\Hancy\Desktop\injury_cmp\';%���Ƚϵ�ͼ���ڵ��ļ���
fileExt = '*.jpg';
files_cmp = dir(fullfile(path_cmp,fileExt));
len_cmp = size(files_cmp,1);

maindir_ori = 'C:\Users\Hancy\Desktop\injury_ori';%ԭͼ��Ŀ¼
subdir  = dir( maindir_ori );


for i=1:len_cmp%�������Ƚϵ�ͼƬ
    fileName_cmp = strcat(path_cmp,files_cmp(i,1).name);
    %sprintf('the original img is %s',files_cmp(i,1).name);
    f_cmp=imread(fileName_cmp);
    hash1=imghash(f_cmp);
    
    for k = 1 : length( subdir )%������Ŀ¼�µ�ÿ�����ļ���
        if( isequal( subdir( k ).name, '.' )||isequal( subdir( k ).name, '..')||~subdir( k ).isdir) % �������Ŀ¼������
            continue;
        end
        subdirpath = fullfile( maindir_ori, subdir( k ).name, '*.jpg' );% ���ļ������Һ�׺Ϊjpg���ļ�
        files_ori = dir( subdirpath );
        len_ori=size(files_ori,1);
        cc=zeros(1,len_ori);%���ڴ洢ĳ�Ŵ���ѡͼƬ��ԭͼ�����ܶ��ţ��Ķ�Ӧ��ϵ
        
        for j = 1 : length( files_ori )%�������ļ����µ�����ԭͼ
            if(files_cmp(i).bytes~=files_ori(j).bytes) % �������ͼ��С��ͬ������
                continue;
            end
            %fileName_ori = strcat(maindir_ori,subdir( k ).name,files_ori(j,1).name);
            fileName_ori = fullfile( maindir_ori, subdir(k).name, files_ori(j).name);
            f_ori=imread(fileName_ori);
            hash2=imghash(f_ori);
            cc(j)=hashcmp(hash1,hash2);
            if cc(j)
                sprintf('%s is similar to %s',files_cmp(i,1).name,files_ori(j,1).name)
                fid = fopen('cmp_result.txt','a+');
                fprintf(fid,'%s %s\n',fileName_cmp,fileName_ori);
                fclose(fid);
            end            
        end
    end
end


%     for j=1:len_ori
%         fileName_ori = strcat(path_ori,files_ori(j,1).name);
%         f_ori=imread(fileName_ori);
%         hash2=imghash(f_ori);
%         cc(j)=hashcmp(hash1,hash2);
%         if cc(j)
%             sprintf('%s is similar to %s',files_cmp(i,1).name,files_ori(j,1).name)
%             fid = fopen('b.txt','a+');
%             fprintf(fid,'%s %s\n',fileName_cmp,fileName_ori);
%             fclose(fid);
%         end
%     end     
