%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% hash.m
% 包含函数文件（imghash.m和hashcmp.m）
% 找出待比较文件夹（一级）中的图片与原始文件夹（多级）中的图片的对应关系
% 27-3-2018 Created
% Author:Gaoxin Zhang
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% path_ori = 'C:\Users\Hancy\Desktop\injury_ori\';%原图目录
% fileExt = '*.jpg';
% files_ori = dir(fullfile(path_ori,fileExt));
%len_ori = size(files_ori,1);

path_cmp = 'C:\Users\Hancy\Desktop\injury_cmp\';%待比较的图所在的文件夹
fileExt = '*.jpg';
files_cmp = dir(fullfile(path_cmp,fileExt));
len_cmp = size(files_cmp,1);

maindir_ori = 'C:\Users\Hancy\Desktop\injury_ori';%原图根目录
subdir  = dir( maindir_ori );


for i=1:len_cmp%遍历待比较的图片
    fileName_cmp = strcat(path_cmp,files_cmp(i,1).name);
    %sprintf('the original img is %s',files_cmp(i,1).name);
    f_cmp=imread(fileName_cmp);
    hash1=imghash(f_cmp);
    
    for k = 1 : length( subdir )%遍历根目录下的每个子文件夹
        if( isequal( subdir( k ).name, '.' )||isequal( subdir( k ).name, '..')||~subdir( k ).isdir) % 如果不是目录则跳过
            continue;
        end
        subdirpath = fullfile( maindir_ori, subdir( k ).name, '*.jpg' );% 子文件夹下找后缀为jpg的文件
        files_ori = dir( subdirpath );
        len_ori=size(files_ori,1);
        cc=zeros(1,len_ori);%用于存储某张待挑选图片与原图（可能多张）的对应关系
        
        for j = 1 : length( files_ori )%遍历子文件夹下的所有原图
            if(files_cmp(i).bytes~=files_ori(j).bytes) % 如果两张图大小不同则跳过
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
