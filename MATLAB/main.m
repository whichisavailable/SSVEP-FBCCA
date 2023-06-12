

str1 = 'data\S';
str2 = '.mat';
finalresult = [];
for s = 1:5
    for b = 1:2
        S = num2str(s);
        B = num2str(b);
        temp = strcat(S,'B');
        temp = strcat(temp,B);
        str = strcat(str1,temp);
        str = strcat(str,str2);
        load(str);
        %获得每次trial的起止点
        startindex=find(data1(11,:)==1);
        endindex = find(data1(11,:)==241);
        labellist = [];
        alist = [];
        %分别对每个trial做fbcca
        for k = 1:22
            %len = endindex(1,k)-startindex(1,k);
            %为方便后续处理，这里统一取3800样本点
            len = 3800;
            flag  = startindex(1,k);

            %考虑开始时的延迟,d=0.14s

            sc(1,1:len-140+1) = 0;
            for i =1:10
                channel = data1(i,flag+0.14*1000:flag+len);
                sc = sc + channel;
            end
            sc = sc./10;
            
            fsc = fft(sc);
            % plot(0:(len-0.14*1000),abs(fsc));

            [label,a] = fbcca(sc);
            labellist = [labellist,label];
            alist = [alist,a];
        end
        finalresult = [finalresult;labellist];
    end
end
finalresult = finalresult';
%csvwrite("U202015128_孙泽宇.csv",finalresult);