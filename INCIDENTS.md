# Incidents

symptom → cause → fix → proof

## 2026-10-11 · SadServers "Saint John" (Easy)
- **Symptom:** /var/log/bad.log kept growing and filling the disk
- **Cause:** a leftover test program (PID 595, /usr/bin/python3 /home/admin/badlog.py) was writing to it
- **Fix:** found the PID with `ps aux` (badlog.py stood out by name), stopped it with `kill 595`
- **Proof:** `ls -l` showed the size stopped changing; SadServers check passed

## 2026-10-11 · SadServers "Saskatoon" (Easy)
- **Task:** find the IP with the most requests in /home/admin/access.log
- **Approach:** `awk '{print $1}' access.log | sort | uniq -c | sort -rn | head -n 1`
- **Answer:** 66.249.73.135 (482 requests), saved to highestip.txt
- **Proof:** SadServers check passed
- **Lesson:** `uniq -c` only counts duplicates that sit next to each other, so the IPs must be sorted first
