from sh import tail
# runs forever
for line in tail("-f", "/var/log/messages", _iter=True):
   if 'printme' in line:
       print(line)
