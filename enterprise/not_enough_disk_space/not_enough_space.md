# Cleaning Disk Space Used by Supervisely
Supervisely has robust automatic cleanup services built into it which prevent the platform from taking up unnecessary storage space. But you can always check the storage manually with the following command:


```df -hT /
df -hT $(sudo supervisely where data)```
