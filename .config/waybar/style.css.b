@define-color base            #232136;
@define-color surface         #2a273f;
@define-color overlay         #393552;

@define-color muted           #6e6a86;
@define-color subtle          #908caa;
@define-color text            #e0def4;

@define-color love            #eb6f92;
@define-color gold            #f6c177;
@define-color rose            #ea9a97;
@define-color pine            #3e8fb0;
@define-color foam            #9ccfd8;
@define-color iris            #c4a7e7;

@define-color highlightLow    #2a283e;
@define-color highlightMed    #44415a;
@define-color highlightHigh   #56526e;

* {
  background: transparent;
    background-color: transparent;
    color: @base;
    font-family: GoMono Nerd Font;
    font-size: 16px;
    border: none;
    border-radius: 0;
    margin: 0;
    padding: 0;
}


window#waybar {
    background-color: transparent;
    border: none;
    color: @base;
}

button {
  background-color: @base;
  color: @love;
  border: 2px solid @love;
  border-radius: 2px;
  padding: 0 4px;
}

/* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
button:hover {
    background: @rose;
    /* box-shadow: inset 0 -3px #ffffff; */
}

#workspaces {
  /* background-color: transparent; */
    margin-left: 0;
    margin-right: 0;
}
#workspaces button {
  margin-right: 4px;
}

#workspaces button:hover {
    background-color: @love;
    /* color: @base; */
}

#workspaces button.focused, #workspaces button.active {
    /* background-color: @iris; */
    /* box-shadow: inset 0 -3px #ffffff; */
}

#workspaces button.urgent {
    background-color: #eb4d4b;
}

#mode {
    background-color: #64727D;
    box-shadow: inset 0 -3px #ffffff;
}

#tray,
#clock,
#pulseaudio,
#backlight,
#battery,
#idle_inhibitor,
#power-profiles-daemon {
    /* padding: 0 8px; */
    /* background: @base; */
    /* color: @text; */
}

#clock {
  background-color: @base;
  color: @love;
  border: 2px solid @love;
  border-radius: 2px;
}

#battery {
    background-color: @base;
      border: 2px solid @love;
    color: @text;
}

#battery.charging, #battery.plugged {
    /* background-color: #26A65B; */
    color: @love;
}

@keyframes blink {
    to {
        background-color: #ffffff;
        color: #000000;
    }
}

/* Using steps() instead of linear as a timing function to limit cpu usage */
#battery.critical:not(.charging) {
    background-color: @love;
    color: @base;
    animation-name: blink;
    animation-duration: 0.5s;
    animation-timing-function: steps(12);
    animation-iteration-count: infinite;
    animation-direction: alternate;
}

#power-profiles-daemon {
    background-color: @base;
    padding-right: 16px;
}

#power-profiles-daemon.performance {
    background-color: @;
    color: #ffffff;
}

#power-profiles-daemon.balanced {
    background-color: #2980b9;
    color: #ffffff;
}

#power-profiles-daemon.power-saver {
    background-color: #2ecc71;
    color: #000000;
}

label:focus {
    background-color: #000000;
}

#cpu {
    background-color: #2ecc71;
    color: #000000;
}

#memory {
    background-color: #9b59b6;
}

#disk {
    background-color: #964B00;
}

#backlight {
    background-color: #90b1b1;
}

#network {
    background-color: #2980b9;
}

#network.disconnected {
    background-color: #f53c3c;
}

#pulseaudio {
}

#pulseaudio.muted {
    color: @muted;
}

#tray {
    background-color: #2980b9;
}

#tray > .passive {
    -gtk-icon-effect: dim;
}

#tray > .needs-attention {
    -gtk-icon-effect: highlight;
    background-color: #eb4d4b;
}

#idle_inhibitor {
    background-color: #2d3436;
}

#idle_inhibitor.activated {
    background-color: #ecf0f1;
    color: #2d3436;
}

