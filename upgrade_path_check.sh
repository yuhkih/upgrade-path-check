#!/bin/bash
# /usr/local/bin/oc-adm-upgrade-loop.sh
# Usage: ./oc-adm-upgrade-loop.sh <search-string>
# Example: ./oc-adm-upgrade-loop.sh Available

This is wrong...

OC_BIN="/usr/bin/oc"
LOG="oc-adm-upgrade.log"

if [ $# -ne 1 ]; then
  echo "Usage: $0 <Upgrade Target Version>"
  exit 1
fi

SEARCH="$1"
CURRENT=` oc adm  upgrade | grep "Cluster version" | awk '{print $4}'`
echo -e "Current Cluster version is : \e[32m" $CURRENT "\e[0m"
echo -e "Target Cluster version is  : \e[32m" $SEARCH "\e[0m"

while true; do
  echo "[$(date --iso-8601=seconds)] Starting oc adm upgrade with filter: $SEARCH" >> "$LOG"
  
  # filter by the target version
  # COUNT=`"$OC_BIN" adm upgrade 2>&1 | grep "$SEARCH"`
  COUNT=0
  COUNT=`oc adm upgrade 2>&1 | grep "$SEARCH" | wc -l`
  
  if [ $COUNT -eq 0 ] ; then
      echo -e "[$(date --iso-8601=seconds)] The upgrade path from\e[32m "$CURRENT "\e[0m to \e[32m"$SEARCH "\e[0m\e[31mdoesn't exist\e[0m" | tee -a "$LOG"
  else
      echo -e "[$(date --iso-8601=seconds)] The upgrade path from\e[32m "$CURRENT "\e[0m to \e[32m"$SEARCH "\e[0mis \e[32mavailable\e[0m" | tee -a "$LOG"
  fi  
  # sleep 
  sleep 60 
done
