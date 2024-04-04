#!/bin/bash
ayu_dark_black="#0B0E14"
ayu_dark_blue="#39BAE6"
ayu_dark_yellow="#FFB454"
ayu_dark_red="#F07178"
ayu_dark_white="#BFBDB6"
ayu_dark_green="#AAD94C"
ayu_dark_visual_grey="#454b55"
ayu_dark_comment_grey="#11151C"

get() {
   local option=$1
   local default_value=$2
   local option_value="$(tmux show-option -gqv "$option")"

   if [ -z "$option_value" ]; then
      echo "$default_value"
   else
      echo "$option_value"
   fi
}

set() {
   local option=$1
   local value=$2
   tmux set-option -gq "$option" "$value"
}

setw() {
   local option=$1
   local value=$2
   tmux set-window-option -gq "$option" "$value"
}

set "status" "on"
set "status-justify" "left"

set "status-left-length" "100"
set "status-right-length" "100"
set "status-right-attr" "none"

set "message-fg" "$ayu_dark_white"
set "message-bg" "$ayu_dark_black"

set "message-command-fg" "$ayu_dark_white"
set "message-command-bg" "$ayu_dark_black"

set "status-attr" "none"
set "status-left-attr" "none"

setw "window-status-fg" "$ayu_dark_black"
setw "window-status-bg" "$ayu_dark_black"
setw "window-status-attr" "none"

setw "window-status-activity-bg" "$ayu_dark_black"
setw "window-status-activity-fg" "$ayu_dark_black"
setw "window-status-activity-attr" "none"

setw "window-status-separator" ""

set "window-style" "fg=$ayu_dark_comment_grey"
set "window-active-style" "fg=$ayu_dark_white"

set "pane-border-fg" "$ayu_dark_white"
set "pane-border-bg" "$ayu_dark_black"
set "pane-active-border-fg" "$ayu_dark_green"
set "pane-active-border-bg" "$ayu_dark_black"

set "display-panes-active-colour" "$ayu_dark_yellow"
set "display-panes-colour" "$ayu_dark_blue"

set "status-bg" "$ayu_dark_black"
set "status-fg" "$ayu_dark_white"

set "@prefix_highlight_fg" "$ayu_dark_black"
set "@prefix_highlight_bg" "$ayu_dark_green"
set "@prefix_highlight_copy_mode_attr" "fg=$ayu_dark_black,bg=$ayu_dark_green"
set "@prefix_highlight_output_prefix" "  "

time_format=$(get "@ayu_dark_time_format" "%R")
date_format=$(get "@ayu_dark_date_format" "%d/%m/%Y")

set "status-right" "#[fg=$ayu_dark_white,bg=$ayu_dark_black,nounderscore,noitalics]${time_format}  ${date_format} #[fg=$ayu_dark_green,bg=$ayu_dark_black,nobold,nounderscore,noitalics]#[fg=$ayu_dark_visual_grey,bg=$ayu_dark_green,bold] #h "
set "status-left" "#[fg=$ayu_dark_black,bg=$ayu_dark_green,bold] #S #{prefix_highlight}#[fg=$ayu_dark_green,bg=$ayu_dark_black,nobold,nounderscore,noitalics]"

set "window-status-format" "#[fg=$ayu_dark_black,bg=$ayu_dark_black,nobold,nounderscore,noitalics]#[fg=$ayu_dark_white,bg=$ayu_dark_black] #I  #W #[fg=$ayu_dark_black,bg=$ayu_dark_black,nobold,nounderscore,noitalics]"
set "window-status-current-format" "#[fg=$ayu_dark_black,bg=$ayu_dark_visual_grey,nobold,nounderscore,noitalics]#[fg=$ayu_dark_white,bg=$ayu_dark_visual_grey,nobold] #I  #W #[fg=$ayu_dark_visual_grey,bg=$ayu_dark_black,nobold,nounderscore,noitalics]"

