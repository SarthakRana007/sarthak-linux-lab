# sarthak-linux-lab
Hands-on Linux, Bash and Git labs from Phase 1 of my DevOps roadmap. Each lab records what I built and how I verified it. Problems I hit along the way are in [INCIDENTS.md](INCIDENTS.md).

## Lab setup
| VM | Hostname | IP | Role |
|---|---|---|---|
| Server | Thakur | 192.168.56.10 | Runs services; hosts this repo |
| Client | ubuntu-client | 192.168.56.11 | Connects to the server |

VirtualBox, Ubuntu 26.04 LTS. Both VMs share a host-only network; a NAT adapter gives internet access. Snapshot `clean-baseline` taken after setup.

## Repo layout
- `scripts/`: Bash scripts
- `configs/`: config files used in the labs
- `INCIDENTS.md`: troubleshooting log (symptom → cause → fix → proof)

## Lab 1: Two-VM lab
- Cloned the server into a client VM and gave it a new hostname, machine ID and SSH host keys so the two don't clash
- Set static IPs with netplan on the host-only adapter
- Verified with ping in both directions, then took the `clean-baseline` snapshot
- Added `attacker` and `topattack` from the Linux Upskill Challenge to `scripts/`

## Lab 2: SSH hardening
Server `Thakur`, accessed from `ubuntu-client`.

**Changes**
- Key-only login with an ed25519 key from the client
- Password and keyboard-interactive login disabled
- Direct root login disabled
- SSH moved from port 22 to 2222 (applied with `daemon-reload` + `restart ssh.socket`)
- Firewall: 2222/tcp allowed, port 22 (OpenSSH) removed

**Config:** `configs/10-hardening.conf`, installed in `/etc/ssh/sshd_config.d/`. It's named `10-` so it's read before `50-cloud-init.conf`, because SSH uses the first value it finds.

**Verification (from the client)**
| Test | Result |
|---|---|
| `ssh -p 2222 rana@192.168.56.10` | Logs in with the key |
| `ssh -p 2222 -o PubkeyAuthentication=no rana@...` | Permission denied |
| `ssh -p 2222 root@...` | Permission denied |
| `ssh rana@192.168.56.10` (port 22) | Connection refused |
| `sudo sshd -T` on the server | port 2222, passwordauthentication no, permitrootlogin no |
