#list operations

let

  # importing the list lib
  lib = import <nixpkgs/lib>;

  empty_set = [ ];
  nums = [
    1
    2
    3
    4
    5
  ];
  mixed = [
    1
    2
    3
    "string"
    {
      prop = {
        name = "string";
        age = 21;
      };
    }
  ];

  # basic list operations with lib

  # grabs the first element in the list
  first = builtins.head nums;

  # grabs the first element in the list ( all except the 1st one from the list)
  remaining = builtins.tail nums;

  # grab the  element from the index
  grabFromIdx = builtins.elemAt nums 2; # gets the value at index 2

  # get the length of the list
  len = builtins.length nums;

  # check if the element exists or not
  has_3 = builtins.elem 3 nums; # check if number 3 exists in the set

in
# findSet = builtins.filter (x: builtins.isAttrs x )mixed;

if has_3 == false then
  {
    message = "the number does not exists";
  }
else
  #the builtins.trace takes 2 args <message> & <value>
  (builtins.trace) "the type of nums is:" (builtins.typeOf nums)

#1. (builtins.elemAt mixed 4).prop.name

# if the list contains mixed types and you need to find the set dynamically

#uncomment this one and comment no. 1 after playing around with no.1
#2.  if findSet != [] then (builtins.head findSet).prop.name else null
