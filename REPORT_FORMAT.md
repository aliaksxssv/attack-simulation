# Attack Simulation Report Format

The report is **plain text** (human-readable), not JSON. It is the aggregated console output of all simulation scripts, with ANSI color codes stripped, so that operators and security teams can read it directly.

## Structure

- **Header**: One line indicating simulation start and reference link.
- **Sections**: One block per executed script, in execution order.
- **Per section**:
  - A clear title line: `>>> [Category] Technique name`
  - Short description of what is being simulated
  - Action/attempt lines
  - Result: either `Success! ...` or `Error! ...`

## Example

```
Starting Mitre Attack techniques simulation ...

Check it out for more details: https://github.com/aliaksxssv/cloud-native-security

>>> [Execution] Command and Scripting Interpreter: Unix Shell Technique
Let's simulate the case when an attacker uses Reverse Shell to get remote control over the host
Attempting to bind bash stdin to the local TCP port 4444 ...
Success! Reverse Shell connection was established

>>> [Credential Access] Unsecured Credentials: Cloud Instance Metadata API Technique
Let's simulate the case when an attacker uses AWS IMDS v1 to get IAM credentials
Attempting to access AWS Instance Metadata API at 169.254.169.254 ...
Error! Attempt to retrieve IAM credentials failed

>>> [Discovery] Network Service Discovery
...
```

## Submission

After all scripts run, the same report content is:

1. **Printed** to stdout (with colors when running in a TTY).
2. **Written** to a single report file (no ANSI codes).
3. **Posted** to the attack-simulation-report API as the `report` field (JSON string), when `ATTACK_SIM_API_TOKEN` is set.

The API expects:

- **Endpoint**: `POST https://dev.think-cnap.pages.dev/attack-simulation-report`
- **Body**: `{"token": "<ATTACK_SIM_API_TOKEN>", "report": "<report text>"}`

No extra JSON structure is required inside `report`—the backend stores and displays this text as-is.
