(function(){var p=document,k=(/^https?:\/\/.*?linkedin.*?\/in\.js.*?$/),b=(/async=true/),A=(/^https:\/\//),G=(/\/\*((?:.|[\s])*?)\*\//m),C=(/\r/g),h=(/[\s]/g),f=(/^[\s]*(.*?)[\s]*:[\s]*(.*)[\s]*$/),y=(/^[\s]+|[\s]+$/g),j="\n",D=",",m="",F="@",O="&",n="extensions",o="api_key",R="on",v="onDOMReady",T="onOnce",S="script",I="https://www.linkedin.com/uas/js/userspace?v=0.0.1120-RC2.6365-1337",g="https://platform.linkedin.com/js/secureAnonymousFramework?v=0.0.1120-RC2.6365-1337",E="http://platform.linkedin.com/js/nonSecureAnonymousFramework?v=0.0.1120-RC2.6365-1337",z=p.getElementsByTagName("head")[0],t=p.getElementsByTagName(S),a=[],K={},c=false,U,l,P,r,H,B,d;
if(window.IN&&IN.ENV&&IN.ENV.js){return
}window.IN=window.IN||{};
IN.ENV={};
IN.ENV.js={};
IN.ENV.js.extensions={};
IN.ENV.evtQueue=[];
U=IN.ENV.evtQueue;
IN.Event={on:function(){U.push({type:R,args:arguments})
},onDOMReady:function(){U.push({type:v,args:arguments})
},onOnce:function(){U.push({type:T,args:arguments})
}};
IN.$extensions=function(X){var aa,i,W,Z,Y=IN.ENV.js.extensions;
aa=X.split(D);
for(var V=0,e=aa.length;
V<e;
V++){i=N(aa[V],F,2);
W=i[0].replace(y,m);
Z=i[1];
if(!Y[W]){Y[W]={src:(Z)?Z.replace(y,m):m,loaded:false}
}}};
function N(X,V,e){if(!e){return X.split(V)
}var Y=X.split(V);
if(Y.length<e){return Y
}var W=Y.splice(0,e-1);
var i=Y.join(V);
W.push(i);
return W
}function u(e,i){if(e==n){IN.$extensions(i);
return null
}if(e==o){i=i.replace(h,m)
}if(i==""){return null
}return i
}l="";
for(M=0,q=t.length;
M<q;
M++){var d=t[M];
if(!k.test(d.src)){continue
}if(b.test(d.src)){c=true
}try{l=d.innerHTML.replace(y,m)
}catch(x){try{l=d.text.replace(y,m)
}catch(w){}}}l=l.replace(G,"$1");
l=l.replace(y,m);
l=l.replace(C,m);
for(var M=0,L=l.split(j),q=L.length;
M<q;
M++){var s=L[M];
if(!s||s.replace(h,m).length<=0){continue
}try{P=s.match(f);
r=P[1].replace(y,m);
H=P[2].replace(y,m)
}catch(Q){throw"Script tag contents must be key/value pairs separated by a colon. Source: "+Q
}H=u(r,H);
if(H){IN.ENV.js[r]=H;
a[a.length]=encodeURIComponent(r)+"="+encodeURIComponent(H)
}}IN.ENV.js.secure=(document.location.href.match(A))?1:0;
a[a.length]="secure="+encodeURIComponent(IN.ENV.js.secure);
IN.init=function J(e){var V;
e=e||{};
for(var i in e){if(e.hasOwnProperty(i)){V=u(i,e[i]);
if(V){IN.ENV.js[i]=V;
a[a.length]=encodeURIComponent(i)+"="+encodeURIComponent(V)
}}}B=p.createElement(S);
B.src=(IN.ENV.js.api_key)?I+O+a.join(O):(IN.ENV.js.secure)?g:E;
z.appendChild(B)
};
if(!c){IN.init()
}})();
