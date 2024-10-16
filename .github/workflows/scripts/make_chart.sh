#!/bin/bash

EXP_FILE=".config/current.exp"
LVLS_FILE=".config/levels.exp"
MERMAID_TPL=".config/graph.tpl"

# Update the exp the user has
NEW_EXP=$1
CURR_EXP=$(head -1 $EXP_FILE)
CURR_EXP=$((CURR_EXP + $NEW_EXP))
echo $CURR_EXP > $EXP_FILE

TICKS_PERCENT=10

echo "exp: $CURR_EXP"
CURR_LEVEL=0

PREV_LEVEL_EXP=0
CURR_LEVEL_EXP=0

## compare level to levels file and find the next amount of exp needed
while read level; do
  CURR_LEVEL=$(( CURR_LEVEL + 1))
  CURR_LEVEL_EXP=$level
  if [[ $CURR_EXP -lt $CURR_LEVEL_EXP ]]; then
    break;
  fi
  PREV_LEVEL_EXP=${CURR_LEVEL_EXP}
done < $LVLS_FILE

TICKS=$(( (CURR_LEVEL_EXP - PREV_LEVEL_EXP) / TICKS_PERCENT ))

echo "CURR_LVL_EXP: $CURR_LEVEL_EXP"
echo "PREV_LVL_EXP: $PREV_LEVEL_EXP"
echo "CURR_EXP: $CURR_EXP"

## Write out to README
echo "### Level $((CURR_LEVEL-1)) --> $CURR_LEVEL Progress" > README.md
sed \
  -e "s/{{[[:space:]]TICKS[[:space:]]}}/$TICKS/g" \
  -e "s/{{[[:space:]]PREV_LVL_EXP[[:space:]]}}/$PREV_LEVEL_EXP/g" \
  -e "s/{{[[:space:]]CURR_EXP[[:space:]]}}/$CURR_EXP/g" \
  -e "s/{{[[:space:]]CURR_LVL_EXP[[:space:]]}}/$CURR_LEVEL_EXP/g" \
  $MERMAID_TPL >> README.md
