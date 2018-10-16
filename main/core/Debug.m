BeginPackage["core`Debug`"];

Begin["`Private`"];

`defaultDebugf=Print;
`defaultComputeDebugf=Null;
`defaultTypeList={"msg","val","core"};

End[];


typeList::usage = "typeList[]";
If[!ValueQ[`typeList],
  `typeList=`Private`defaultTypeList,
  `typeList=Union[`typeList,`Private`defaultTypeList];
];

defaultDebugLevel::usage = "defaultDebugLevel[]";
If[!ValueQ[`defaultDebugLevel],
  `defaultDebugLevel=0];


SetAttributes[Global`debugf,HoldAll];
If[!ValueQ[Global`debugf],
  If[$KernelID===0,
    Global`debugf=`Private`defaultDebugf,
    Global`debugf[___]=`Private`defaultComputeDebugf];];

`Private`mergeAssociations[default_,current_]:=KeySort[Merge[{default, current}, Last]];
`Private`defaultAssociation=Association @@ (# -> `Private`defaultDebugLevel & /@ `typeList);

If[!ValueQ[Global`$verbose],
  Global`$verbose=`Private`defaultAssociation,
  Global`$verbose=`Private`mergeAssociations[`Private`defaultAssociation,Global`$verbose];
];


debug::usage = "debug[]";
SetAttributes[debug,HoldAll];
debug[msg__,level_List]:=If[
  NumberQ[Global`$verbose[level[[1]]]] &&
      Global`$verbose[level[[1]]]>=level[[2]],
  Global`debugf[msg]];

debugset::usage = "debugset[]";
SetAttributes[debugset,HoldAll];
debugset[vars__,level_List]:=
  Do[debug[StringTake[ToString[var],{6,-2}]<>" is "<>ToString[ReleaseHold[var]],level]
    ,{var,Map[Hold,Hold[{vars}],2][[1,1]]}];


debug["$verbose is set to ",Global`$verbose,{"core",5}];

Remove/@{level,msg, var, vars,current,default};

`Private`isLoaded=True;
EndPackage[];