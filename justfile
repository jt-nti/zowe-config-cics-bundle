#
# Recipes to deploy a CICS bundle to host Zowe team configuration files
#
# Use with https://github.com/casey/just
#

set dotenv-load

curl := require("curl")

_default:
    @just -f {{justfile()}} --list

# Check CICS connection
get-cics-region:
    echo "user: \"$CICS_USER:$CICS_PASSWORD\"" | {{curl}} --config - \
        --insecure \
        --request GET \
        --url ${CICS_CMCI_URL:?}/CICSSystemManagement/CICSRegion/{{env("CICS_PLEX", "")}}/{{env("CICS_REGION", "")}}

# Create CICS bundle
create-cics-bundle:
    echo "user: \"$CICS_USER:$CICS_PASSWORD\"" | {{curl}} --config - \
        --insecure \
        --request POST \
        --url ${CICS_CMCI_URL:?}/CICSSystemManagement/CICSDefinitionBundle/{{env("CICS_PLEX", "")}}/{{env("CICS_REGION", "")}} \
        --header 'content-type: application/xml' \
        --data '<request><create><parameter name="CSD"/><attributes name="{{env("CICS_BUNDLE")}}" bundledir="{{env("CICS_BUNDLE_DIR")}}" csdgroup="{{env("CICS_CSD_GROUP")}}"/></create></request>'

# Clean
clean:
    gradle clean

# Build the Zowe config CICS bundle using gradle
build:
    gradle buildCICSBundle

# Package the Zowe config CICS bundle into a zipped archive using gradle
package:
    gradle packageCICSBundle

# Deploy the Zowe config CICS bundle using gradle
deploy:
    gradle deployCICSBundle --stacktrace
