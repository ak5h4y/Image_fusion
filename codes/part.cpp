#include<iostream>
#include<string>
using namespace std;
void fun(vector<vector<char>> &x,char q,int n,int m){
  if(q=='L'||q=='R'){
    for(int i=0;i<n;i++){
      int c=0;
      for(int j=0;j<m;j++){
        if(x[i][j]=='1'){c++;}
      }
      if(q=='L'){
        for(int j=0;j<c;j++){
          x[i][j]='1';
        }for(int j=c;j<m;j++){
          x[i][j]='0';
        }
      }else{
        c=m-c;
        for(int j=0;j<c;j++){
          x[i][j]='0';
        }for(int j=c;j<m;j++){
          x[i][j]='1';
        }
      }
    }
  }
  if(q=='U'||q=='D'){
    for(int i=0;i<m;i++){
      int c=0;
      for(int j=0;j<n;j++){
        if(x[j][i]=='1'){c++;}
      }
      if(q=='U'){
        for(int j=0;j<n;j++){
          x[j][i]='1';
        }for(int j=c;j<n;j++){
          x[j][i]='0';
        }
      }else{
        c=n-c;
        for(int j=0;j<c;j++){
          x[j][i]='0';
        }for(int j=c;j<n;j++){
          x[j][i]='1';
        }
      }
    }
  }
}
int main(){
  int t;cin>>t;
  while(t--){
    int n,m;
    cin>>n>>m;
    vector<vector<char>>x;
    for(int i=0;i<n;i++){
      vector<char>y;
      for(int j=0;j<m;j++){
        char z;cin>>z;
        y.push_back(z);
      }
      x.push_back(y);
    }
    string s;
    cin>>s;
    char x='\0';y='\0';int st1=0,st2=0;
    for(int i=s.length()-1;i>=0;i++){
      if(st1==0){if(s[i]=='L'){x='L';st1=1;}else if(s[i]=='R'){x='R';st1=1;}}
      if(st2==0){if(s[i]=='U'){x='U';st2=1;}else if(s[i]=='D'){x='D';st2=1;}}
    }

    if(x1=='L')void(x,'L',n,m);
    if(x1=='R')void(x,'R',n,m);
    if(x2=='U')void(x,'U',n,m);
    if(x1=='D')void(x,'D',n,m);
    for(int i=0;i<n;i++){
      for(int j=0;j<m;j++){
        cout<<x[i][j];
      }cout<<endl;
    }
  }
}
