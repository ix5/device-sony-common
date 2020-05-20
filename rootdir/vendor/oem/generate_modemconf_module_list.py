#!/usr/bin/env python3

# This script will generate:
# rootdir/vendor/oem/Android.bp
# rootdir/vendor/oem/modemconf_products.bp

import glob
import os

# Make this this script can be called from anywhere
os.chdir(os.path.split(__file__)[0])

def get_all_modules():
    all_modules = []
    modemconfig_dir = "modem-config/"

    all_files = glob.glob(modemconfig_dir + '/**/modem_conf', recursive=True)
    for filename in all_files:
        all_modules.append({
            'name': "%s_%s" % (
                '_'.join(
                    os.path.split(
                        filename)[0].split('/')
                    ).replace('.', '_').replace('modem-config_', ''),
                os.path.split(filename)[-1]
            ),
            'location': filename,
            'dest_dir': os.path.split(filename)[0],
        })

    return all_modules

BP_TEMPLATE = """
// Include generated module blueprints
build = ["modemconf_modules.bp"]

// Fake module to transitively pull in modemconf modules
prebuilt_etc {
    name: "modemconf_filegroup",
    src: "fake.txt",
    vendor: true,
    installable: false,
    required: [
%s
    ],
}
"""

BP_SUB_TEMPLATE = """prebuilt_etc {
    name: "%s",
    src: "%s",
    sub_dir: "oem/%s",
    vendor: true,
    filename_from_src: true,
}
"""

generated_blueprint = ""
generated_product_list = """PRODUCT_PACKAGES += \\
"""
generated_deps_list = ""

for modemconf in get_all_modules():
    generated_blueprint += (
        BP_SUB_TEMPLATE % (
            modemconf["name"],
            modemconf["location"],
            modemconf["dest_dir"],
        )
    )
    generated_product_list += "    %s \\\n" % modemconf["name"]
    generated_deps_list += '        "%s",\n' % modemconf["name"]

print("Generating superproject Android.bp")
with open('Android.bp', 'w') as androidbp_file:
    androidbp_file.write(BP_TEMPLATE % generated_deps_list)

print("Writing modules to modemconf_modules.bp")
with open('modemconf_modules.bp', 'w') as modemconf_bp:
    modemconf_bp.write(generated_blueprint)
