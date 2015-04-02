Pharo-minimal build scripts
===========================

This repository keeps the files needed to prepare the Pharo-minimal images, a shrink process that is executed by the CI service, you can find it [here](https://ci.inria.fr/pharo/job/Pharo-4.0-Update-Step-3-Minimal).

How to produce a minimal image
------------------------------
Is very easy, you just have to do something like this (assuming you have a real O.S. like Linux, Mac or, at least MinGW):

    wget -O - http://get.pharo.org | bash
    
    ./pharo Pharo.image unloadNB.st
    ./pharo Pharo.image prepareShrink.st
    ./pharo Pharo.image shrink.st > output.txt
    ./pharo Pharo.image info.st

