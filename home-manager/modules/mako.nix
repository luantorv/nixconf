{ config, pkgs, ...}:

{
  services.mako = {
    enable = true;

    settings = {
      anchor = "bottom-center";
      layer = "overlay";

      font = "JetBrainsMono Nerd Font 10";
      width = 350;
      height = 150;
      margin = "20";
      padding = "15";
      border-size = 2;
      border-radius = 5;
  
      background-color = "${config.colors.black}";
      border-color = "${config.colors.white}";
      text-color = "${config.colors.white}";
      progress-color = "over ${config.colors.darkblue}";
  
      default-timeout = 5000; # 5 seconds
    };
    
    extraConfig = ''
      [urgency=high]
      border-color=${config.colors.red}
      text-color=${config.colors.red}
      default-timeout=0

      # 2. Diseño para Reproducción de Música
      [category=preview]
      border-color=${config.colors.skyblue}
      background-color=${config.colors.white}ee

      # 3. Diseño para capturas de pantalla o Spotify (usando app-name)
      [app-name=Spotify]
      border-color=${config.colors.green}
    
      [app-name=swappy]
      border-color=${config.colors.pink}
      default-timeout=2000
    '';
  };
}