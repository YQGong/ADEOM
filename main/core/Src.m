BeginPackage["core`Src`"];

(*dependencies of this module*)
`Private`dependence={"core`Utils`","core`Debug`"};

$ContextPath=Join[$ContextPath,`Private`dependence];

(*enter code here*)
loadSrc::usage = "loadSrc[]";
src::usage = "src[]";
srcList::usage = "srcList[]";
loadSrc[dir_String,pattern_String:"*.m"]:=(
  srcList = FileNames[pattern, dir, Infinity];
  SetSharedFunction[src];
  Do[src[i] = ReadString[i], {i, srcList}];
  debug["loaded src : \n",StringRiffle[srcList,"\n"],{"msg",7}];
);

getSrc::usage = "getSrc[]";
getSrc[name__] := With[{
  path = FileNameJoin[{Global`$PackageDir, name}]},
  debug["importing src : ",path,{"msg",7}];
  If[Head[src[path]]===String, src[path],
    debug[path <> " not loaded !", 0];]];

import::usage = "import[]";
import[names__]:=With[
  {src=getSrc[names]},
  ImportString[src]
];

importFreeze::usage = "importFreeze[]";
importFreeze[names__]:=With[
  {src=getSrc[names]},
  freeze[$ContextPath,ImportString[src]]
];

loadDependencies::usage = "loadDependencies[]";
loadDependencies[deps_List]:=Do[
  If[ToExpression[dep<>"Private`isLoaded"]=!=True,
    With[{path=Prepend[StringSplit[StringReplacePart[dep,".m",{-1,-1}],"`"],"main"]},
      debug["importing "<>$Context<>" 's dependency : ",dep,{"msg",7}];
      import[Sequence@@path];];,
    debug[$Context<>" 's dependency ",dep,"is already loaded.",{"msg",7}];
    AppendTo[$ContextPath,dep]];
  ,{dep,deps}];

(*local variables to be removed*)
Remove/@{dir,i,name,names,path,pattern,dep,deps};

`Private`isLoaded=True;
EndPackage[];