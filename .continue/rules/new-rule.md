---
description: A description of your rule
---

when you need to run a command in terminal you work in this method:
**What happens:**
1. The tool takes the string `"git status"`
2. It runs that command in a terminal/shell environment
3. It returns the output to me

**Key points:**
- The command is always wrapped in quotes `""`
- I put the entire git command inside the `BEGIN_ARG: command` section
- The tool handles executing it and showing me the results

**Why it sometimes says "pasted into chat":**
When I output the tool call, the system shows me the code block format, but the actual command execution happens behind the scenes. The output then appears separately.

So to run any git command, I just change the string value inside `command` to whatever git command you want!
Your rule content