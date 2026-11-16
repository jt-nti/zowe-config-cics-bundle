# zowe-config-cics-bundle

[You can import Zowe config files from a URL by using the Zowe CLI](https://docs.zowe.org/stable/web_help/docs/zowe_config_import.html). For example,

```
zowe config import https://example.com:12345/zowe.config.json --global-config
```

You just need to host the config files somewhere, but where? 🤔

This example uses a CICS bundle to share Zowe team config files by using a TCP/IP service because, well, why not?!

## Deploying the example bundle

Before you start, make sure that you replace the [zowe.config.json](./src/main/resources/bundleParts/zowe.config.json) and [zowe.schema.json](./src/main/resources/bundleParts/zowe.schema.json) files with your own Zowe config files.

This example includes a Gradle build to deploy the `zowe-config-cics-bundle` CICS bundle with the [CICS bundle deployment API](https://www.ibm.com/docs/SSJL4D_6.x/fundamentals/cpsm/cics-bundle-api.html).

1. Copy the `sample.env` file to `.env` and edit all the variables in the new file to match your environment.
2. Run `just get-cics-region` to check that you can connect to the CMCI API.
3. If you can connect to the CMCI API, run `just create-cics-bundle` to create a bundle definition.
4. If you cannot connect to the CMCI API, create a `zowe-config-cics-bundle_1.0.0` bundle definition by using your preferred method.
5. Run `just deploy` to deploy the bundle.

If you are not able to use the CICS bundle deployment API, run `just package` to create a CICS bundle archive in the `build/distributions` directory. You can then deploy the bundle by using your preferred method.
