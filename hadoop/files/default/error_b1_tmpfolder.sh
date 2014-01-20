# Error B-1: 'tmpfolder'

# Description: revert Hadoop temporary directory owner to 'root'

# Injection point: right after Step 7 - 'create_tmp_dir'

# Influence: will NOT break Hadoop installation sequence
#            can only be detected as early as when Hadoop format the namenode => don't have permission to write to tmp folder

sudo chown root:root /app/hadoop/tmp
