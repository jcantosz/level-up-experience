```mermaid
---
displayMode: compact
---
%%{init: { "theme": "forest", "themeVariables": { 'fontFamily": "Times" } } }%%
gantt
    dateFormat X
    axisFormat %s
    tickInterval {{ TICKS }}second
    section Exp
        ' : {{ PREV_LVL_EXP }}, {{ CURR_EXP }}
        ' : crit, {{ CURR_EXP }}, {{ CURR_LVL_EXP }}
```
