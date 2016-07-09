function azth_custom_after_build() {
  cp -rvf "$AZTH_PATH_CUSTOM/conf/"*.conf "$CONFDIR"
  cp -rvf "$AZTH_PATH_CUSTOM/bin/runners/"* "$INSTALL_PATH/bin/"
}


registerHooks "ON_AFTER_BUILD" azth_custom_after_build
