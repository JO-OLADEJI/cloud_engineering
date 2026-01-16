# Production Log & Disk Hygiene Tool

**Scenario**: _You're a cloud engineer responsible for a fleet of Linux servers. One of your service is occasionally crashing due to disk exhaustion. Your task is to write a bash script that:_

- Inspects the system
- Identifies problems
- Takes safe, automated action
- Produces useful output for humans and machines

### Objective

Write a bash script called `disk_hygiene.sh` that analyzes disk usages, log files, and takes conditional action based on what it finds.

### Functional Requirements

1. Disk Usage Inspection
    - Check disk usage of `/`
    - If disk usage is **>= 80%**, the script should:
        - Print a warning
        - Trigger log analysis (see below)
    - If disk usage is **< 80%**, exit gracefully with a success message
    - Hint: `df`, `awk`, `sed`, or `cut`

<br />

2. Log File Discovery — when disk usage is high:
    - Search `/var/log` for:
        - Files **larger than 100MB**
        - Modified within the last 7 days
    - Sort them by size (largest first)
    - Display the top 5
    - Hint: `find`, `stat`, `sort`, `head`, `xargs`

<br />

3. Intelligent Cleanup (Dry-run first) — For each large log file found:
    - If the filename ends in `.log`:
        - Compress it using `gzip`
    - If it ends in `.gz`:
        - Leave it alone
    - If it's not a **log** file:
        - Print a warning and skip

The script must support:

```bash
./disk_hygiene.sh --dry-run
```

When **no changes are made**, only printed.

<br />

4. Safety & Robustness
   Your script must: - Exit immediately if run as **root is required and missing** - Handle: - Missing directories - Permission errors - Empty results - Use `set -euo pipefail`

<br />

5. Logging
    - All actions must be logged to `/var/log/disk_hygiene.log`
    - Each log entry must include:
        - Timestamp
        - Action
        - Result (SUCCESS/SKIPPED/FAILED)
    - Hint: `tee`, `logger`, or manual redirection

<br />

6. Output Style
    - Use clear, structured output
    - Be readable by:
        - A human
        - A CI/CD pipeline (exit codes matter)

<br />

### Stretch Goals (Optional but very cloud engineering oriented)

If you want to level it up further:

- Add a `--threshold` flag (default 80%)
- Send a Slack webhook or email on cleanup
- Output JSON when `--json` is passed
- Make it cron-safe
- Write unit tests using `bats`
