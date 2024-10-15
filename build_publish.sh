#!/bin/bash -x

generate() {
    npx @techdocs/cli generate --source-dir . --output-dir ${OUTPUT_DIR}
}

publish() {
    npx @techdocs/cli publish --publisher-type awsS3 --awsEndpoint ${MINIO_URL} --storage-name ${MINIO_BUCKET} --entity $1 --directory ${OUTPUT_DIR} --awsS3ForcePathStyle true
}

brew reinstall node
npm install -g npx --force

pushd components
    generate
    publish default/component/tdp-component
popd

pushd domains
    generate
    publish default/domain/tdp-domain
popd

pushd systems
    generate
    publish default/system/tdp
popd

generate
publish default/location/tdp-catalog-info