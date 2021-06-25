#StopCrackDetectionLogicLocally.sh
echo "Stop CrackDetection Logic Locally"+ `date`
ps ax | grep crack-detection | cut -f2 -d" " - | xargs kill -9
ps ax | grep crack-detection | cut -f1 -d" " - | xargs kill -9
ps ax | grep crack-detection | cut -f2 -d" " - | xargs kill -9
ps ax | grep crack-detection | cut -f1 -d" " - | xargs kill -9
ps ax | grep crack-detection