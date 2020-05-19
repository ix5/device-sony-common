#!/vendor/bin/sh

ODMAPPS_BASE="/odm/system_ext"
ODMAPPS_PRIVAPP="${ODMAPPS_BASE}/priv-app"
ODMAPPS_PERMS="${ODMAPPS_BASE}/etc/permissions"

DEST_BASE="/product"
DEST_PRIVAPP="${DEST_BASE}/priv-app"
DEST_PERMS="${DEST_BASE}/etc/permissions"

for APP_FOLDER in $(ls -1 ${ODMAPPS_PRIVAPP}/) ; do
  mount -o bind ${ODMAPPS_PRIVAPP}/${APP_FOLDER} ${DEST_PRIVAPP}/${APP_FOLDER}
done
for PERMISSION_XML in $(ls -1 ${ODMAPPS_PERMS}/*.xml) ; do
  mount -o bind ${ODMAPPS_PERMS}/${PERMISSION_XML} ${DEST_PERMS}/${PERMISSION_XML}
done
