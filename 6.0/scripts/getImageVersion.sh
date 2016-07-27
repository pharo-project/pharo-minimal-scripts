set -e

IMAGE_VERSION=$1
OUTPUT=$2

wget "http://files.pharo.org/image/60/$IMAGE_VERSION.zip"

unzip -o "$IMAGE_VERSION.zip"

mv "Pharo-$IMAGE_VERSION.image" $OUTPUT.image
mv "Pharo-$IMAGE_VERSION.changes" $OUTPUT.changes