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

## 2026-10-12 · Lab 2: ran client tests on the server
- **Symptom:** tests gave confusing results: `Permission denied (publickey)` for my own user, and `Bad port '-o'`
- **Cause:** my first `ssh` logged me into the server and I didn't `exit`, so the "client" tests ran on the server (the prompt showed `rana@Thakur`). The server has no key for itself and passwords are off, so it denied me. `Bad port` came from missing `2222` after `-p`.
- **Fix:** ran `exit` to get back to the client (prompt `rana@ubuntu-client`), then reran the tests with `-p 2222`
- **Proof:** key login works from the client; password and root login are refused; port 22 is refused
- **Lesson:** check the prompt before every command, so you know which machine you're on

## 2026-10-28 · Lab 6: service failed with "Permission denied"
- **Symptom:** `sudo systemctl start lab6-a` failed with "control process exited with error code". `journalctl -u lab6-a` showed `/usr/local/bin/time.sh: line 5: /tmp/today.txt: Permission denied`. The same script worked fine when I ran it by hand.
- **Cause:** I created `/tmp/today.txt` while testing as `rana`. The service runs as root. In `/tmp` (shared by all users), the `fs.protected_regular` rule blocks even root from writing to a file owned by another user, so the service was refused.
- **Fix:** moved the log to `/var/log/today.txt`, the standard place for service logs, copied the updated script to `/usr/local/bin`, and removed the old stray log.
- **Proof:** `systemctl status lab6-a` shows "Deactivated successfully" and "Finished lab6-a.service"; `cat /var/log/today.txt` shows the new line.
- **Lesson:** a script that works by hand can fail under systemd because the service runs as a different user, from a different folder, with different permissions. Always check which user runs it and who owns the files it touches.
