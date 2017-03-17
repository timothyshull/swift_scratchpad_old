import os, time
import difflib

curr_dir = os.getcwd()

path_to_watch = '{0}/MainWindowController.xib'.format(curr_dir)

prev_mtime = os.path.getmtime(path_to_watch)
prev_text = None

with open(path_to_watch) as f:
    prev_text = f.read().splitlines()

diff_num = 1

while 1:
    time.sleep(10)
    curr_mtime = os.path.getmtime(path_to_watch)
    if curr_mtime != prev_mtime:
        diff = None
        with open(path_to_watch) as f:
            curr_text = f.read().splitlines()
            diff = difflib.unified_diff(prev_text, curr_text)
            prev_tet = curr_text
        with open('{0}/MainWindowController_diff_{1}.txt'.format(curr_dir, diff_num), 'w') as f:
            f.write('\n'.join(list(diff)))
        diff_num += 1
    prev_mtime = curr_mtime
