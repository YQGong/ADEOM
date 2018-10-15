BeginPackage["core`src`"]

`Private`dependence={"core`utils`","core`debug`"};

$ContextPath=Join[$ContextPath,`Private`dependence];

loadSrc[dir_,pattern:"*.m"]:=(
  srcList = FileNames[pattern, dir, Infinity];
  SetSharedFunction[src];
  Do[src[i] = ReadString[i], {i, srcList}]);

getSrc[name__] := With[{
  path = FileNameJoin[{Global`$PackageDir, name}]},
  If[Head[src[path]]===String, src[path],
    debug[path <> " not loaded !", 0];]]

import[names__]:=With[
  {src=getSrc[names]},
  freeze[$ContextPath,ImportString[src]]
];

importFreeze[names__]:=With[
  {src=getSrc[names]},
  freeze[$ContextPath,ImportString[src]]
];

Remove/@{dir,i,name,names,path,pattern};

`Private`isLoaded=True;

EndPackage[]