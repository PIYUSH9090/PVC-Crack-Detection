#!/bin/sh
abort()
{
    echo >&2 '
***************
*** ABORTED ***
***************
'
    echo "An error occurred StopCrackDetectionLocally.sh . Exiting..." >&2
    exit 1
}

trap 'abort' 0

set -e
cd ../../
cd CrackDetection-logic
sh StopCrackDetection-logicLocally.sh >> ../logs/CrackDetection-logic.log
echo "Stopped CrackDetection-logic. Do tail -f logs/CrackDetection-logic.log from "+$CURRENT_DIR

trap : 0

echo >&2 '
************
*** DONE StopCrackDetectionLocally ***
************'
