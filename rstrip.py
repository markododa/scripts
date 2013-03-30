#!/usr/bin/python
data = open('input.txt', 'r')
out = open('output.txt', 'w').readlines()
for line in lines:
  out.write(line.rstrip()+'\n')
data.close()
out.close()
