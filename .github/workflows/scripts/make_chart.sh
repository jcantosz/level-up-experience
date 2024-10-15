#!/bin/bash

EXP_FILE=".config/current.exp"
LVLS_FILE=".config/levels.exp"
MERMAID_TPL=".config/graph.tpl"

CURR_EXP=$(head -1 $EXP_FILE)

TICKS_PERCENT=10

echo "exp: $CURR_EXP"

PREV_LEVEL_EXP=0
CURR_LEVEL_EXP=0
while read level; do
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

sed -e "s/{{.*TICKS.*}}/0/g" $MERMAID_TPL
sed -e "s/{{\tTICKS\t}}/0/g" $MERMAID_TPL
sed -e "s/{{[[:space:]]TICKS[[:space:]]}}/0/g" $MERMAID_TPL

sed \
  -e "s/{{[[:SPACE:]]TICKS[[:SPACE:]]}}/0/g" \
  -e "s/{{[[:SPACE:]]PREV_LVL_EXP[[:SPACE:]]}}/0/g" \
  -e "s/{{[[:SPACE:]]CURR_EXP[[:SPACE:]]}}/0/g" \
  -e "s/{{[[:SPACE:]]CURR_LVL_EXP[[:SPACE:]]}}/100/g" \
  $MERMAID_TPL >> $GITHUB_STEP_SUMMARY

# sed \
#   -e "s/{{[[:SPACE:]]?TICKS[[:SPACE:]]}}/$PREV_LVL_EXP/g" \
#   -e "s/{{[[:SPACE:]]PREV_LVL_EXP[[:SPACE:]]}}/$PREV_LVL_EXP/g" \
#   -e "s/{{[[:SPACE:]]CURR_EXP[[:SPACE:]]}}/$CURR_EXP/g" \
#   -e "s/{{[[:SPACE:]]CURR_LVL_EXP[[:SPACE:]]}}/$CURR_LVL_EXP/g" \
#   $MERMAID_TPL >> $GITHUB_STEP_SUMMARY

