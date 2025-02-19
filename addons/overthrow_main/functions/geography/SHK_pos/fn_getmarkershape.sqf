//  In: marker
// Out: string (marker shape)

private ["_size","_x","_y","_ret"];
_size = markersize _this;
_x = _size select 0;
_y = _size select 1;

_ret = "";

switch (toLowerANSI(markershape _this)) do {
  case "rectangle": {
    if (_x isEqualTo _y) then {
      _ret = "SQUARE";
    } else {
      _ret = "RECTANGLE";
    };
  };
  case "ellipse": {
    if (_x isEqualTo _y) then {
      _ret = "CIRCLE";
    } else {
      _ret = "ELLIPSE";
    };
  };
  case "icon": {
    _ret = "ICON";
  };
};
_ret