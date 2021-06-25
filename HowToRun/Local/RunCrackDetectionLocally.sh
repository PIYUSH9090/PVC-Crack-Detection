#!/bin/sh
abort()
{
    echo >&2 '
***************
*** ABORTED ***
***************
'
    echo "An error occurred in RunCrackDetectionLocally.sh . Exiting..." >&2
    exit 1
}

trap 'abort' 0

set -e
#RunSentimentAnalyzer.sh
# if you get xcode error. xcode-select --install
# https://ma.ttias.be/mac-os-xcrun-error-invalid-active-developer-path-missing-xcrun/
CURRENT_DIR=`pwd`
CURRENT_DATE=`date +%b-%d-%y_%I_%M_%S_%p`
# Switch to root folder and run.
cd ../../
echo "`pwd`"
mkdir logs/$CURRENT_DATE
cd CrackDetection-logic
echo "Started CrackDetection-logic. Do tail -f logs/CrackDetection-logic.log from "+$CURRENT_DIR
#open -a Terminal $CURRENT_DIR/logs
# You need to enter into python file directory
python app.py



trap : 0

echo >&2 '
************
*** DONE RunCrackDetectionLocally ***
************'
