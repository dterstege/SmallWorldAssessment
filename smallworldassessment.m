function [SW,D,C,CR,E,ER] = smallworldassessment(cor,thresh)
%
%   ~~~~~~~~~~~~~~~~~~ Small World Assessment ~~~~~~~~~~~~~~~~~~~~~~
%
%   Not a true small world coefficient, but gets at the same thing
%
%   Can't calculate true small world coefficient due to disconect between
%   components. Shortest path length would be inifite
%
%   Therefore we can look at integration using global efficiency and
%   segregation using clustering coefficient
%
%   These metrics are then compared to a random graph
%
%   The same can be done for the distribution of degrees
%
%   [SW,D,C,CR,E,ER] = smallworldassessment(cor,thresh)
%
%   INPUT:
%       cor = sqaure correlation matrix (as a double)
%       thresh = threshold by which the matrix will be binarized (0-1.0)
%           Default is 0.8
%
%   OUTPUT:
%       SW = Does this network show small world tendencies, (TRUE/FALSE)
%       D = Degree per node
%       C = Mean clustering coefficient in input matrix
%       CR = Mean clustering coefficient in random matrix
%       E = Global efficiency of input matrix
%       ER = Global efficiency of random matrix
%   
%   NOTE: THIS WAS WRITTEN FOR UNDIRECTED NETWORKS
%
%Created 01/25/2021 Dylan Terstege
%Epp Lab, University of Calgary
%Contact: dylan.terstege@ucalgary.ca

%check threshold
if nargin<2
    thresh=0.8;
end
%check matrix
if nargin<1
    error('no correlation matrix is present');
end
if size(cor,1)~=size(cor,2)
    error('this correlation matrix is not square');
end
if isa(cor,'double')
else
    error('this correlation matrix ix not a double');
end
%binarize
cor(isnan(cor))=0;
cor(cor<thresh & cor>-(thresh))=0;
cor(cor>thresh | cor<-(thresh))=1;
%make random network
R=cor;
numedge=sum(sum(cor));
Rnull=zeros(length(cor),length(cor));
maxswap=numedge;
[i,j] = find(triu(R,1));
m = length(i);
nswap = 0;
while nswap < maxswap
    while 1
        e1 = randi(m); e2 = randi(m);
        while e2 == e1
            e2 = randi(m);
        end
        a = i(e1); b = j(e1);
        c = i(e2); d = j(e2);
        if all(a~=[c,d]) && all(b~=[c,d])
            break
        end
    end
    if rand > 0.5
        i(e2) = d; j(e2) = c;
        c = i(e2); d = j(e2);
    end
    if ~(R(a,d) || R(c,b) || Rnull(a,d) || Rnull(c,b))
        R(a,d) = R(a,b); R(a,b) = 0;
        R(d,a) = R(b,a); R(b,a) = 0;
        R(c,b) = R(c,d); R(c,d) = 0;
        R(b,c) = R(d,c); R(d,c) = 0;
        j(e1) = d;
        j(e2) = b;
        nswap = nswap + 1;
    end
end
%find degree
D=(sum(cor))';
%find mean clustering coefficient
n=length(cor);
C=zeros(n,1);
for u=1:n
    V=find(cor(u,:));
    k=length(V);
    if k>=2
        S=cor(V,V);
        C(u)=sum(S(:))/(k^2-k);
    end
end
n=length(R);
CR=zeros(n,1);
for u=1:n
    V=find(R(u,:));
    k=length(V);
    if k>=2
        S=R(V,V);
        CR(u)=sum(S(:))/(k^2-k);
    end
end
%find global efficiency
n=length(cor); 
cor(1:n+1:end)=0;
cor=double(cor~=0);
e=distance_inv(cor);
E=sum(e(:))./(n^2-n);
n=length(R);
R(1:n+1:end)=0;
R=double(R~=0);
e=distance_inv(R);
ER=sum(e(:))./(n^2-n);
%statistical comparisons
[hypC,~,~,~]=ttest2(C,CR);
y=normrnd(E,1,500,1);
E=bootstrp(100,@mean,y);
yR=normrnd(ER,1,500,1);
ER=bootstrp(100,@mean,yR);
[hypE,~,~,~]=ttest2(E,ER);
if hypC==1 && hypE==0
    SW='TRUE';
    disp('Network has Small World-like Characteristics')
else
    SW='FALSE';
    disp('Network does not display Small World-like Characteristics')
end
end

function D=distance_inv(A_)
l=1;        
Lpath=A_;
D=A_;
n_=length(A_);
Idx=true;
while any(Idx(:))
    l=l+1;
    Lpath=Lpath*A_;
    Idx=(Lpath~=0)&(D==0);
    D(Idx)=l;
end
D(~D | eye(n_))=inf;
D=1./D; 
end