
function start_monitors() {
  LEFT_VGA=""
  VGA_LIST=`xrandr | grep ' connected' | cut -f1 -d" "`
  COMMAND="xrandr"
  for VGA in $VGA_LIST
  do
    if [ "$LEFT_VGA" != "" ]
    then
      COMMAND="$COMMAND --output $LEFT_VGA --left-of $VGA"
    fi
    LEFT_VGA=$VGA
  done
  $COMMAND
}

function get_urls() {
  if [ ! -f ~/.urls.cfg ] || [ "`cat ~/.urls.cfg`" == "" ]
  then
    browser-detect-monitors 'http://localhost/mesario.html' 'http://localhost:5000/' --messages 'Informe o número do monitor do MESÁRIO' 'Informe o número do monitor da URNA'>  ~/.urls.cfg
  fi
  cat ~/.urls.cfg
}
xfwm4 &
sleep 0.5
start_monitors
sleep 0.5
browser `get_urls`
