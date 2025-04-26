{
  lib,
  config,
  ...
}:
let
  cfg = config;
  lib = import <nixpkgs/lib>;
in
{
  config = {
    sum = cfg._1st + cfg._2nd + (if cfg._3rd == null then 0 else cfg._3rd);

    # overriding values
    # mkOverride <priority> <value>

    _1st = lib.mkOverride 1 10;
    _2nd = lib.mkOverride 1 20;
    _3rd = lib.mkForce 10; # this forces 10 to be the value overriding values elsewhere from other modules if set

    # key points:  mkOverride <priority> <value>
    /*
            Priority Range	Common Functions	                        Effect
            0-49	            mkForce (50)	                Highest priority, overrides everything
            50-99	            Manual overrides	            Stronger than defaults but weaker than mkForce
            100	            Normal declarations	                Default priority for explicit values
            101-999	            -	                             Intermediate priorities
            1000	            mkDefault	                    Weaker than explicit values
            1001+             	-	                            Lowest priorities

      the smaller the values for priority, the more effectivly it would override, if something has a more (higher) priority then it can override the values of something having lesser (lower) priority.
    */
    # key points : mkForce <value> ( default is set to 50)
    /*
      Priority	    Function	Description
      0-49	        (Manual)	Higher than mkForce
      50	        mkForce 	Overrides normal/default values
      51-99	        (Manual)	Between force and normal
      100	        Normal      assignment	Standard explicit value
      1000	        mkDefault	Weakest priority (default fallback)
    */
  };

}
