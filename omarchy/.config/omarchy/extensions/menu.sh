# Override screenrecord menu to add "No audio" option
show_screenrecord_menu() {
  omarchy-cmd-screenrecord --stop-recording && exit 0

  case $(menu "Screenrecord" "  No audio\n  With desktop audio\n  With desktop + microphone audio\n  With desktop + microphone audio + webcam") in
  *"No audio") omarchy-cmd-screenrecord ;;
  *"With desktop audio") omarchy-cmd-screenrecord --with-desktop-audio ;;
  *"With desktop + microphone audio") omarchy-cmd-screenrecord --with-desktop-audio --with-microphone-audio ;;
  *"With desktop + microphone audio + webcam")
    local device=$(show_webcam_select_menu) || { back_to show_capture_menu; return; }
    omarchy-cmd-screenrecord --with-desktop-audio --with-microphone-audio --with-webcam --webcam-device="$device"
    ;;
  *) back_to show_capture_menu ;;
  esac
}
