#!/usr/bin/env python3

from bcc import BPF
from datetime import datetime
import json

# Define the BPF program to trace sys_exit_execve
bpf_program = """
#include <linux/sched.h>
#include <uapi/linux/ptrace.h>
//#define ARGSIZE 128

// Define the structure to hold process information
struct process_info {
    u32 pid;
    u32 uid;
    char comm[TASK_COMM_LEN];
    char parent_comm[TASK_COMM_LEN];
};

BPF_PERF_OUTPUT(events);

// Tracepoint for sys_exit_execve, triggered when execve() is called
TRACEPOINT_PROBE(syscalls, sys_exit_execve) {

    struct process_info data = {};
    struct task_struct *task;

    // Get child PID
    data.pid = bpf_get_current_pid_tgid() >> 32;
    
    // Get child UID
    data.uid = bpf_get_current_uid_gid();

    // Get child command
    bpf_get_current_comm(&data.comm, sizeof(data.comm));

    // Get parent command
    task = (struct task_struct *)bpf_get_current_task();
    bpf_probe_read_kernel_str(data.parent_comm, sizeof(data.parent_comm), task->real_parent->comm);

    // Send data to user-space
    events.perf_submit(args, &data, sizeof(data));

    return 0;

}

"""

# Load the BPF program
bpf = BPF(text=bpf_program)

# File to store findings
output_file = "findings.json"
findings = {"findings": []}

# Save findings to JSON
def save_to_file(data):
    with open(output_file, "w") as f:
        json.dump(data, f, indent=4)

# Print catched event
def print_event(cpu, data, size):
    timestamp = datetime.utcnow().isoformat() + "Z"
    event = bpf["events"].event(data)
    print(f"child PID: {event.pid}, child process: {event.comm}, child uid: {event.uid}, parent process: {event.parent_comm}")

    if "malicious" in str(event.comm):
    # Append to findings
        findings["findings"].append({
            "PID": str(event.pid),
            "user": str(event.uid),
            "path": str(event.comm),
            "parentPath": str(event.parent_comm),
            "timestamp": str(timestamp)
        })
        print("Malicious file was detected")
        save_to_file(findings)

# Set up perf buffer
bpf["events"].open_perf_buffer(print_event)

# Print the output header
print("Tracking child processes (sys_exit_execve) calls... Press Ctrl-C to exit")

# Read buffer
try:
    while True:
        bpf.perf_buffer_poll()
except KeyboardInterrupt:
    print("Exiting. Findings saved to the file findings.json.")


