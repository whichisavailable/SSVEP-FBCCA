function [label,a] = fbcca(sc)
%用fbcca算法进行识别,label返回标签,a为置信度
%%%%%%%%%%%%%%%
%设计filter bank,N=7
data_f=[];
fil1 = filter(filter1,sc);
data_f = [data_f;fil1];
fil2 = filter(filter2,sc);
data_f = [data_f;fil2];
fil3 = filter(filter3,sc);
data_f = [data_f;fil3];
fil4 = filter(filter4,sc);
data_f = [data_f;fil4];
fil5 = filter(filter5,sc);
data_f = [data_f;fil5];
fil6 = filter(filter6,sc);
data_f = [data_f;fil6];
fil7 = filter(filter7,sc);
data_f = [data_f;fil7];

%先滤波再降采样，避免混叠失真
 redata_f=resample(double(data_f'),250,1000);
 redata_f=redata_f';
 
 % fcres=fft(cres);
 % plot(0:(len-0.14*1000-1)/4,abs(fcres));
 for i = 1:7
    [nredata_f(i,:),~] = mapstd(redata_f(i,:));
 end
%%%%%%%%%%%%%%%
%普通cca
ftable = 8:0.3:13.7;
fs = 250;
len = length(nredata_f(1,:));
dt = 1/fs;
rlist = [];


for k = 1:7
    r = [];
    for i = 1:length(ftable)
        %对于第i种
        f = ftable(i);
        reference = [];
        for n = 1:3    %考虑3次谐波(参数可调)
            t = 1:len;
            sinx = sin(2*pi*f*n*dt*(t-1));
            cosx = cos(2*pi*f*n*dt*(t-1));
            %normalize
            [nsinx,~]=mapstd(sinx);
            [ncosx,~]=mapstd(cosx);
            reference = [reference,nsinx'];
            reference = [reference,ncosx'];
            %nsinx~1xn
            %reference~n*10
        end
        [~,~,rt]=canoncorr(reference,nredata_f(k,:)');
        rt = rt^2;
        r = [r,rt];
    end
    rlist = [rlist;r];
end
w = [1:7].^(-1.25)+0.25;
rlist = rlist'*w';

[maxval,maxindex] = max(rlist);
a = maxval;
label = maxindex;
end
