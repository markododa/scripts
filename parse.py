#!/usr/bin/python
lines = open('kanali.txt', 'r').readlines()
out = open('out.txt', 'w')

while True:
	chunk, lines = lines[:4], lines[4:]
	if not chunk:
		break
	name, _, freq, _ = chunk
	out.write('{%s} %s 0 {0} 0\n' % (name.strip(), freq.strip()))
out.close()
