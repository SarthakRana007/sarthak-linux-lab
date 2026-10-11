# Incidents

symptom → cause → fix → proof

## 2026-10-11 · SadServers "Saint John" (Easy)
- **Symptom:** /var/log/bad.log kept growing and filling the disk
- **Cause:** a leftover test program (PID 595, /usr/bin/python3 /home/admin/badlog.py) was writing to it
- **Fix:** found the PID with `ps aux` (badlog.py stood out by name), stopped it with `kill 595`
- **Proof:** `ls -l` showed the size stopped changing; SadServers check passed
