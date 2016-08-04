set -e

# bash generateFromBaseline.sh baselineName inputImageName outputImageName

wget -O - http://get.pharo.org/vm60 | bash

unzip -o "./pharo-minimal-scripts/6.0/fonts/BitmapDejaVuSans.fuel.zip"

mkdir icon-packs
cd icon-packs
wget http://github.com/pharo-project/pharo-icon-packs/archive/idea11.zip
cd ..

git clone https://github.com/guillep/pharo-core.git
cd pharo-core/
git checkout tags/v$(cut -f1 ../version.txt)
cd ..

cp -R ./pharo-minimal-scripts/6.0/baselines/* ./pharo-core/src/

INPUT_IMAGE_NAME=$2
IMAGE_NAME=$3

unzip -o "$INPUT_IMAGE_NAME.zip"
mv "$INPUT_IMAGE_NAME.image" "$IMAGE_NAME.image" 
mv "$INPUT_IMAGE_NAME.changes" "$IMAGE_NAME.changes" 


./pharo "$IMAGE_NAME.image" --no-default-preferences eval --save \
	"Metacello new baseline: '$1'; repository: 'filetree://./pharo-core/src'; load."	

zip -rj "$IMAGE_NAME.zip" $IMAGE_NAME.image $IMAGE_NAME.changes

./pharo "$IMAGE_NAME.image" --no-default-preferences ./pharo-minimal-scripts/6.0/common/info.st



