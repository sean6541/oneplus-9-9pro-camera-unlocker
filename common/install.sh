# Define variables
BASE_SCRIPT_DIR=$MODPATH/common/scripts
BASE_LIB_DIR=$MODPATH/common/libs
MODDED_LIB=com.qti.chi.override.so
MODULE_LIB=$MODPATH/system/vendor/lib64/hw/$MODDED_LIB
SELECTION=1

# Use volume key selection to choose the vendor firmware version
ui_print " "
ui_print "- Please select the vendor firmware"
ui_print "  your ROM is presently using by"
ui_print "  pressing the desired volume button:"
ui_print " "
ui_print "  Vol + / Up   = Next Option"
ui_print "  Vol - / Down = Finalize Selection"
ui_print " "
ui_print "  1. OxygenOS 11 (Aux enabler won't work)"
ui_print "  2. OxygenOS 12"
ui_print "  3. OxygenOS 13"
ui_print " "
ui_print "- Current Selection:"

while true; do
  ui_print "  $SELECTION"
  if chooseport 30; then
    SELECTION=$((SELECTION + 1))
  else
    break
  fi
  if [ $SELECTION -gt 3 ]; then
    SELECTION=1
  fi
done

# Copy the modded library to the module folder as per the vendor firmware selected
case $SELECTION in
  1)
    ui_print " "
	ui_print "- Selected Vendor Firmware:"
	ui_print " "
	ui_print "  OxygenOS 11"
	ui_print " "
	ui_print "- Copying appropriate modded library"
	cp_ch "$BASE_LIB_DIR"/oos11/$MODDED_LIB "$MODULE_LIB"
  ui_print "- Skipping aux enabler patch"
	;;
  2)
    ui_print " "
	ui_print "- Selected Vendor Firmware:"
	ui_print " "
	ui_print "  OxygenOS 12"
	ui_print " "
	ui_print "- Copying appropriate modded library"
	cp_ch "$BASE_LIB_DIR"/oos12/$MODDED_LIB "$MODULE_LIB"
	;;
  3)
    ui_print " "
	ui_print "- Selected Vendor Firmware:"
	ui_print " "
	ui_print "  OxygenOS 13"
	ui_print " "
	ui_print "- Copying appropriate modded library"
	cp_ch "$BASE_LIB_DIR"/oos13/$MODDED_LIB "$MODULE_LIB"
	;;
esac

# Only run aux enabler on OxygenOS 12+
if [ $SELECTION -gt 1 ]; then
  # Use volume key selection to choose the device
  ui_print " "
  ui_print " "
  ui_print "- Please select your device by"
  ui_print "  pressing the desired volume button:"
  ui_print " "
  ui_print "  Vol + / Up   = OnePlus 9 Pro"
  ui_print "  Vol - / Down = OnePlus 9 (non-pro)"

  if chooseport 30; then
    ui_print " "
  	ui_print "- Selected Device:"
  	ui_print " "
  	ui_print "  OnePlus 9 Pro"
  	ui_print " "
  	ui_print "- Copying appropriate aux enabler"
    ui_print "  script"
  	cp_ch "$BASE_SCRIPT_DIR"/op9pro/post-fs-data.sh "$MODPATH"
  else
    ui_print " "
  	ui_print "- Selected Device:"
  	ui_print " "
  	ui_print "  OnePlus 9 (non-pro)"
  	ui_print " "
  	ui_print "- Copying appropriate aux enabler"
    ui_print "  script"
  	cp_ch "$BASE_SCRIPT_DIR"/op9/post-fs-data.sh "$MODPATH"
  fi
fi

ui_print " "