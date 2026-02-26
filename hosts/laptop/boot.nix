{ config, pkgs, ... }:

{
  boot.kernelModules = [ "ideapad_laptop" ];

  boot.kernelParams = [ 
    "intel_pstate=active" 
    "processor.max_cstate=1" 
  ];
}