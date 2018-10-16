BeginPackage["core`Src`"];

(*dependencies of this module*)
`Private`dependence={"core`Utils`","core`Debug`"};

$ContextPath=Join[$ContextPath,`Private`dependence];

`Private`addLineNumber[name_][line_, {num_}] :=
    StringReplace[line,
      "debug[" -> "debug[\"file: " <> name <> ", line: " <> ToString@num<>", \","];

addLineNumberHook::usage = "addLineNumberHook[]";
addLineNumberHook[src_, names_] := Module[{filename},
  filename = StringRiffle[names, "/"];
  debugset[filename, {"core", 9}];
  StringRiffle[
    MapIndexed[`Private`addLineNumber[filename],
      StringSplit[src, "\n"]], "\n"]];

(*enter code here*)
loadSrc::usage = "loadSrc[]";
src::usage = "src[]";
srcList::usage = "srcList[]";
loadSrc[dir_String,pattern_String:"*.m"]:=(
  srcList = FileNames[pattern, dir, Infinity];
  SetSharedFunction[src];
  Do[src[i] = ReadString[i], {i, srcList}];
  debug["loaded src : \n",StringRiffle[srcList,"\n"],{"core",7}];
);

getSrc::usage = "getSrc[]";
getSrc[name__] := With[{
  path = FileNameJoin[{Global`$PackageDir, name}]},
  debug["importing src : ",path,{"core",7}];
  If[Head[src[path]]===String, src[path],
    debug[path <> " not loaded !", 0];]];


importHook::usage = "importHook[]";
If[ToString[Definition[importHook]] === "Null",
  debug["default importHook is set to addLineNumberHook",{"core",5}];
  importHook=addLineNumberHook];


import::usage = "import[]";
import[names__]:=Module[
  {rawSrc=getSrc[names],src},
  src=importHook[rawSrc,{names}];
  ImportString[src]
];

importFreeze::usage = "importFreeze[]";
importFreeze[names__]:=Module[
  {rawSrc=getSrc[names],src},
  src=importHook[rawSrc,{names}];
  freeze[$ContextPath,ImportString[src]]
];

loadDependencies::usage = "loadDependencies[]";
loadDependencies[deps_List]:=Do[
  If[ToExpression[dep<>"Private`isLoaded"]=!=True,
    With[{path=Prepend[StringSplit[StringReplacePart[dep,".m",{-1,-1}],"`"],"main"]},
      debug["importing "<>$Context<>" 's dependency : ",dep,{"core",7}];
      import[Sequence@@path];];,
    debug[$Context<>" 's dependency ",dep,"is already loaded.",{"core",7}];
    AppendTo[$ContextPath,dep]];
  ,{dep,deps}];

(*local variables to be removed*)
Remove/@{dir,i,name,names,path,pattern,dep,deps,filename,line,num,rawSrc};

`Private`isLoaded=True;
EndPackage[];