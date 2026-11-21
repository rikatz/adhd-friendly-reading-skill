---
description: Turn the AFRS reading format on or off for every session, or show its state
argument-hint: on | off | status
---

Run this command with the Bash tool, replacing an empty argument with `status`,
and show its one-line output to the user:

```bash
sh "${CLAUDE_PLUGIN_ROOT}/hooks/afrs.sh" $ARGUMENTS
```

If AFRS is now off, stop applying the AFRS reading format in this conversation.
If it is now on, apply it to long or complex answers from the next one.
