@if (true == false) @end /*!
@"%windir%\System32\cscript.exe" //nologo //e:javascript "%~dpnx0" %*
@goto :EOF */

//
// doc2html and more
//
// Copyright (c) 2004, 2009, 2010, 2012, 2016 Ildar Shaimordanov
//

///////////////////////////////////////////////////////////////////////////
//js/win32/FileSystem.js

if('undefined'==typeof FileSystem){function FileSystem(){};}FileSystem.fileName=WScript.ScriptName;FileSystem.fullName=WScript.ScriptFullName;FileSystem.dirName=FileSystem.fullName.replace(/\\[^\\]+$/,'');(function(){var each;var filter;var result;var path;var pp;var cmd;var error;var exitCode;var delay=0;var _prepFind=function(options){options=options||{};if(options.delay>0){delay=options.delay;}cmd=[];error=[];exitCode=[];var f;if(options.folders){f=' /ad ';}else{f=' /a-d ';}var p;var s;var b;if(options.recursive){p=function(path){return'';};s=' /s ';b=' \\\\';}else{p=function(path){return path;};s='';b=' ^';}var cmd1='';if(options.codepage){cmd1+='%COMSPEC% /c chcp '+options.codepage+'>nul && ';}cmd1+='%COMSPEC% /c dir /b '+f+s;var cmd3='';if(options.included){cmd3+=' | findstr /i /e "'+b+FileSystem.wildcard2regex(options.included,true,true).join(b)+'"';}if(options.excluded){cmd3+=' | findstr /v /i /e "'+b+FileSystem.wildcard2regex(options.excluded,true,true).join(b)+'"';}path=[].concat(options.path);pp=[];var pattern=[].concat(options.pattern||'*');var fso=new ActiveXObject('Scripting.FileSystemObject');for(var i=0;i<path.length;i++){path[i]=fso.GetAbsolutePathName(path[i]);var cmd2;if(fso.FileExists(path[i])||path[i].match(/[\?\*]/)){cmd2=path[i];pp[i]=p(path[i].replace(/[^\\]+$/,''));}else{if(path[i].slice(-2)!=':\\'){path[i]+='\\';}cmd2=path[i]+pattern.join('" "'+path[i]);pp[i]=p(path[i]);}var cmdLine=[cmd1,'"',cmd2,'"',cmd3].join('');cmd.push(cmdLine);}if(typeof options.each=='function'){result=0;each=function(v){result++;options.each(v);};}else{result=[];each=function(v){result.push(v);};}if(typeof options.filter=='function'){filter=function(v){if(options.filter(v,options)){each(v);}};}else{filter=each;}};var _makeFind=function(){var sh=new ActiveXObject('WScript.Shell');for(var i=0;i<path.length;i++){var ex=sh.Exec(cmd[i]);var err='';while(1){if(!ex.StdOut.AtEndOfStream){filter(pp[i]+ex.StdOut.ReadLine());continue;}if(!ex.StdErr.AtEndOfStream){err+=ex.StdErr.ReadLine();continue;}if(ex.Status==1){break;}WScript.Sleep(delay);}error.push(err);exitCode.push(ex.ExitCode);}};FileSystem.find=function(options){var start=(new Date()).getTime();_prepFind(options);_makeFind();arguments.callee.debug={cmd:cmd,error:error,exitCode:exitCode,duration:(new Date()).getTime()-start};return result;};})();FileSystem.wildcard2regex=function(wildcard,skipRegexp,strictly){var convert=arguments.callee[strictly?'strictly':'std'];var result=[];if(Object.prototype.toString.call(wildcard)=='[object String]'){result.push(convert(wildcard));}else{for(var i=0;i<wildcard.length;i++){result.push(convert(wildcard[i]));}}return skipRegexp?result:new RegExp('^('+result.join('|')+')$','i');};FileSystem.wildcard2regex.strictly=function(wildcard){var result=wildcard.replace(/([\^\$\\\/\|\.\+\!\[\]\(\)\{\}])/g,'\\$1').replace(/\?/g,'[^\\\\]?').replace(/\*/g,'[^\\\\]*');return result;};FileSystem.wildcard2regex.std=function(wildcard){var result=wildcard.replace(/([\^\$\\\/\|\.\+\!\[\]\(\)\{\}])/g,'\\$1').replace(/\?/g,'.?').replace(/\*/g,'.*?');return result;};(function(){FileSystem.readFile=function(input,format){var h,wasFilename;if(input&&'object'==typeof input){h=input;}else{wasFilename=true;var fso=new ActiveXObject('Scripting.FileSystemObject');var f=fso.GetFile(input);h=f.OpenAsTextStream(1,Number(format)||0);}var result=h.ReadAll();if(wasFilename){h.Close();}return result;};var writer=function(output,text,iomode,create,format){var h,wasFilename;if(output&&'object'==typeof output){h=output;}else{wasFilename=true;var fso=new ActiveXObject('Scripting.FileSystemObject');h=fso.OpenTextFile(output,iomode,create,format||0);}h.Write(text);if(wasFilename){h.Close();}};FileSystem.writeFile=function(output,text,create,format){writer(output,text,2,create,format);};FileSystem.appendFile=function(output,text,create,format){writer(output,text,8,create,format);};})();(function(){var _wildcard2regexp=function(wildcard,returnRegex){var pattern=wildcard.replace(/([\^\$\\\/\|\.\+\!\[\]\(\)\{\}])/g,'\\$1').replace(/\?/g,'.?').replace(/\*/g,'.*?');return returnRegex?new RegExp(pattern):pattern;};FileSystem.wildcard2regexp=function(wildcard,returnRegexp){if(Object.prototype.toString.call(wildcard)=='[object String]'){return _wildcard2regexp.apply(null,arguments);}var result=[];for(var i=0;i<wildcard.length;i++){if(i in wildcard){result.push(_wildcard2regexp(wildcard[i]));}}return new RegExp(result.join('|'));};})();FileSystem.glob=function(pattern,foldersOnly){var fso=new ActiveXObject('Scripting.FileSystemObject');var matches=pattern.match(/((?:[a-zA-Z]\:)?.*?\\?)([^\\]*?[\*\?][^\\]*?$)/);if(!matches){if(fso.FileExists(pattern)){return[fso.GetAbsolutePathName(pattern)];}throw new Error(pattern+': File not found');}var regexp=new RegExp();var regsrc=matches[2].replace(/\\/g,'\\\\').replace(/([\^\$\+\.\[\]\(\)\|])/g,'\\$1').replace(/\?/g,'.').replace(/\*/g,'.*?');regexp.compile('\\\\'+regsrc+'$','i');var folderspec=matches[1];var collection=foldersOnly?'SubFolders':'Files';var f=fso.GetFolder(fso.GetAbsolutePathName(folderspec));var fc=new Enumerator(f[collection]);var result=[];for(;!fc.atEnd();fc.moveNext()){var i=fc.item();if(!regexp.test(i)){continue;}result.push(i);}return result;};FileSystem.GetAbsolutePathName=function(filespec,fso){fso=fso||new ActiveXObject("Scripting.FileSystemObject");return fso.GetAbsolutePathName(filespec);};FileSystem.GetLongPathName=function(filespec,fso){fso=fso||new ActiveXObject('Scripting.FileSystemObject');var filename=fso.GetAbsolutePathName(filespec);if(filename.slice(-2)==':\\'){return filename;}var path=fso.GetParentFolderName(filename);var name=fso.GetFileName(filename);var ns=(new ActiveXObject('Shell.Application')).Namespace(path);if(!ns){return null;}return ns.ParseName(name).Path;};FileSystem.GetShortPathName=function(filespec,fso){fso=fso||new ActiveXObject('Scripting.FileSystemObject');var filename=fso.GetAbsolutePathName(filespec);var getter;if(fso.FileExists(filename)){getter='GetFile';}else if(fso.FolderExists(filename)){getter='GetFolder';}else{return null;}return fso[getter](filename).ShortPath;};FileSystem.BrowseForFolder=function(Hwnd,sTitle,iOptions,vRootFolder){var shell=new ActiveXObject("Shell.Application");var folder=shell.BrowseForFolder(Hwnd,sTitle,iOptions,vRootFolder);if(folder==null){return null;}var e;var path=null;try{path=folder.ParentFolder.ParseName(folder.Title).Path;}catch(e){var colon=folder.Title.lastIndexOf(":");if(colon==-1){return null;}path=folder.Title.slice(colon-1,colon+1)+"\\";}return path;};FileSystem.BrowseForFolder.BIF_RETURNONLYFSDIRS=0x0001;FileSystem.BrowseForFolder.BIF_DONTGOBELOWDOMAIN=0x0002;FileSystem.BrowseForFolder.BIF_STATUSTEXT=0x0004;FileSystem.BrowseForFolder.BIF_RETURNFSANCESTORS=0x0008;FileSystem.BrowseForFolder.BIF_EDITBOX=0x0010;FileSystem.BrowseForFolder.BIF_VALIDATE=0x0020;FileSystem.BrowseForFolder.BIF_NEWDIALOGSTYLE=0x0040;FileSystem.BrowseForFolder.BIF_BROWSEINCLUDEURLS=0x0080;FileSystem.BrowseForFolder.BIF_USENEWUI=FileSystem.BrowseForFolder.BIF_EDITBOX|FileSystem.BrowseForFolder.BIF_NEWDIALOGSTYLE;FileSystem.BrowseForFolder.BIF_UAHINT=0x0100;FileSystem.BrowseForFolder.BIF_NONEWFOLDERBUTTON=0x0200;FileSystem.BrowseForFolder.BIF_NOTRANSLATETARGETS=0x0400;FileSystem.BrowseForFolder.BIF_BROWSEFORCOMPUTER=0x1000;FileSystem.BrowseForFolder.BIF_BROWSEFORPRINTER=0x2000;FileSystem.BrowseForFolder.BIF_BROWSEINCLUDEFILES=0x4000;FileSystem.BrowseForFolder.BIF_SHAREABLE=0x8000;FileSystem.BrowseForFolder.BSF_DESKTOP=0x00;FileSystem.BrowseForFolder.BSF_PROGRAMS=0x02;FileSystem.BrowseForFolder.BSF_CONTROLS=0x03;FileSystem.BrowseForFolder.BSF_PRINTERS=0x04;FileSystem.BrowseForFolder.BSF_PERSONAL=0x05;FileSystem.BrowseForFolder.BSF_FAVORITES=0x06;FileSystem.BrowseForFolder.BSF_STARTUP=0x07;FileSystem.BrowseForFolder.BSF_RECENT=0x08;FileSystem.BrowseForFolder.BSF_SENDTO=0x09;FileSystem.BrowseForFolder.BSF_BITBUCKET=0x0a;FileSystem.BrowseForFolder.BSF_STARTMENU=0x0b;FileSystem.BrowseForFolder.BSF_DESKTOPDIRECTORY=0x10;FileSystem.BrowseForFolder.BSF_DRIVES=0x11;FileSystem.BrowseForFolder.BSF_NETWORK=0x12;FileSystem.BrowseForFolder.BSF_NETHOOD=0x13;FileSystem.BrowseForFolder.BSF_FONTS=0x14;FileSystem.BrowseForFolder.BSF_TEMPLATES=0x15;FileSystem.BrowseForFolder.BSF_COMMONSTARTMENU=0x16;FileSystem.BrowseForFolder.BSF_COMMONPROGRAMS=0x17;FileSystem.BrowseForFolder.BSF_COMMONSTARTUP=0x18;FileSystem.BrowseForFolder.BSF_COMMONDESKTOPDIR=0x19;FileSystem.BrowseForFolder.BSF_APPDATA=0x1a;FileSystem.BrowseForFolder.BSF_PRINTHOOD=0x1b;FileSystem.BrowseForFolder.BSF_LOCALAPPDATA=0x1c;FileSystem.BrowseForFolder.BSF_ALTSTARTUP=0x1d;FileSystem.BrowseForFolder.BSF_COMMONALTSTARTUP=0x1e;FileSystem.BrowseForFolder.BSF_COMMONFAVORITES=0x1f;FileSystem.BrowseForFolder.BSF_INTERNETCACHE=0x20;FileSystem.BrowseForFolder.BSF_COOKIES=0x21;FileSystem.BrowseForFolder.BSF_HISTORY=0x22;FileSystem.BrowseForFolder.BSF_COMMONAPPDATA=0x23;FileSystem.BrowseForFolder.BSF_WINDOWS=0x24;FileSystem.BrowseForFolder.BSF_SYSTEM=0x25;FileSystem.BrowseForFolder.BSF_PROGRAMFILES=0x26;FileSystem.BrowseForFolder.BSF_MYPICTURES=0x27;FileSystem.BrowseForFolder.BSF_PROFILE=0x28;FileSystem.BrowseForFolder.BSF_SYSTEMx86=0x29;FileSystem.BrowseForFolder.BSF_PROGRAMFILESx86=0x30;

//js/String.js

if(!String.prototype.repeat){String.prototype.repeat=function(n){n=Math.max(n||0,0);return new Array(n+1).join(this.valueOf());};}if(!String.prototype.startsWith){String.prototype.startsWith=function(searchString,position){position=Math.max(position||0,0);return this.indexOf(searchString)==position;};}if(!String.prototype.endsWith){String.prototype.endsWith=function(searchString,endPosition){endPosition=Math.max(endPosition||0,0);var s=String(searchString);var pos=this.lastIndexOf(s);return pos>=0&&pos==this.length-s.length-endPosition;};}if(!String.prototype.contains){String.prototype.contains=function(searchString,position){position=Math.max(position||0,0);return this.indexOf(searchString)!=-1;};}if(!String.prototype.toArray){String.prototype.toArray=function(){return this.split('');};}if(!String.prototype.reverse){String.prototype.reverse=function(){return this.split('').reverse().join('');};}String.validBrackets=function(br){if(!br){return false;}var quot="''\"\"`'``";var sgl="<>{}[]()%%||//\\\\";var dbl="/**/<??><%%>(**)";return(br.length==2&&(quot+sgl).indexOf(br)!=-1)||(br.length==4&&dbl.indexOf(br)!=-1);};String.prototype.brace=String.prototype.bracketize=function(br){var string=this;if(!String.validBrackets(br)){return string;}var midPos=br.length/2;return br.substr(0,midPos)+string.toString()+br.substr(midPos);};String.prototype.unbrace=String.prototype.unbracketize=function(br){var string=this;if(!br){var len=string.length;for(var i=2;i>=1;i--){br=string.substring(0,i)+string.substring(len-i);if(String.validBrackets(br)){return string.substring(i,len-i);}}}if(!String.validBrackets(br)){return string;}var midPos=br.length/2;var i=string.indexOf(br.substr(0,midPos));var j=string.lastIndexOf(br.substr(midPos));if(i==0&&j==string.length-midPos){string=string.substring(i+midPos,j);}return string;};Number.prototype.radix=function(r,n,c){return this.toString(r).padding(-n,c);};Number.prototype.bin=function(n,c){return this.radix(0x02,n,c);};Number.prototype.oct=function(n,c){return this.radix(0x08,n,c);};Number.prototype.dec=function(n,c){return this.radix(0x0A,n,c);};Number.prototype.hexl=function(n,c){return this.radix(0x10,n,c);};Number.prototype.hex=function(n,c){return this.radix(0x10,n,c).toUpperCase();};Number.prototype.human=function(digits,binary){var n=Math.abs(this);var p=this;var s='';var divs=arguments.callee.add(binary);for(var i=divs.length-1;i>=0;i--){if(n>=divs[i].d){p/=divs[i].d;s=divs[i].s;break;}}return p.toFixed(digits)+s;};Number.prototype.human.add=function(binary,suffix,divisor){var name=binary?'div2':'div10';var divs=Number.prototype.human[name]=Number.prototype.human[name]||[];if(arguments.length<3){return divs;}divs.push({s:suffix,d:Math.abs(divisor)});divs.sort(function(a,b){return a.d-b.d;});return divs;};Number.prototype.human.add(true,'K',1<<10);Number.prototype.human.add(true,'M',1<<20);Number.prototype.human.add(true,'G',1<<30);Number.prototype.human.add(true,'T',Math.pow(2,40));Number.prototype.human.add(false,'K',1e3);Number.prototype.human.add(false,'M',1e6);Number.prototype.human.add(false,'G',1e9);Number.prototype.human.add(false,'T',1e12);Number.fromHuman=function(value,binary){var m=String(value).match(/^([\-\+]?\d+\.?\d*)([A-Z])?$/);if(!m){return Number.NaN;}if(!m[2]){return+m[1];}var divs=Number.prototype.human.add(binary);for(var i=0;i<divs.length;i++){if(divs[i].s==m[2]){return m[1]*divs[i].d;}}return Number.NaN;};if(!String.prototype.trim){String.prototype.trim=function(){return this.replace(/(^\s*)|(\s*$)/g,"");};}if(!String.prototype.trimLeft){String.prototype.trimLeft=function(){return this.replace(/(^\s*)/,"");};}if(!String.prototype.trimRight){String.prototype.trimRight=function(){return this.replace(/(\s*$)/g,"");};}String.prototype.dup=function(){var val=this.valueOf();return val+val;};String.prototype.padding=function(n,c){var val=this.valueOf();if(Math.abs(n)<=val.length){return val;}var m=Math.max((Math.abs(n)-this.length)||0,0);var pad=Array(m+1).join(String(c||' ').charAt(0));return(n<0)?pad+val:val+pad;};String.prototype.padLeft=function(n,c){return this.padding(-Math.abs(n),c);};String.prototype.alignRight=String.prototype.padLeft;String.prototype.padRight=function(n,c){return this.padding(Math.abs(n),c);};String.prototype.format=function(){var args=arguments;return this.replace(/\{(\d+)\}/g,function($0,$1){return args[$1]!==void 0?args[$1]:$0;});};String.prototype.alignLeft=String.prototype.padRight;String.prototype.sprintf=function(){var args=arguments;var index=0;var x;var ins;var fn;return this.replace(String.prototype.sprintf.re,function(){if(arguments[0]=="%%"){return"%";}x=[];for(var i=0;i<arguments.length;i++){x[i]=arguments[i]||'';}x[3]=x[3].slice(-1)||' ';ins=args[+x[1]?x[1]-1:index++];return String.prototype.sprintf[x[6]](ins,x);});};String.prototype.sprintf.re=/%%|%(?:(\d+)[\$#])?([+-])?('.|0| )?(\d*)(?:\.(\d+))?([bcdfosuxXhH])/g;String.prototype.sprintf.b=function(ins,x){return Number(ins).bin(x[2]+x[4],x[3]);};String.prototype.sprintf.c=function(ins,x){return String.fromCharCode(ins).padding(x[2]+x[4],x[3]);};String.prototype.sprintf.d=String.prototype.sprintf.u=function(ins,x){return Number(ins).dec(x[2]+x[4],x[3]);};String.prototype.sprintf.f=function(ins,x){var ins=Number(ins);if(x[5]){ins=ins.toFixed(x[5]);}else if(x[4]){ins=ins.toExponential(x[4]);}else{ins=ins.toExponential();}x[2]=x[2]=="-"?"+":"-";return ins.padding(x[2]+x[4],x[3]);};String.prototype.sprintf.o=function(ins,x){return Number(ins).oct(x[2]+x[4],x[3]);};String.prototype.sprintf.s=function(ins,x){return String(ins).padding(x[2]+x[4],x[3]);};String.prototype.sprintf.x=function(ins,x){return Number(ins).hexl(x[2]+x[4],x[3]);};String.prototype.sprintf.X=function(ins,x){return Number(ins).hex(x[2]+x[4],x[3]);};String.prototype.sprintf.h=function(ins,x){var ins=String.prototype.replace.call(ins,/,/g,'');x[2]=x[2]=="-"?"+":"-";return Number(ins).human(x[5],true).padding(x[2]+x[4],x[3]);};String.prototype.sprintf.H=function(ins,x){var ins=String.prototype.replace.call(ins,/,/g,'');x[2]=x[2]=="-"?"+":"-";return Number(ins).human(x[5],false).padding(x[2]+x[4],x[3]);};String.prototype.compile=function(){var args=arguments;var index=0;var x;var ins;var fn;var result=this.replace(/(\\|")/g,'\\$1').replace(String.prototype.sprintf.re,function(){if(arguments[0]=="%%"){return"%";}arguments.length=7;x=[];for(var i=0;i<arguments.length;i++){x[i]=arguments[i]||'';}x[3]=x[3].slice(-1)||' ';ins=x[1]?x[1]-1:index++;return'", String.prototype.sprintf.'+x[6]+'(arguments['+ins+'], ["'+x.join('", "')+'"]), "';});return Function('','return ["'+result+'"].join("")');};String.prototype.parseUrl=function(){var matches=this.match(arguments.callee.re);if(!matches){return null;}var result={'scheme':matches[1]||'','subscheme':matches[2]||'','user':matches[3]||'','pass':matches[4]||'','host':matches[5],'port':matches[6]||'','path':matches[7]||'','query':matches[8]||'','fragment':matches[9]||''};return result;};String.prototype.parseUrl.re=/^(?:([a-z]+):(?:([a-z]*):)?\/\/)?(?:([^:@]*)(?::([^:@]*))?@)?((?:[a-z0-9_-]+\.)+[a-z]{2,}|localhost|(?:(?:[01]?\d\d?|2[0-4]\d|25[0-5])\.){3}(?:(?:[01]?\d\d?|2[0-4]\d|25[0-5])))(?::(\d+))?(?:([^:\?\#]+))?(?:\?([^\#]+))?(?:\#([^\s]+))?$/i;String.prototype.camelize=function(){return this.replace(/([^-]+)|(?:-(.)([^-]+))/mg,function($0,$1,$2,$3){return($2||'').toUpperCase()+($3||$1).toLowerCase();});};String.prototype.uncamelize=function(){return this.replace(/[A-Z]/g,function($0){return'-'+$0.toLowerCase();});};

//js/Array.js

if(!Array.isArray){Array.isArray=function(object){return Object.prototype.toString.call(object)==='[object Array]';};}if(!Array.prototype.every){Array.prototype.every=function(fun,thisp){if(typeof fun!="function"){throw new TypeError();}var len=this.length;for(var i=0;i<len;i++){if(i in this&&!fun.call(thisp,this[i],i,this)){return false;}}return true;};}if(!Array.prototype.filter){Array.prototype.filter=function(fun,thisp){if(typeof fun!="function"){throw new TypeError();}var len=this.length;var res=new Array();for(var i=0;i<len;i++){if(i in this){var val=this[i];if(fun.call(thisp,val,i,this)){res.push(val);}}}return res;};}if(!Array.prototype.forEach){Array.prototype.forEach=function(fun,thisp){if(typeof fun!="function"){throw new TypeError();}var len=this.length;for(var i=0;i<len;i++){if(i in this){fun.call(thisp,this[i],i,this);}}};}if(!Array.prototype.indexOf){Array.prototype.indexOf=function(elt){var len=this.length;var from=Number(arguments[1])||0;from=(from<0)?Math.ceil(from):Math.floor(from);if(from<0){from+=len;}for(;from<len;from++){if(from in this&&this[from]===elt){return from;}}return-1;};}if(!Array.prototype.lastIndexOf){Array.prototype.lastIndexOf=function(elt){var len=this.length;var from=Number(arguments[1]);if(isNaN(from)){from=len-1;}else{from=(from<0)?Math.ceil(from):Math.floor(from);if(from<0){from+=len;}else if(from>=len){from=len-1;}}for(;from>-1;from--){if(from in this&&this[from]===elt){return from;}}return-1;};}if(!Array.prototype.map){Array.prototype.map=function(fun,thisp){if(typeof fun!="function"){throw new TypeError();}var len=this.length;var res=new Array(len);for(var i=0;i<len;i++){if(i in this){res[i]=fun.call(thisp,this[i],i,this);}}return res;};}if(!Array.prototype.reduce){Array.prototype.reduce=function(fun){if(typeof fun!="function"){throw new TypeError();}var len=this.length;if(len==0&&arguments.length==1){throw new TypeError();}var i=0;if(arguments.length>=2){var rv=arguments[1];}else{do{if(i in this){rv=this[i++];break;}if(++i<0){throw new TypeError();}}while(true);}for(;i<len;i++){if(i in this){rv=fun.call(null,rv,this[i],i,this);}}return rv;};}if(!Array.prototype.reduceRight){Array.prototype.reduceRight=function(fun){if(typeof fun!="function"){throw new TypeError();}var len=this.length;if(len==0&&arguments.length==1){throw new TypeError();}var i=len-1;if(arguments.length>=2){var rv=arguments[1];}else{do{if(i in this){rv=this[i--];break;}if(--i<0){throw new TypeError();}}while(true);}for(;i>=0;i--){if(i in this){rv=fun.call(null,rv,this[i],i,this);}}return rv;};}if(!Array.prototype.some){Array.prototype.some=function(fun,thisp){if(typeof fun!="function"){throw new TypeError();}var len=this.length;for(var i=0;i<len;i++){if(i in this&&fun.call(thisp,this[i],i,this)){return true;}}return false;};}Array.prototype.flatten=function(){var result=[];var len=this.length;for(var i=0;i<len;i++){var value=this[i];if(!value||this[i].constructor!=Array){value=[value];}result=result.concat(value);}return result;};Array.prototype.grep=function(filter,thisp){if('string'==typeof filter){filter=new RegExp(filter);}return this.filter(function(v,k){return filter.test(v);},thisp);};Array.prototype.shuffle=function(){return this.sort(function(){return Math.random()-0.5;});};Array.prototype.union=function(list,callback){if(!callback){callback=function(value1,value2){return value1!=value2;};}var result=this;var L=result.length;var j;SEARCH_UNIQUE:for(var i=0;i<list.length;i++){j=0;while(j<L){if(!callback(result[j],list[i])){continue SEARCH_UNIQUE;}j++;}result[L]=list[i];L++;}return result;};Array.prototype.unique=function(fun,thisp){fun=fun||function(value,index,orig,result){return result.indexOf(value)==-1;};var result=[];for(var i=0;i<this.length;i++){if(i in this){var v=this[i];if(fun.call(thisp,v,i,this,result)){result.push(v);}}}return result;};Array.prototype.invoke=function(method){var args=[].slice.call(arguments,1);var result=this.map(function(v){return v[method].apply(v,args);});return result;};Array.prototype.fetch=function(property){var result=this.map(function(v){return v[property];});return result;};Array.prototype.binarySearch=function(searchItem,compare,right){if(searchItem===undefined||searchItem===null){return null;}if(!compare){compare=function(a,b){return(String(a)==String(b))?0:(String(a)<String(b))?-1:+1;};}var found=false;var l=0;var u=this.length-1;var ml,mu;while(l<=u){var m=parseInt((l+u)/2);switch(compare(this[m],searchItem)){case-1:ml=m;l=m+1;break;case+1:mu=m;u=m-1;break;default:found=true;if(right){l=m+1;}else{u=m-1;}}}if(!found){this.insertIndex=(ml+1)||mu||0;return-1;}return(right)?u:l;};Array.prototype.binaryIndexOf=function(searchItem,compare){return this.binarySearch(searchItem,compare,false);};Array.prototype.binaryLastIndexOf=function(searchItem,compare){return this.binarySearch(searchItem,compare,true);};Array.linearize=function(object){if(!object||!object.length){return[];}var result=new Array(object.length);for(var i=0;i<object.length;i++){result[i]=object[i];}return result;};Array.range=function(){if(typeof arguments[2]=='function'){var n=Number(arguments[0]);if(isNaN(n)||n<=0){return[];}var a=arguments[1];var func=arguments[2];var result=arguments[3]&&a&&a.constructor==Array?a:[a];for(var i=result.length-1;i<n-1;i++){result.push(func(i,result));}return result;}var step=Number(arguments[2])||1;var start;var stop;if(undefined!==arguments[0]&&undefined!==arguments[1]){start=Number(arguments[0]);stop=Number(arguments[1]);}else{start=0;stop=Number(arguments[0])-step;}if(undefined===start||undefined===stop||undefined===step||(start>stop&&step>0)||(start<stop&&step<0)){return[];}var result=[];var i=start;if(start>stop){while(i>=stop){result[result.length]=i;i+=step;}}else{while(i<=stop){result[result.length]=i;i+=step;}}return result;};

//js/Object.js

Object.isa=function(value,id){return value!==(void 0)&&value!==null&&Object.prototype.toString.call(value)==id;};Object.isArray=function(value){return Object.isa(value,'[object Array]');};Object.isBoolean=function(value){return Object.isa(value,'[object Boolean]');};Object.isEmpty=function(value){return!Boolean(value);};Object.isFunction=function(value){return Object.isa(value,'[object Function]');};Object.isIndefinite=function(value){return Object.isUndefined(value)||Object.isNull(value);};Object.isNull=function(value){return value===null;};Object.isNumber=function(value){return Object.isa(value,'[object Number]');};Object.isObject=function(value){return Object.isa(value,'[object Object]');};Object.isRegExp=function(value){return Object.isa(value,'[object RegExp]');};Object.isString=function(value){return Object.isa(value,'[object String]');};Object.isUndefined=function(value){return value===void 0;};Object.forIn=function(object,fun,func,thisp){if(typeof fun!="function"){throw new TypeError();}for(var p in object){if(!object.hasOwnProperty(p)){continue;}if('function'==typeof object[p]&&!func){continue;}fun.call(thisp,object[p],p,object);}};if(typeof Object.getPrototypeOf!='function'){if(typeof'test'.__proto__=='object'){Object.getPrototypeOf=function(object){return object.__proto__;};}else{Object.getPrototypeOf=function(object){return object.constructor.prototype;};}}(function(){if(Object.keys){return;}var hasOwnProperty=Object.prototype.hasOwnProperty;var hasDontEnumBug=!({toString:null}).propertyIsEnumerable('toString');var dontEnums=['toString','toLocaleString','valueOf','hasOwnProperty','isPrototypeOf','propertyIsEnumerable','constructor'];var dontEnumsLength=dontEnums.length;Object.keys=function(obj){if(typeof obj!=='object'&&typeof obj!=='function'||obj===null){throw new TypeError('Object.keys called on non-object');}var result=[];for(var prop in obj){if(!hasOwnProperty.call(obj,prop)){continue;}result.push(prop);}if(hasDontEnumBug){for(var i=0;i<dontEnumsLength;i++){if(!hasOwnProperty.call(obj,dontEnums[i])){continue;}result.push(dontEnums[i]);}}return result;};})();if(!Object.create){Object.create=function(proto){var F=function(){};F.prototype=proto;return new F();};}Object.mixin=function(dst,src,func){func=func||function(dst,src,prop){dst[prop]=src[prop];};var props=Object.keys(src);for(var i=0;i<props.length;i++){var prop=props[i];if(!src.hasOwnProperty(prop)){continue;}func(dst,src,prop);}return dst;};(function(){var _wrapParent=function(parentMethod,method){return function(){var parent=this.parent;this.parent=parentMethod;var result=method.apply(this,arguments);this.parent=parent;return result;};};var _wrapParentProto=function(dst,src,prop){if(typeof dst[prop]!='function'||typeof src[prop]!='function'){dst[prop]=src[prop];return;}dst[prop]=_wrapParent(dst[prop],src[prop]);};var _instanceOf=function(Class){return this instanceof Class;};Object.extend=function(Parent,proto){if(arguments.length<2){proto=arguments[0];Parent=null;}Parent=Parent||Object;proto=proto||{};if(typeof proto=='function'){proto=proto();}delete proto.parent;delete proto.instanceOf;var child_proto=Object.create(Parent.prototype);Object.mixin(child_proto,proto,_wrapParentProto);if(!proto.hasOwnProperty('constructor')){child_proto.constructor=function(){Parent.apply(this,arguments);};}child_proto.instanceOf=_instanceOf;var child=child_proto.constructor;child.prototype=child_proto;child.superclass=Parent.prototype;return child;};})();Object.privatize=function(getter){getter=getter||'_private';var buffer;var id=0;var privatize=function(object){object[getter][id]();var data=buffer;buffer=null;return data;};privatize.create=function(object,data){data=Object(data);object[getter]=object[getter]||{};while(object[getter].hasOwnProperty(id)){id++;}object[getter][id]=function(){buffer=data;};};return privatize;};var Class=(function(){var _wrapParent=function(parentMethod,method){return function(){var parent=this.parent;this.parent=parentMethod;var result=method.apply(this,arguments);this.parent=parent;return result;};};var _wrapParentClass=function(dst,src,prop){if(typeof dst[prop]!='function'||typeof src[prop]!='function'){dst[prop]=src[prop];return;}src[prop]=dst[prop]=_wrapParent(dst[prop],src[prop]);};var F=function(){};var Class=function(Parent,proto){if(arguments.length<2){proto=arguments[0];Parent=null;}Parent=Parent||Object;proto=proto||{};if(typeof proto!='function'){proto=(function(proto){return function(){return proto;};})(proto);}var _instanceOf=function(Class){var p=Child;while(p){if(p===Class){return true;}p=p.Parent;}return false;};var Child=function(){var object=proto();delete object.parent;delete object.instanceOf;var parent=Object(Parent.call(new F()));Object.mixin(this,parent);Object.mixin(this,object,_wrapParentClass);this.instanceOf=_instanceOf;if(this instanceof F){return this;}object.constructor.apply(this,arguments);};Child.Parent=Parent;return Child;};return Class;})();(function(that){Object.ns=function(namespace,value){var parts=namespace.split('.');var name=parts.pop();var len=parts.length;var root=this===Object?that:this;for(var i=0;i<len;i++){var p=parts[i];root=root[p]=root[p]||{};}if(arguments.length<2){return root.hasOwnProperty(name);}return root[name]=value;};})(this);Object.clone=function(object){if(!object||typeof object!='object'){return object;}if(object.nodeType&&typeof object.cloneNode=='function'){return object.cloneNode(true);}if(typeof object.clone=='function'){return object.clone();}if(object instanceof RegExp){return eval(''+object);}var innerObjects=[Date,Boolean,Number,String];for(var i=0;i<innerObjects.length;i++){if(object.constructor==innerObjects[i]){return new innerObjects[i](object.valueOf());}}if(!object.constructor||typeof ActiveXObject=='function'&&object instanceof ActiveXObject){throw new ReferenceError();}var clone=new object.constructor();for(var p in object){clone[p]=object[p]===object?clone:Object.clone(object[p]);}return clone;};(function(){var entities={'&':'&amp;','"':'&quot;','<':'&lt;','>':'&gt;'};var escaped=/[\x00-\x1F\"\\]/g;var special={'"':'\\"','\r':'\\r','\n':'\\n','\t':'\\t','\b':'\\b','\f':'\\f','\\':'\\\\'};var space;var indent='';var deep;var proto;var func;function _quote(value){var result=value.replace(escaped,function($0){return special[$0]||$0;});return'"'+result+'"';};function _dump(object){switch(typeof object){case'string':return _quote(object);case'boolean':case'number':case'undefined':case'null':return String(object);case'function':if(func==1){return'[Function]';}if(func>1){return object.toString();}return'';case'object':if(object===null){return String(object);}if(!object.constructor){return'[Object]';}var t=Object.prototype.toString.call(object);if(t=='[object RegExp]'){return String(object);}if(t=='[object Date]'){return object.toUTCString();}if(!deep){return'[...]';}var saveDeep=deep;deep--;var saveIndent=indent;indent+=space;var result=[];for(var k in object){if(!object.hasOwnProperty(k)&&!proto){continue;}var v;if(object[k]===object){v='[Recursive]';}else{v=_dump(object[k]);if(v===''){continue;}}result.push(k+': '+v);}var pred;var post;if(t=='[object Array]'){pred='Array('+object.length+') [';post=']';}else{pred='Object {';post='}';}result=result.length==0?'\n'+saveIndent:'\n'+indent+result.join('\n'+indent)+'\n'+saveIndent;indent=saveIndent;deep=saveDeep;return pred+result+post;default:return'[Unknown]';}};Object.dump=function(object,options){var $=Object.dump.$||{};options=options||{};space=options.space||$.space;var t=Object.prototype.toString.call(space);if(t=='[object Number]'&&space>=0){space=new Array(space+1).join(' ');}else if(t!='[object String]'){space='    ';}deep=Number(options.deep)>0?options.deep:Number($.deep)>0?$.deep:5;proto=options.proto||$.proto||0;func=options.func||$.func||0;return _dump(object);};Object.dump.$={};})();

//js/win32/Enumerator.js

Enumerator.forEach=function(collection,fun,thisp){if(typeof fun!="function"){throw new TypeError();}var fc=new Enumerator(collection);for(;!fc.atEnd();fc.moveNext()){var i=fc.item();fun.call(thisp,i,collection,fc);}};Enumerator.map=function(collection,fun,thisp){if(typeof fun!="function"){throw new TypeError();}var result=[];var fc=new Enumerator(collection);for(;!fc.atEnd();fc.moveNext()){var i=fc.item();var j=fun.call(thisp,i,collection,fc);result.push(j);}return result;};Enumerator.toArray=function(collection){var result=[];var fc=new Enumerator(collection);for(;!fc.atEnd();fc.moveNext()){var i=fc.item();result.push(i);}return result;};


///////////////////////////////////////////////////////////////////////////

function alert(msg)
{
	WScript.Echo(msg);
};

function quit(code)
{
	WScript.Quit(code);
};

function help()
{
	var msg = [
'doc2html and more', 
'Copyright (C) 2004, 2009, 2010, 2012, 2016 Ildar Shaimordanov', 
'', 
'This tool allows to convert any DOC or DOCX file to several different ', 
'formats such as plain text TXT (both DOS, Win, etc), or reach text RTF, or ', 
'hyper-text HTML (default), MHT (web archive), XML, or PDF, or XPS. ', 
'', 
'Using doc2fb.xsl file it is possible to convert to FictionBook format (FB2). ', 
'', 
'There are options:', 
'', 
'/H', 
'    Outputs this help page.', 
'', 
'/F:format', 
'    Specifies output format as TXT, RTF, HTML, MHT, XML, PDF or XPS. ', 
'    Additionally FB2 stands for transformations to FictionBook format. ', 
'', 
'/E:encoding', 
'    A numeric value of the encoding to be used when saving as a plain text ', 
'    file. This option is significant with /F:TXT only. Refer to your ', 
'    system locales to learn which encodings ar available there. ', 
'', 
'    The Russian or Ukrainian users can refer to the list below: ', 
'    866   - DOS', 
'    28595 - ISO', 
'    20866 - KOI8-R', 
'    21866 - KOI8-U', 
'    10007 - Mac', 
'    1251  - Win', 
'', 
'/L:lineending', 
'    The option specifies characters to be used as line ending. There are ', 
'    four available values - CRLF, CR, LF, or LFCR. The default value is ', 
'    CRLF. This option is significant with /F:TXT only. ', 
'', 
'/XSL:filename', 
'    The option specifies a name of a XSLT file for transformations to FictionBook format. ', 
'', 
'/V', 
'    Turn on verbosity.', 
'', 
'/FG', 
'    Specify this if you want to launch WINWORD in foreground.', 
].join('\n');
	alert(msg);
};

if ( WScript.Arguments.length < 1 || WScript.Arguments.Named.Exists('H') ) {
	help();
	quit();
}

var verbose = false;

function warn(text)
{
	if ( ! arguments.callee.verbose ) {
		return;
	}
	var now = new Date();
	var date = "%04d/%02d/%02d %02d:%02d:%02d.%03d ".sprintf(
			now.getFullYear(),
			now.getMonth(),
			now.getDay(),
			now.getHours(),
			now.getMinutes(),
			now.getSeconds(),
			now.getMilliseconds());

	alert(date + text);
};

// Verbosely ?
warn.verbose = WScript.FullName.match(/cscript\.exe$/i) && WScript.Arguments.Named.Exists('V');

var formats = {
	'txt':	2,
	'dos':	4,
	'rtf':	6,
	'html':	8,
	'mht':	9,
	'xml':	11,
	'fb2':	11,
	'pdf':	17,
	'xps':	18};

var lineEndings = {
	'crlf':	0, 
	'cr':	1, 
	'lf':	2, 
	'lfcr':	3};

var xslName = WScript.ScriptFullName.replace(/[^\\]+$/, '') + 'doc2fb.xsl';
var xslFile;

var fileFormat = 'html';
var fileEncoding = 0;
var fileLineEnding = -1;
var word;

var e;
try {

	// Creating of 'Send To' context menu
	if ( WScript.Arguments.Named.Exists('help') && WScript.Arguments.Named.item('help').toLowerCase() == 'sendto' ) {

		var wshShell = new ActiveXObject('WScript.Shell');

		var sendTo = wshShell.SpecialFolders('SendTo');
		var folder = sendTo + '\\doc2xxx';

		warn('Creating of the folder "' + folder + '"');
		try {
			fso.CreateFolder(folder);
		} catch (e) {
			warn('The folder already exists');
		}

		Object.forIn(formats, function(value, key)
		{
			warn('Creating of the shortcut for "' + key + '" format');

			var lnk;
			lnk = wshShell.CreateShortcut(folder + '\\doc2' + key + '.lnk');
			lnk.TargetPath = WScript.ScriptFullName;
			lnk.Arguments = '/f:' + key;
			lnk.Description = 'Convert .DOC to .' + key.toUpperCase();
			lnk.Save();
		}, true);

		warn('Done');
		quit();

	}

	warn('Validate formatting parameters');
	var arg;

	// /F:format
	if ( WScript.Arguments.Named.Exists('F') ) {
		arg = WScript.Arguments.Named.item('F');
		fileFormat = (arg || '').toLowerCase();
		if ( isNaN(formats[fileFormat]) ) {
			throw new Error('Unknown output format: "' + arg + '"');
		}
	}

	// /F:TXT /E:Encoding
	if ( fileFormat == 'txt' && WScript.Arguments.Named.Exists('E') ) {
		arg = WScript.Arguments.Named.item('E');
		fileEncoding = Number(arg);
		if ( isNaN(fileEncoding) || fileEncoding <= 0 ) {
			throw new Error('Illegal encoding value: "' + arg + '"');
		}
	}

	// /F:TXT /L:lineending
	if ( fileFormat == 'txt' && WScript.Arguments.Named.Exists('L') ) {
		arg = WScript.Arguments.Named.item('L');
		fileLineEnding = Number(lineEndings[(arg || '').toLowerCase()]);
		if ( isNaN(fileLineEnding) ) {
			throw new Error('Illegal line ending: "' + arg + '"');
		}
	}

	// /F:FB2 /XSL:filename
	if ( fileFormat == 'fb2' ) {
		if ( WScript.Arguments.Named.Exists('XSL') ) {
			xslName = WScript.Arguments.Named.item('XSL');
		}

		var fso = new ActiveXObject("Scripting.FileSystemObject");
		try {
			var xslFile = fso.GetFile(xslName);
		} catch (e) {
			fileFormat = 'xml';
			alert(xslName + ' not found.');
		}
	}

	// Process file list
	warn('Processing arguments');
	var filelist = Enumerator.map(WScript.Arguments.Unnamed, function(i, fc)
	{
		return FileSystem.glob(i);
	}).flatten();

	if ( filelist.length < 1 ) {
		throw new Error('Empty file list');
	}

	warn('Files to be processed:\n\t' + filelist.join('\n\t'));

	// Launch the WINWORD application and start a file converting loop
	warn('WINWORD is starting');
	var word = new ActiveXObject("Word.Application");

	if ( WScript.Arguments.Named.Exists('fg') ) {
		warn('Activating and displaying of the WINWORD in foreground');
		word.Visible = true;
		word.Activate();
	}

	filelist.forEach(function(filename)
	{
		var docfile = String(filename);
		var newfile = docfile.replace(/\.[^\.]+$/, '.' + fileFormat);

		warn('Open "' + docfile + '"');
		var doc = word.Documents.Open(docfile);

		if ( fileFormat == 'fb2' ) {
//?			doc.XMLSaveDataOnly = false;
			doc.XMLUseXSLTWhenSaving = true;
			doc.XMLSaveThroughXSLT = '' + xslFile;
//?			doc.XMLHideNamespaces = true;
			doc.XMLShowAdvancedErrors = true;
			doc.XMLSchemaReferences.HideValidationErrors = false;
//?			doc.XMLSchemaReferences.AutomaticValidation = true;
			doc.XMLSchemaReferences.IgnoreMixedContent = false;
//?			doc.XMLSchemaReferences.AllowSaveAsXMLWithoutValidation = true;
			doc.XMLSchemaReferences.ShowPlaceholderText = false;
		}

		warn('Save as "' + newfile + '"');
		doc.SaveAs(
			// FileName
			newfile, 
			// FileFormat
			formats[fileFormat], 
			// LockComments
			false, 
			// Password
			'', 
			// AddToRecentFiles
			false, 
			// Write Password
			'', 
			// ReadOnlyRecommended
			false, 
			// EmbedTrueTypeFonts
			false, 
			// SaveNativePictureFormat
			false, 
			// SaveFormsData
			false, 
			// SaveAsAOCELetter
			false, 
			// Encoding
			fileEncoding, 
			// InsertLineBreaks
			fileLineEnding > -1, 
			// AllowSubstitutions
			false, 
			// LineEnding
			fileLineEnding);

		warn('Close this document');
		doc.Close();
	});

} catch (e) {

	alert('Error encountered: ' 
//		+ '[' 
//		+ (e.number >> 0x10) 
//		+ ':' 
//		+ (e.number & 0xFFFF) 
//		+ '] - ' 
		+ e.description);

} finally {

	if ( word ) {
		warn('WINWORD is closing');
		word.Quit();
		WScript.Sleep(500);
		warn('Done');
	}

}

