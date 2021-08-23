#!/usr/bin/env python

from subprocess import check_output

def get_pass():
  return check_output("/usr/bin/pass show gmail", shell=True).splitlines()[0]

